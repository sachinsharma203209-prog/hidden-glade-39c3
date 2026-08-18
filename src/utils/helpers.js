/**
 * D1 Database Helpers
 * All queries use parameterized statements via D1 prepared SQL.
 * D1 BINDING: the Worker's D1 database binding name is "FONT_CHANGER_DB"
 * Defined in wrangler.toml as [[d1_databases]]
 */

const APP_ENV = process.env.APP_ENV || 'development';
const BASE_URL = process.env.BASE_URL || 'http://localhost:8787';

/**
 * Escape a value for safe insertion into HTML.
 * Uses basic entity escaping; no DOM-based XSS vectors.
 */
export function escapeHtml(str) {
  if (str == null) return '';
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

/**
 * Escape a value for use in a URL path segment (slug).
 */
export function escapeSlug(str) {
  if (str == null) return '';
  return String(str).toLowerCase()
    .replace(/[^a-z0-9\-_]/g, '')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '');
}

/**
 * Normalize a URL path:
 *  - lowercase
 *  - remove duplicate slashes
 *  - strip trailing slash (except root)
 *  - strip empty segments
 */
export function normalizePath(path) {
  if (!path) return '';
  let p = path.toLowerCase();
  // Remove duplicate slashes
  while (p.includes('//')) {
    p = p.replace(/\/\//g, '/');
  }
  // Strip trailing slash unless root
  if (p.length > 1 && p.endsWith('/')) {
    p = p.slice(0, -1);
  }
  return p;
}

/**
 * Build a canonical URL for a given slug.
 */
export function canonicalUrl(slug) {
  const base = BASE_URL.replace(/\/+$/, '');
  const slugPart = slug ? '/' + slug : '';
  return base + slugPart;
}

/**
 * Build breadcrumb list from entity + attribute.
 */
export function buildBreadcrumbs(entity, attribute) {
  const crumbs = [];
  crumbs.push({ label: 'Home', url: '/' });
  if (entity) {
    crumbs.push({ label: entity.name || entity.slug, url: '/' + (entity.slug || '') });
  }
  if (attribute) {
    crumbs.push({ label: attribute.name || attribute.slug, url: '/' + (attribute.slug || '') });
  }
  return crumbs;
}

/**
 * Build a JSON-LD BreadcrumbList from breadcrumb array.
 */
export function breadcrumbJsonLd(crumbs) {
  if (!crumbs || crumbs.length === 0) return '';
  const items = crumbs.map((c, i) => ({
    '@type': 'ListItem',
    position: i + 1,
    name: c.label,
    item: { '@id': c.url },
  }));
  return JSON.stringify({
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: items,
  });
}

/**
 * Build a JSON-LD WebApplication schema for the Font Changer tool.
 */
export function webAppJsonLd(baseUrl) {
  return JSON.stringify({
    '@context': 'https://schema.org',
    '@type': 'WebApplication',
    name: 'Font Changer',
    applicationCategory: 'UtilityApplication',
    operatingSystem: 'Any',
    description: 'Free online tool to transform text into stylish Unicode font styles for social media bios, captions, and profiles.',
    url: baseUrl + '/font-changer',
    softwareRequirements: 'Modern web browser (Chrome, Firefox, Safari, Edge)',
    offers: {
      '@type': 'Offer',
      price: '0',
      priceCurrency: 'USD',
    },
  });
}

/**
 * Build a JSON-LD WebPage schema.
 */
export function webPageJsonLd(title, description, canonicalUrl) {
  return JSON.stringify({
    '@context': 'https://schema.org',
    '@type': 'WebPage',
    name: title,
    description: description,
    url: canonicalUrl,
    inLanguage: 'en',
    isPartOf: {
      '@type': 'WebSite',
      url: canonicalUrl.replace(/\/.*$/, '') || canonicalUrl,
      name: 'Font Changer',
    },
  });
}

/**
 * Build a JSON-LD FAQPage schema from an array of FAQs.
 */
export function faqJsonLd(faqs) {
  if (!faqs || faqs.length === 0) return '';
  return JSON.stringify({
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: faqs.map(f => ({
      '@type': 'Question',
      name: f.question,
      acceptedAnswer: {
        '@type': 'Answer',
        text: f.answer,
      },
    })),
  });
}

/**
 * Strip HTML tags from a string (for plain-text fallbacks).
 */
export function stripHtml(html) {
  if (!html) return '';
  return html.replace(/<[^>]*>/g, '').replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"').replace(/&#39;/g, "'");
}

/**
 * Truncate text to a max length, breaking at word boundaries.
 */
export function truncate(text, maxLen) {
  if (!text) return '';
  if (text.length <= maxLen) return text;
  const trimmed = text.slice(0, maxLen);
  const lastSpace = trimmed.lastIndexOf(' ');
  if (lastSpace > maxLen * 0.7) {
    return trimmed.slice(0, lastSpace) + '…';
  }
  return trimmed + '…';
}

/**
 * Slugify a string: lowercase, dash-separated, ASCII-only.
 */
export function slugify(str) {
  return escapeSlug(str);
}

/**
 * Generate a unique-ish slug from a title for SEO page use.
 */
export function pageSlugFromTitle(title, baseSlug) {
  const words = title.toLowerCase().split(/\s+/).filter(w => w.length > 0);
  const slugParts = [];
  if (baseSlug) slugParts.push(baseSlug);
  for (const w of words) {
    if (w.length > 2 && !['the', 'and', 'for', 'with', 'from', 'this', 'that', 'your', 'into', 'using', 'about'].includes(w)) {
      slugParts.push(w);
    }
  }
  return slugParts.join('-');
}

/**
 * D1 helper: execute a prepared SQL query with named parameters.
 * D1 uses $paramName syntax for prepared statements.
 */
export async function dbQuery(db, sql, params = {}) {
  const result = await db.prepare(sql).bind(params).all();
  return result.results || [];
}

/**
 * D1 helper: execute a single-row query.
 */
export async function dbQueryOne(db, sql, params = {}) {
  const result = await db.prepare(sql).bind(params).first();
  return result;
}

/**
 * D1 helper: execute an insert/update/delete statement.
 */
export async function dbExecute(db, sql, params = {}) {
  const result = await db.prepare(sql).bind(params).run();
  return result;
}
