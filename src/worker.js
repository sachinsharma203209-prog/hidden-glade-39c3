/**
 * Cloudflare Worker — Font Changer SEO Platform
 *
 * Single-page SSR application:
 *  - D1 = source of truth for SEO data
 *  - Worker = rendering layer
 *  - FontChangerTool = one reusable client-side tool
 *
 * Dynamic routes:
 *  /font-changer                  → core page
 *  /font-changer/{attribute}     → attribute page
 *  /sitemap.xml                   → dynamic XML sitemap
 *  /robots.txt                    → robots.txt
 *  /*                             → 404
 */

import { escapeHtml, normalizePath, canonicalUrl, buildBreadcrumbs, breadcrumbJsonLd, webAppJsonLd, webPageJsonLd, faqJsonLd } from './utils/helpers.js';

// ─────────────────────────────────────────────────────────────────
// ROUTING TABLE
// ─────────────────────────────────────────────────────────────────
// Routes are resolved from D1, not hardcoded.
// The expected URL patterns:
//   /font-changer                    → core seo_pages slug = 'font-changer'
//   /font-changer/{slug}            → seo_pages slug = 'font-changer/{slug}'
//
// Any path not matching a published, indexable (or valid) seo_pages record
// returns 404.

const ROUTE_PREFIX = '/font-changer';

// ─────────────────────────────────────────────────────────────────
// MAIN FETCH HANDLER
// ─────────────────────────────────────────────────────────────────

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    const path = normalizePath(url.pathname);
    const method = request.method;
    const baseUrl = (env.BASE_URL || 'https://font-changer.example.com').replace(/\/+$/, '');

    // Only GET and HEAD are handled
    if (method !== 'GET' && method !== 'HEAD') {
      return new Response('Method Not Allowed', { status: 405, headers: { 'Allow': 'GET, HEAD' } });
    }

    // ── Robots.txt ──────────────────────────────────────────────
    if (path === '/robots.txt') {
      return robotsTxtResponse(env);
    }

    // ── Sitemap.xml (check BEFORE normalizePath strips leading slash)
    // path looks like '/sitemap.xml' before normalization strips the slash
    if (url.pathname === '/sitemap.xml' || url.pathname === '/sitemap' || url.pathname === '/sitemap.xml/') {
      return sitemapResponse(env);
    }

    // ── Health check / simple ping ──────────────────────────────
    if (path === '/health') {
      return new Response(JSON.stringify({ status: 'ok', env: env.APP_ENV || 'unknown' }), {
        status: 200,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    // ── Root redirect ───────────────────────────────────────────
    if (path === '' || path === '/') {
      const target = canonicalUrl(baseUrl, 'font-changer');
      return new Response(null, {
        status: 301,
        headers: { Location: target },
      });
    }

    // ── Resolve SEO page from path ──────────────────────────────
    // The path should match a seo_pages.slug exactly.
    // Path examples: "/font-changer", "/font-changer/instagram", "/font-changer/hindi", etc.

    const db = env.FONT_CHANGER_DB;
    if (!db) {
      return new Response('Database not configured', { status: 500 });
    }

    // Check redirects first
    const redirect = await db.prepare('SELECT destination_path, status_code FROM redirects WHERE source_path = ?')
      .bind(path)
      .first();

    if (redirect) {
      return new Response(null, {
        status: redirect.status_code || 301,
        headers: { Location: redirect.destination_path },
      });
    }

    // Fetch the SEO page record
    const page = await db.prepare(`
      SELECT
        sp.id,
        sp.slug,
        sp.page_type,
        sp.title,
        sp.meta_description,
        sp.h1,
        sp.intro,
        sp.canonical_url,
        sp.indexable,
        sp.follow_links,
        sp.robots,
        sp.status,
        sp.updated_at,
        e.id AS entity_id,
        e.slug AS entity_slug,
        e.name AS entity_name,
        e.description AS entity_description,
        a.id AS attribute_id,
        a.slug AS attribute_slug,
        a.name AS attribute_name,
        a.description AS attribute_description,
        ag.slug AS group_slug,
        ag.name AS group_name
      FROM seo_pages sp
      LEFT JOIN entities e ON sp.entity_id = e.id
      LEFT JOIN attributes a ON sp.attribute_id = a.id
      LEFT JOIN attribute_groups ag ON a.group_id = ag.id
      WHERE sp.slug = ?
    `).bind(path).first();

    // ── Page not found ──────────────────────────────────────────
    if (!page) {
      const notFoundHtml = renderNotFound(path, env);
      return new Response(notFoundHtml, {
        status: 404,
        headers: {
          'Content-Type': 'text/html; charset=utf-8',
          'Cache-Control': 'no-cache',
        },
      });
    }

    // ── Page not published ──────────────────────────────────────
    if (page.status !== 'published') {
      return new Response('Not Found', { status: 404 });
    }

    // ── Fetch FAQs for this page ────────────────────────────────
    const faqs = await db.prepare(`
      SELECT question, answer FROM faqs WHERE page_id = ? ORDER BY sort_order ASC
    `).bind(page.id).all();

    // ── Fetch related pages ─────────────────────────────────────
    // Related pages = same entity, other attributes from related groups,
    // plus the core page. Excludes current page.
    const relatedPages = await getRelatedPages(db, page);

    // ── Render the page ─────────────────────────────────────────
    const html = renderSeoPage(page, faqs.results || [], relatedPages, env);

    // ── Response headers ────────────────────────────────────────
    const robotsValue = page.robots || 'index,follow';
    const isIndexable = page.indexable === 1;

    const headers = {
      'Content-Type': 'text/html; charset=utf-8',
      'Cache-Control': isIndexable
        ? 'public, max-age=300, s-maxage=600'   // 5 min CDN, 10 min edge
        : 'no-cache, no-store',
      'Vary': 'Accept-Encoding',
      'X-Robots-Tag': robotsValue,
    };

    // Add canonical if not set in DB
    let canonical = page.canonical_url;
    if (!canonical) {
      canonical = canonicalUrl(page.slug);
    }
    headers['Link'] = `<${canonical}>; rel="canonical"`;

    return new Response(html, { status: 200, headers });
  },
};

// ─────────────────────────────────────────────────────────────────
// RELATED PAGES QUERY
// ─────────────────────────────────────────────────────────────────
// Get topically relevant pages for internal linking:
//  1. The core font-changer page
//  2. Other attributes from the same entity, preferring same group
//  3. Limited to a reasonable count
async function getRelatedPages(db, currentPage) {
  const results = [];

  // 1. Always include the core page (if not current)
  if (currentPage.slug !== 'font-changer') {
    const core = await db.prepare(`
      SELECT id, slug, title, h1, intro
      FROM seo_pages
      WHERE slug = 'font-changer' AND status = 'published' AND indexable = 1
      LIMIT 1
    `).first();
    if (core) results.push(core);
  }

  // 2. Same entity, same group, different attribute
  const sameGroup = await db.prepare(`
    SELECT DISTINCT sp.id, sp.slug, sp.title, sp.h1, sp.intro
    FROM seo_pages sp
    JOIN attributes a ON sp.attribute_id = a.id
    JOIN attribute_groups ag ON a.group_id = ag.id
    WHERE sp.entity_id = ?
      AND sp.id != ?
      AND sp.status = 'published'
      AND sp.indexable = 1
      AND ag.id = ?
    ORDER BY ag.sort_order ASC, a.sort_order ASC
    LIMIT 8
  `).bind(currentPage.entity_id, currentPage.id, currentPage.attribute_id ? currentPage.attribute_id : 0).all();

  results.push(...(sameGroup.results || []));

  // 3. Same entity, different group (fill up to 12 total)
  if (results.length < 12) {
    const otherGroup = await db.prepare(`
      SELECT DISTINCT sp.id, sp.slug, sp.title, sp.h1, sp.intro
      FROM seo_pages sp
      JOIN attributes a ON sp.attribute_id = a.id
      JOIN attribute_groups ag ON a.group_id = ag.id
      WHERE sp.entity_id = ?
        AND sp.id != ?
        AND sp.status = 'published'
        AND sp.indexable = 1
        AND (ag.id != ? OR ? IS NULL)
      ORDER BY ag.sort_order ASC, a.sort_order ASC
      LIMIT 12
    `).bind(currentPage.entity_id, currentPage.id, currentPage.attribute_id || null, currentPage.attribute_id || null).all();

    const existingSlugs = new Set(results.map(r => r.slug));
    for (const row of (otherGroup.results || [])) {
      if (!existingSlugs.has(row.slug)) {
        results.push(row);
        existingSlugs.add(row.slug);
        if (results.length >= 12) break;
      }
    }
  }

  return results.slice(0, 12);
}

// ─────────────────────────────────────────────────────────────────
// ROBOTS.TXT
// ─────────────────────────────────────────────────────────────────
function robotsTxtResponse(env) {
  const base = (env.BASE_URL || 'https://font-changer.example.com').replace(/\/+$/, '');
  const content = [
    'User-agent: *',
    'Allow: /',
    '',
    'Sitemap: ' + base + '/sitemap.xml',
    '',
  ].join('\n');

  return new Response(content, {
    status: 200,
    headers: {
      'Content-Type': 'text/plain; charset=utf-8',
      'Cache-Control': 'public, max-age=86400',
    },
  });
}

// ─────────────────────────────────────────────────────────────────
// SITEMAP.XML
// ─────────────────────────────────────────────────────────────────
async function sitemapResponse(env) {
  const db = env.FONT_CHANGER_DB;
  const base = (env.BASE_URL || 'https://font-changer.example.com').replace(/\/+$/, '');

  // Only published + indexable pages
  const pages = await db.prepare(`
    SELECT slug, updated_at
    FROM seo_pages
    WHERE status = 'published' AND indexable = 1
    ORDER BY slug ASC
  `).all();

  const items = (pages.results || []).map(p => {
    const loc = base + '/' + p.slug;
    const lastmod = p.updated_at || new Date().toISOString().slice(0, 10);
    return '  <url>\n    <loc>' + escapeXml(loc) + '</loc>\n    <lastmod>' + escapeXml(lastmod) + '</lastmod>\n    <changefreq>weekly</changefreq>\n    <priority>0.8</priority>\n  </url>';
  });

  const xml = '<?xml version="1.0" encoding="UTF-8"?>\n' +
    '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n' +
    items.join('\n') + '\n</urlset>';

  return new Response(xml, {
    status: 200,
    headers: {
      'Content-Type': 'application/xml; charset=utf-8',
      'Cache-Control': 'public, max-age=3600',
    },
  });
}

/**
 * Minimal XML escaping (only for sitemap output).
 */
function escapeXml(str) {
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
}

// ─────────────────────────────────────────────────────────────────
// RENDER: SEO PAGE
// ─────────────────────────────────────────────────────────────────
function renderSeoPage(page, faqs, relatedPages, env) {
  const base = (env.BASE_URL || 'https://font-changer.example.com').replace(/\/+$/, '');
  const isIndexable = page.indexable === 1;
  const canonical = page.canonical_url || canonicalUrl(page.slug);
  const robotsValue = page.robots || (isIndexable ? 'index,follow' : 'noindex,follow');

  // Breadcrumbs
  const crumbs = buildBreadcrumbs(page.entity_name ? { slug: page.entity_slug, name: page.entity_name } : null,
                                    page.attribute_name ? { slug: page.attribute_slug, name: page.attribute_name } : null);

  // JSON-LD
  const breadcrumbLd = breadcrumbJsonLd(crumbs);
  const webAppLd = webAppJsonLd(base);
  const webPageLd = webPageJsonLd(page.title, page.meta_description || '', canonical);
  const faqLd = faqJsonLd(faqs);

  // Related pages HTML
  const relatedHtml = relatedPages.map(rp => {
    const rpCanonical = rp.canonical_url || canonicalUrl(rp.slug);
    return '<a href="' + escapeHtml(rpCanonical) + '" class="related-page-link">' + escapeHtml(rp.title) + '</a>';
  }).join('\n');

  // FAQ HTML
  const faqHtml = faqs.map(f => {
    return '<div class="faq-item">' +
      '<h3 class="faq-question">' + escapeHtml(f.question) + '</h3>' +
      '<div class="faq-answer">' + escapeHtml(f.answer) + '</div>' +
    '</div>';
  }).join('\n');

  // Group info (if attribute)
  const groupInfoHtml = page.group_name ? `
    <section class="attribute-info-section">
      <h2>About ${escapeHtml(page.group_name)}</h2>
      <p>${escapeHtml(page.attribute_description ? page.attribute_description : `Use the Font Changer to create stylish text for ${escapeHtml(page.attribute_name)}.`)}</p>
    </section>
  ` : '';

  // Entity description
  const entityDescHtml = page.entity_description ? `
    <p class="entity-description">${escapeHtml(page.entity_description)}</p>
  ` : '';

  const html = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${escapeHtml(page.title)}</title>
  <meta name="description" content="${escapeHtml(page.meta_description || '')}">
  <meta name="robots" content="${escapeHtml(robotsValue)}">
  <link rel="canonical" href="${escapeHtml(canonical)}">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>${cssStyles()}</style>
  <script type="application/ld+json">${webAppLd}</script>
  <script type="application/ld+json">${webPageLd}</script>
  <script type="application/ld+json">${breadcrumbLd}</script>
  ${faqLd ? '<script type="application/ld+json">' + faqLd + '</script>' : ''}
</head>
<body>
  <header class="site-header">
    <nav class="site-nav" aria-label="Primary">
      <div class="nav-container">
        <a href="${escapeHtml(canonicalUrl('font-changer'))}" class="brand">Font Changer</a>
        <div class="nav-links">
          <a href="${escapeHtml(canonicalUrl('font-changer/instagram'))}">Instagram</a>
          <a href="${escapeHtml(canonicalUrl('font-changer/facebook'))}">Facebook</a>
          <a href="${escapeHtml(canonicalUrl('font-changer/whatsapp'))}">WhatsApp</a>
          <a href="${escapeHtml(canonicalUrl('font-changer/hindi'))}">Hindi</a>
          <a href="${escapeHtml(canonicalUrl('font-changer/bold'))}">Bold</a>
        </div>
      </div>
    </nav>
  </header>

  <main class="site-main">
    <!-- Breadcrumb -->
    <nav aria-label="Breadcrumb" class="breadcrumb-nav">
      <ol class="breadcrumb-list">
        ${crumbs.map((c, i) => `
          <li class="breadcrumb-item">
            ${i < crumbs.length - 1
              ? '<a href="' + escapeHtml(c.url) + '">' + escapeHtml(c.label) + '</a>'
              : '<span class="breadcrumb-current" aria-current="page">' + escapeHtml(c.label) + '</span>'
            }
            ${i < crumbs.length - 1 ? '<span class="breadcrumb-separator" aria-hidden="true">/</span>' : ''}
          </li>
        `).join('\n        ')}
      </ol>
    </nav>

    <!-- H1 + Intro -->
    <article class="seo-article">
      <header class="article-header">
        <h1 class="article-h1">${escapeHtml(page.h1 || page.title)}</h1>
        ${entityDescHtml}
        ${page.intro ? '<p class="article-intro">' + escapeHtml(page.intro) + '</p>' : ''}
      </header>

      <!-- Font Changer Tool (reusable, same on every page) -->
      <section class="font-changer-tool-section" aria-label="Font Changer Tool">
        ${fontChangerToolHtml()}
      </section>

      <!-- How the tool works -->
      <section class="how-it-works-section">
        <h2>How the Font Changer Works</h2>
        <p>Type or paste any text into the input box above. The tool instantly generates all available Unicode font styles below. Each style has a <strong>Copy</strong> button — tap it to copy that style to your clipboard. You can also press <strong>Copy All</strong> to copy every style at once, separated by lines.</p>
        <p>The styles use Unicode characters, which means the result is plain text — not an image or a downloadable font file. You can paste it into any app, website, or social media platform that supports Unicode text.</p>
        ${page.attribute_name ? `
        <p>For <strong>${escapeHtml(page.attribute_name)}</strong>, these font styles help you create a unique look for your profile, posts, messages, or gaming name.</p>
        ` : ''}
      </section>

      <!-- Use cases -->
      <section class="use-cases-section">
        <h2>Common Use Cases</h2>
        <div class="use-cases-grid">
          ${useCasesGridHtml()}
        </div>
      </section>

      <!-- Attribute-specific info -->
      ${groupInfoHtml}

      <!-- Examples section -->
      <section class="examples-section">
        <h2>Styled Text Examples</h2>
        <div class="examples-grid">
          ${examplesGridHtml(page.attribute_name)}
        </div>
      </section>

      <!-- FAQ -->
      ${faqs.length > 0 ? `
      <section class="faq-section">
        <h2>Frequently Asked Questions</h2>
        <div class="faq-list">
          ${faqHtml}
        </div>
      </section>
      ` : ''}

      <!-- Related Tools -->
      <section class="related-section">
        <h2>Related Font Tools</h2>
        <div class="related-links">
          <a href="${escapeHtml(canonicalUrl('font-changer/instagram'))}">Font Changer for Instagram</a>
          <a href="${escapeHtml(canonicalUrl('font-changer/facebook'))}">Font Changer for Facebook</a>
          <a href="${escapeHtml(canonicalUrl('font-changer/whatsapp'))}">Font Changer for WhatsApp</a>
          <a href="${escapeHtml(canonicalUrl('font-changer/twitter'))}">Font Changer for Twitter / X</a>
          <a href="${escapeHtml(canonicalUrl('font-changer/hindi'))}">Hindi Font Changer</a>
          <a href="${escapeHtml(canonicalUrl('font-changer/bold'))}">Bold Font Changer</a>
          <a href="${escapeHtml(canonicalUrl('font-changer/cursive'))}">Cursive Font Changer</a>
          <a href="${escapeHtml(canonicalUrl('font-changer/fancy'))}">Fancy Font Changer</a>
        </div>
      </section>

      <!-- Related Pages (from D1) -->
      ${relatedHtml ? `
      <section class="related-pages-section">
        <h2>More Font Changer Pages</h2>
        <div class="related-pages-links">
          ${relatedHtml}
        </div>
      </section>
      ` : ''}
    </article>
  </main>

  <footer class="site-footer">
    <div class="footer-container">
      <p>&copy; 2026 Font Changer. All font styles are generated using Unicode characters — not downloadable font files.</p>
      <nav class="footer-nav">
        <a href="${escapeHtml(canonicalUrl('font-changer'))}">Font Changer Home</a>
        <a href="${escapeHtml(canonicalUrl('font-changer/instagram'))}">Instagram Font</a>
        <a href="${escapeHtml(canonicalUrl('font-changer/facebook'))}">Facebook Font</a>
        <a href="${escapeHtml(canonicalUrl('font-changer/whatsapp'))}">WhatsApp Font</a>
      </nav>
    </div>
  </footer>

  <!-- Reusable Font Changer Tool Scripts -->
  <script src="${escapeHtml(base + '/font-changer-engine.js')}"></script>
  <script src="${escapeHtml(base + '/font-changer-tool.js')}"></script>
</body>
</html>`;

  return html;
}

// ─────────────────────────────────────────────────────────────────
// RENDER: NOT FOUND (404)
// ─────────────────────────────────────────────────────────────────
function renderNotFound(requestedPath, env) {
  const base = (env.BASE_URL || 'https://font-changer.example.com').replace(/\/+$/, '');
  const canonicalBase = canonicalUrl('font-changer');

  return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Page Not Found — Font Changer</title>
  <meta name="robots" content="noindex,follow">
  <link rel="canonical" href="${escapeHtml(canonicalBase)}">
  <style>${cssStyles()}</style>
</head>
<body>
  <header class="site-header">
    <nav class="site-nav" aria-label="Primary">
      <div class="nav-container">
        <a href="${escapeHtml(canonicalBase)}" class="brand">Font Changer</a>
      </div>
    </nav>
  </header>
  <main class="site-main">
    <div class="not-found-container">
      <h1>404 — Page Not Found</h1>
      <p>The page you're looking for doesn't exist.</p>
      <p>The URL <code>${escapeHtml(requestedPath)}</code> returned no result.</p>
      <p><a href="${escapeHtml(canonicalBase)}" class="btn-primary">Go to Font Changer Home</a></p>
    </div>
  </main>
  <footer class="site-footer">
    <div class="footer-container">
      <p>&copy; 2026 Font Changer</p>
    </div>
  </footer>
</body>
</html>`;
}

// ─────────────────────────────────────────────────────────────────
//_FONT CHANGER TOOL HTML (REUSABLE)
// ─────────────────────────────────────────────────────────────────
function fontChangerToolHtml() {
  return `
  <div class="font-changer-tool">
    <div class="tool-header">
      <h2>Font Changer</h2>
      <p class="tool-subtitle">Type text below to generate all font styles instantly.</p>
    </div>

    <div class="tool-input-row">
      <label for="font-input" class="sr-only">Enter your text</label>
      <input
        type="text"
        id="font-input"
        class="font-input"
        placeholder="Type or paste your text here..."
        autocomplete="off"
        spellcheck="false"
        maxlength="500"
      >
      <div class="tool-input-actions">
        <button type="button" id="clear-btn" class="btn-secondary" aria-label="Clear text">Clear</button>
      </div>
    </div>

    <div class="tool-result-meta">
      <span id="output-count" class="output-count">0</span>
      <span class="output-count-label">characters</span>
      <span class="output-stats" id="stats"></span>
    </div>

    <div id="font-outputs" class="font-outputs" aria-live="polite" aria-atomic="false">
      <div class="font-output-placeholder">Type something above to see all font styles</div>
    </div>

    <div class="tool-footer">
      <button type="button" id="copy-all-btn" class="btn-primary" aria-label="Copy all font styles">
        <span class="copy-all-text">Copy All</span>
      </button>
      <p class="tool-note">Font styles are Unicode text — copy and paste anywhere. Not downloadable font files.</p>
    </div>
  </div>`;
}

// ─────────────────────────────────────────────────────────────────
// USE CASES GRID
// ─────────────────────────────────────────────────────────────────
function useCasesGridHtml() {
  const useCases = [
    { label: 'Username', desc: 'Stylish usernames for social media, gaming, and profiles.' },
    { label: 'Nickname', desc: 'Fun and unique nicknames for chats and online handles.' },
    { label: 'Bio', desc: 'Eye-catching bio text for Instagram, WhatsApp, Discord, and more.' },
    { label: 'Caption', desc: 'Fancy captions for social media posts and images.' },
    { label: 'Status', desc: 'Custom status text for WhatsApp, Discord, and other platforms.' },
    { label: 'Comment', desc: 'Stand-out comments for YouTube, Instagram, Facebook, and Twitch.' },
    { label: 'Gaming Name', desc: 'Bold and cool gamertags for Free Fire, PUBG, Roblox, and more.' },
    { label: 'Profile Name', desc: 'Unique profile names for any social media or gaming platform.' },
    { label: 'Clan Name', desc: 'Fancy clan and guild names for gaming communities.' },
    { label: 'Post', desc: 'Stylized text for social media posts and updates.' },
  ];

  return useCases.map(uc => `
    <div class="use-case-card">
      <div class="use-case-icon" aria-hidden="true">U</div>
      <div class="use-case-info">
        <span class="use-case-label">${uc.label}</span>
        <span class="use-case-desc">${uc.desc}</span>
      </div>
    </div>
  `).join('\n');
}

// ─────────────────────────────────────────────────────────────────
// EXAMPLES GRID
// ─────────────────────────────────────────────────────────────────
function examplesGridHtml(attributeName) {
  const examples = [
    'Font Changer',
    'Stylish Text Generator',
    'Copy & Paste Fonts',
    'Fancy Bio Text',
    'Cool Username Style',
    'Bold Gaming Name',
  ];

  const prefix = attributeName ? attributeName + ' ' : '';
  const items = examples.map(ex => {
    const styled = ex;
    return `
      <div class="example-card">
        <div class="example-label">${prefix}${ex}</div>
        <div class="example-styled">${styled}</div>
      </div>
    `;
  }).join('\n');

  return items;
}

// ─────────────────────────────────────────────────────────────────
// CSS STYLES (inlined into every page — minimal, fast)
// ─────────────────────────────────────────────────────────────────
function cssStyles() {
  return `
/* ===== Font Changer SEO — Global Styles ===== */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

:root {
  --color-bg: #0f0c29;
  --color-bg-secondary: #302b63;
  --color-bg-card: #241e47;
  --color-primary: #00d4aa;
  --color-primary-hover: #00e8bb;
  --color-text: #e8e4f0;
  --color-text-secondary: #a89bb5;
  --color-text-muted: #7a6d94;
  --color-border: #3d3566;
  --color-white: #ffffff;
  --font-sans: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  --font-mono: 'Courier New', monospace;
  --radius-sm: 6px;
  --radius-md: 10px;
  --radius-lg: 16px;
  --shadow-card: 0 2px 12px rgba(0,0,0,0.4);
  --shadow-glow: 0 0 20px rgba(0,212,170,0.15);
}

html { font-size: 16px; scroll-behavior: smooth; }

body {
  font-family: var(--font-sans);
  background: var(--color-bg);
  color: var(--color-text);
  line-height: 1.6;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

/* ===== Header ===== */
.site-header {
  background: var(--color-bg-secondary);
  border-bottom: 1px solid var(--color-border);
  position: sticky;
  top: 0;
  z-index: 100;
}

.site-nav {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.nav-container {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 56px;
}

.brand {
  font-size: 1.25rem;
  font-weight: 700;
  color: var(--color-primary);
  text-decoration: none;
  letter-spacing: -0.01em;
}

.nav-links {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
}

.nav-links a {
  color: var(--color-text-secondary);
  text-decoration: none;
  font-size: 0.875rem;
  font-weight: 500;
  padding: 4px 8px;
  border-radius: var(--radius-sm);
  transition: color 0.15s, background 0.15s;
}

.nav-links a:hover {
  color: var(--color-primary);
  background: rgba(0,212,170,0.08);
}

/* ===== Breadcrumbs ===== */
.breadcrumb-nav {
  max-width: 1200px;
  margin: 0 auto;
  padding: 16px 20px 0;
}

.breadcrumb-list {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  list-style: none;
  gap: 4px;
}

.breadcrumb-item {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 0.8125rem;
}

.breadcrumb-item a {
  color: var(--color-text-secondary);
  text-decoration: none;
}

.breadcrumb-item a:hover {
  color: var(--color-primary);
}

.breadcrumb-current {
  color: var(--color-text);
  font-weight: 500;
}

.breadcrumb-separator {
  color: var(--color-text-muted);
  user-select: none;
}

/* ===== Main Layout ===== */
.site-main {
  flex: 1;
  max-width: 1200px;
  margin: 0 auto;
  padding: 24px 20px 40px;
  width: 100%;
}

.seo-article {
  display: flex;
  flex-direction: column;
  gap: 32px;
}

/* ===== Typography ===== */
.article-header {
  margin-bottom: 4px;
}

.article-h1 {
  font-size: clamp(1.75rem, 4vw, 2.5rem);
  font-weight: 700;
  color: var(--color-primary);
  line-height: 1.2;
  letter-spacing: -0.02em;
  margin-bottom: 12px;
}

.article-intro {
  font-size: 1.0625rem;
  color: var(--color-text);
  line-height: 1.7;
  max-width: 720px;
}

.entity-description {
  font-size: 0.9375rem;
  color: var(--color-text-secondary);
  font-style: italic;
  margin-bottom: 16px;
}

h2 {
  font-size: 1.375rem;
  font-weight: 600;
  color: var(--color-text);
  margin-bottom: 12px;
  letter-spacing: -0.01em;
}

h3 {
  font-size: 1.125rem;
  font-weight: 600;
  color: var(--color-text);
  margin-bottom: 8px;
}

p {
  color: var(--color-text-secondary);
  line-height: 1.7;
}

/* ===== Font Changer Tool (CORE COMPONENT) ===== */
.font-changer-tool {
  background: var(--color-bg-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  padding: 24px;
  box-shadow: var(--shadow-card);
}

.tool-header {
  text-align: center;
  margin-bottom: 20px;
}

.tool-header h2 {
  font-size: 1.5rem;
  color: var(--color-primary);
  margin-bottom: 4px;
}

.tool-subtitle {
  font-size: 0.9375rem;
  color: var(--color-text-secondary);
}

.tool-input-row {
  display: flex;
  gap: 12px;
  margin-bottom: 8px;
}

.font-input {
  flex: 1;
  padding: 14px 16px;
  background: var(--color-bg-secondary);
  border: 2px solid var(--color-border);
  border-radius: var(--radius-md);
  color: var(--color-text);
  font-size: 1rem;
  font-family: var(--font-sans);
  outline: none;
  transition: border-color 0.2s, box-shadow 0.2s;
}

.font-input:focus {
  border-color: var(--color-primary);
  box-shadow: 0 0 0 3px rgba(0,212,170,0.15);
}

.font-input::placeholder {
  color: var(--color-text-muted);
}

.tool-input-actions {
  display: flex;
  gap: 8px;
  align-items: flex-start;
}

.btn-secondary {
  padding: 10px 18px;
  background: transparent;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  color: var(--color-text-secondary);
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.15s;
  white-space: nowrap;
}

.btn-secondary:hover {
  border-color: var(--color-primary);
  color: var(--color-primary);
  background: rgba(0,212,170,0.06);
}

.btn-primary {
  padding: 12px 24px;
  background: var(--color-primary);
  border: none;
  border-radius: var(--radius-md);
  color: var(--color-bg);
  font-size: 0.9375rem;
  font-weight: 600;
  cursor: pointer;
  transition: background 0.15s, transform 0.1s;
  display: inline-flex;
  align-items: center;
  gap: 8px;
}

.btn-primary:hover {
  background: var(--color-primary-hover);
}

.btn-primary:active {
  transform: scale(0.98);
}

.btn-primary:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  transform: none;
}

.tool-result-meta {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 16px;
  font-size: 0.8125rem;
  color: var(--color-text-muted);
}

.output-count {
  font-weight: 600;
  color: var(--color-primary);
  font-size: 1rem;
}

.output-count-label {
  color: var(--color-text-secondary);
}

.output-stats {
  margin-left: auto;
  color: var(--color-text-muted);
  font-size: 0.8125rem;
}

/* ===== Font Outputs ===== */
.font-outputs {
  display: flex;
  flex-direction: column;
  gap: 8px;
  max-height: 400px;
  overflow-y: auto;
  padding: 4px 0;
  scrollbar-width: thin;
  scrollbar-color: var(--color-border) transparent;
}

.font-outputs::-webkit-scrollbar {
  width: 6px;
}

.font-outputs::-webkit-scrollbar-track {
  background: transparent;
}

.font-outputs::-webkit-scrollbar-thumb {
  background: var(--color-border);
  border-radius: 3px;
}

.font-output-item {
  display: flex;
  flex-direction: column;
  gap: 6px;
  padding: 10px 12px;
  background: var(--color-bg-secondary);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  transition: background 0.15s;
}

.font-output-item:hover {
  background: rgba(48,43,99,0.6);
}

.font-output-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.font-output-label {
  font-size: 0.8125rem;
  font-weight: 500;
  color: var(--color-text-secondary);
}

.copy-btn {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 4px 10px;
  background: transparent;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  color: var(--color-text-secondary);
  font-size: 0.75rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.15s;
  line-height: 1;
}

.copy-btn:hover {
  border-color: var(--color-primary);
  color: var(--color-primary);
  background: rgba(0,212,170,0.08);
}

.copy-btn.copying {
  border-color: var(--color-primary);
  color: var(--color-primary);
  background: rgba(0,212,170,0.12);
}

.copy-icon {
  width: 14px;
  height: 14px;
  display: inline-block;
  fill: currentColor;
}

.font-output-text {
  font-size: 1rem;
  color: var(--color-text);
  word-break: break-all;
  line-height: 1.5;
  padding: 4px 0;
  min-height: 24px;
}

.font-output-placeholder {
  padding: 24px;
  text-align: center;
  color: var(--color-text-muted);
  font-size: 0.9375rem;
}

.tool-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 16px;
  flex-wrap: wrap;
  gap: 12px;
}

.tool-note {
  font-size: 0.8125rem;
  color: var(--color-text-muted);
  max-width: 300px;
}

/* ===== Sections ===== */
.how-it-works-section,
.use-cases-section,
.examples-section,
.faq-section,
.related-section,
.related-pages-section,
.attribute-info-section {
  background: transparent;
}

.use-cases-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 12px;
  margin-top: 8px;
}

.use-case-card {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  padding: 14px;
  background: var(--color-bg-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  transition: border-color 0.15s;
}

.use-case-card:hover {
  border-color: var(--color-primary);
}

.use-case-icon {
  width: 36px;
  height: 36px;
  border-radius: var(--radius-sm);
  background: rgba(0,212,170,0.12);
  color: var(--color-primary);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 1rem;
  flex-shrink: 0;
}

.use-case-info {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.use-case-label {
  font-weight: 600;
  color: var(--color-text);
  font-size: 0.9375rem;
}

.use-case-desc {
  font-size: 0.8125rem;
  color: var(--color-text-secondary);
  line-height: 1.4;
}

.examples-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: 12px;
  margin-top: 8px;
}

.example-card {
  padding: 12px 14px;
  background: var(--color-bg-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
}

.example-label {
  font-size: 0.8125rem;
  font-weight: 500;
  color: var(--color-text-muted);
  margin-bottom: 4px;
}

.example-styled {
  font-size: 0.9375rem;
  color: var(--color-primary);
  word-break: break-word;
}

.faq-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
  margin-top: 8px;
}

.faq-item {
  padding: 16px;
  background: var(--color-bg-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
}

.faq-question {
  font-size: 1rem;
  font-weight: 600;
  color: var(--color-primary);
  margin-bottom: 6px;
}

.faq-answer {
  font-size: 0.9375rem;
  color: var(--color-text-secondary);
  line-height: 1.6;
}

.related-links {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  margin-top: 8px;
}

.related-links a {
  padding: 8px 16px;
  background: var(--color-bg-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  color: var(--color-primary);
  text-decoration: none;
  font-size: 0.875rem;
  font-weight: 500;
  transition: all 0.15s;
}

.related-links a:hover {
  border-color: var(--color-primary);
  background: rgba(0,212,170,0.08);
}

.related-pages-links {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-top: 8px;
}

.related-pages-links a {
  padding: 6px 12px;
  background: var(--color-bg-secondary);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  color: var(--color-text-secondary);
  text-decoration: none;
  font-size: 0.8125rem;
  transition: all 0.15s;
}

.related-pages-links a:hover {
  color: var(--color-primary);
  border-color: var(--color-primary);
}

/* ===== Footer ===== */
.site-footer {
  background: var(--color-bg-secondary);
  border-top: 1px solid var(--color-border);
  padding: 24px 20px;
  margin-top: auto;
}

.footer-container {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.footer-container p {
  font-size: 0.8125rem;
  color: var(--color-text-muted);
}

.footer-nav {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
}

.footer-nav a {
  color: var(--color-text-secondary);
  text-decoration: none;
  font-size: 0.8125rem;
}

.footer-nav a:hover {
  color: var(--color-primary);
}

/* ===== 404 ===== */
.not-found-container {
  max-width: 600px;
  margin: 80px auto;
  text-align: center;
  padding: 40px;
}

.not-found-container h1 {
  font-size: 2rem;
  color: var(--color-primary);
  margin-bottom: 12px;
}

.not-found-container p {
  margin-bottom: 20px;
}

.not-found-container code {
  background: var(--color-bg-card);
  padding: 2px 6px;
  border-radius: var(--radius-sm);
  font-family: var(--font-mono);
  color: var(--color-text-secondary);
}

.btn-primary {
  display: inline-flex;
}

/* ===== Accessibility ===== */
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0,0,0,0);
  white-space: nowrap;
  border: 0;
}

/* ===== Responsive ===== */
@media (max-width: 768px) {
  .nav-links { display: none; }
  .site-main { padding: 16px 12px 32px; }
  .font-changer-tool { padding: 16px; }
  .tool-input-row { flex-direction: column; }
  .use-cases-grid { grid-template-columns: 1fr; }
  .examples-grid { grid-template-columns: 1fr; }
  .related-links { flex-direction: column; }
  .related-pages-links { flex-direction: column; }
  .tool-footer { flex-direction: column; align-items: stretch; text-align: center; }
  .tool-note { max-width: none; }
}
`;
}
