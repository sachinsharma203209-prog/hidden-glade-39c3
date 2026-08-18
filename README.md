# Font Changer Entity SEO Platform
## Cloudflare Workers + D1 Database-Driven SEO

Production-ready, SEO-first **Font Changer / Fancy Text Generator platform**.

### Overview
- **Cloudflare Workers** for SSR
- **Cloudflare D1** as source of truth for all SEO data
- **One reusable Font Changer tool** renders on every page
- **60 SEO pages** dynamically rendered from D1
- **No hardcoded pages** — all content from database

### URL Structure
- `/` → 301 redirect to `/font-changer`
- `/font-changer` → Core page (70900 search volume keyword)
- `/font-changer/{attribute}` → 60 attribute pages (Instagram, Facebook, Hindi, Bold, Free Fire, etc.)
- `/sitemap.xml` → Dynamic XML sitemap (59 URLs)
- `/robots.txt` → Standard robots.txt
- `/*` → 404 Not Found (proper HTTP 404)

### Architecture

```
                 D1
                  │
       ┌──────────┴──────────┐
       │                     │
   SEO DATA              TOOL DATA
       │                     │
       └──────────┬──────────┘
                  ↓
          CLOUDFLARE WORKER
                  │
        ┌─────────┴─────────┐
        ↓                   ↓
   SSR SEO PAGE       FONT TOOL ENGINE
        │                   │
        └─────────┬─────────┘
                  ↓
              USER
```

### Database Schema

**entities** — Primary entities (e.g., font-changer)
**attribute_groups** — Attribute categories (social-media, platform, language, style, gaming, use-case)
**attributes** — Individual attributes (Instagram, Hindi, Bold, Free Fire, etc.)
**keywords** — SEO keywords with search volume, difficulty, intent
**seo_pages** — SEO page data (title, meta, H1, intro, indexable, canonical)
**faqs** — FAQ data per page
**redirects** — 301 redirect rules

### Key Features

- **SSR HTML** — All SEO content present in initial response (H1, meta, content, FAQs, structured data)
- **Dynamic titles** — Each page has unique title from D1
- **Unique meta descriptions** — No keyword stuffing
- **Canonical URLs** — One canonical per page
- **Robots meta** — index,follow for valid pages; noindex,follow for invalid
- **Breadcrumbs** — Semantic breadcrumb navigation + JSON-LD
- **Schema.org** — WebApplication, WebPage, BreadcrumbList, FAQPage JSON-LD
- **Dynamic sitemap** — Only published+indexable pages included
- **Related pages** — D1-driven internal linking based on topical relevance
- **FAQ system** — Per-page FAQs stored in D1, rendered server-side
- **17 Unicode font styles** — Bold, Italic, Bold Italic, Cursive, Double Struck, Fraktur, Monospace, Fullwidth, Small Caps, Bubble, Squared, Circled, Superscript, Subscript, Strikethrough, Underline, Glitch
- **Client-side tool** — All text transformations in browser, no server calls for text
- **Mobile responsive** — Works on Android, iPhone, tablet, desktop
- **Fast** — Minimal JS, no heavy frameworks, system fonts, inlined CSS

### Project Structure
```
/
├── src/
│   ├── worker.js              # Cloudflare Worker (SSR + routing)
│   ├── utils/helpers.js       # HTML escaping, canonical URLs, JSON-LD builders, D1 helpers
│   ├── tools/
│   │   └── font-changer-engine.js  # Unicode transform engine (client-side)
│   └── components/
│       └── font-changer-tool.js    # Reusable UI component (client-side)
├── migrations/
│   ├── 0001_entities.sql
│   ├── 0002_attributes.sql
│   ├── 0003_keywords.sql
│   ├── 0004_seo_pages.sql
│   ├── 0005_faqs.sql
│   └── 0006_redirects.sql
├── seed/
│   ├── attributes.sql         # 60 attributes across 6 groups
│   ├── keywords1.sql          # Keywords part 1 (core + social + platform)
│   ├── keywords2.sql          # Keywords part 2 (style + gaming)
│   ├── keywords3.sql          # Keywords part 3 (use case)
│   ├── seo-pages-1.sql        # SEO pages: social media (10 pages)
│   ├── seo-pages-2.sql        # SEO pages: platform/app (8 pages)
│   ├── seo-pages-3.sql        # SEO pages: languages (10 pages)
│   ├── seo-pages-4.sql        # SEO pages: styles (10 pages)
│   ├── seo-pages-5.sql        # SEO pages: gaming (10 pages)
│   └── seo-pages-6.sql        # SEO pages: use cases (10 pages)
├── wrangler.toml
├── package.json
└── README.md
```

### Deployment

**Worker URL:** https://font-changer-seo.sachin-123-ss92.workers.dev

**Cloudflare Account:** e520b7c2d669f6a467c9a80bd6d276fa
**D1 Database ID:** 16ad4ada-8fa9-403c-bc2c-b612ae92ba2f

### Setup Commands
```bash
# Install dependencies
npm install

# Create D1 database (one-time)
wrangler d1 create font-changer-db

# Run migrations
wrangler d1 execute font-changer-db --file=migrations/0001_entities.sql
wrangler d1 execute font-changer-db --file=migrations/0002_attributes.sql
wrangler d1 execute font-changer-db --file=migrations/0003_keywords.sql
wrangler d1 execute font-changer-db --file=migrations/0004_seo_pages.sql
wrangler d1 execute font-changer-db --file=migrations/0005_faqs.sql
wrangler d1 execute font-changer-db --file=migrations/0006_redirects.sql

# Seed data
wrangler d1 execute font-changer-db --file=seed/attributes.sql
wrangler d1 execute font-changer-db --file=seed/keywords1.sql
wrangler d1 execute font-changer-db --file=seed/keywords2.sql
wrangler d1 execute font-changer-db --file=seed/keywords3.sql
wrangler d1 execute font-changer-db --file=seed/seo-pages-1.sql
wrangler d1 execute font-changer-db --file=seed/seo-pages-2.sql
wrangler d1 execute font-changer-db --file=seed/seo-pages-3.sql
wrangler d1 execute font-changer-db --file=seed/seo-pages-4.sql
wrangler d1 execute font-changer-db --file=seed/seo-pages-5.sql
wrangler d1 execute font-changer-db --file=seed/seo-pages-6.sql

# Local development
npm run dev

# Deploy
npm run deploy
```

### Acceptable Usage
- Free online tool, no login required
- Unicode text styles, NOT downloadable font files
- All text processing client-side (privacy-friendly)
- No fake reviews, no misleading claims
