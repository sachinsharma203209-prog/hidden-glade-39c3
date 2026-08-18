/**
 * D1 Database Helpers
 * Cloudflare Workers do NOT have process.env.
 * Environment variables come from the `env` parameter of the fetch handler.
 * Functions needing BASE_URL receive it as a parameter.
 */

/** Escape a value for safe insertion into HTML. */
export function escapeHtml(str) {
  if (str == null) return '';
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

/** Escape a value for use in a URL path segment (slug). */
export function escapeSlug(str) {
  if (str == null) return '';
  return String(str).toLowerCase()
    .replace(/[^a-z0-9\-_]/g, '')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '');
}

/** Normalize a URL path: lowercase, dedup slashes, strip leading/trailing slash. */
export function normalizePath(path) {
  if (!path) return '';
  let p = path.toLowerCase();
  while (p.includes('//')) p = p.replace(/\/\//g, '/');
  // Strip leading slash
  if (p.startsWith('/')) p = p.slice(1);
  // Strip trailing slash unless it's the root
  if (p.length > 0 && p.endsWith('/')) p = p.slice(0, -1);
  return p;
}

/** Build a canonical URL from a base URL and slug. */
export function canonicalUrl(baseUrl, slug) {
  const base = baseUrl.replace(/\/+$/, '');
  const slugPart = slug ? '/' + slug : '';
  return base + slugPart;
}

/** Build breadcrumb list from entity + attribute. */
export function buildBreadcrumbs(entity, attribute) {
  const crumbs = [];
  crumbs.push({ label: 'Home', url: '/' });
  if (entity) crumbs.push({ label: entity.name || entity.slug, url: '/' + (entity.slug || '') });
  if (attribute) crumbs.push({ label: attribute.name || attribute.slug, url: '/' + (attribute.slug || '') });
  return crumbs;
}

/** Build JSON-LD BreadcrumbList. */
export function breadcrumbJsonLd(crumbs) {
  if (!crumbs || crumbs.length === 0) return '';
  const items = crumbs.map((c, i) => ({
    '@type': 'ListItem',
    position: i + 1,
    name: c.label,
    item: { '@id': c.url },
  }));
  return JSON.stringify({ '@context': 'https://schema.org', '@type': 'BreadcrumbList', itemListElement: items });
}

/** Build JSON-LD WebApplication schema. */
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
    offers: { '@type': 'Offer', price: '0', priceCurrency: 'USD' },
  });
}

/** Build JSON-LD WebPage schema. */
export function webPageJsonLd(title, description, canonicalUrl) {
  return JSON.stringify({
    '@context': 'https://schema.org',
    '@type': 'WebPage',
    name: title,
    description: description,
    url: canonicalUrl,
    inLanguage: 'en',
    isPartOf: { '@type': 'WebSite', url: canonicalUrl.replace(/\/.*$/, '') || canonicalUrl, name: 'Font Changer' },
  });
}

/** Build JSON-LD FAQPage schema. */
export function faqJsonLd(faqs) {
  if (!faqs || faqs.length === 0) return '';
  return JSON.stringify({
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: faqs.map(f => ({
      '@type': 'Question',
      name: f.question,
      acceptedAnswer: { '@type': 'Answer', text: f.answer },
    })),
  });
}

/** Strip HTML tags. */
export function stripHtml(html) {
  if (!html) return '';
  return html.replace(/<[^>]*>/g, '').replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"').replace(/&#39;/g, "'");
}

/** Truncate text at word boundary. */
export function truncate(text, maxLen) {
  if (!text) return '';
  if (text.length <= maxLen) return text;
  const trimmed = text.slice(0, maxLen);
  const lastSpace = trimmed.lastIndexOf(' ');
  return (lastSpace > maxLen * 0.7) ? trimmed.slice(0, lastSpace) + '…' : trimmed + '…';
}

/** Slugify: lowercase, dash-separated, ASCII-only. */
export function slugify(str) { return escapeSlug(str); }

/** D1: execute prepared query, return results array. */
export async function dbQuery(db, sql, params = {}) {
  const r = await db.prepare(sql).bind(params).all();
  return r.results || [];
}

/** D1: execute prepared query, return first row. */
export async function dbQueryOne(db, sql, params = {}) {
  return db.prepare(sql).bind(params).first();
}

/** D1: execute prepared statement (insert/update/delete). */
export async function dbExecute(db, sql, params = {}) {
  return db.prepare(sql).bind(params).run();
}
