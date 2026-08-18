-- Migration 0004: seo_pages table

CREATE TABLE IF NOT EXISTS seo_pages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    entity_id INTEGER,
    attribute_id INTEGER,
    slug TEXT UNIQUE NOT NULL,
    page_type TEXT NOT NULL,
    title TEXT NOT NULL,
    meta_description TEXT,
    h1 TEXT,
    intro TEXT,
    canonical_url TEXT,
    indexable INTEGER DEFAULT 1,
    follow_links INTEGER DEFAULT 1,
    robots TEXT DEFAULT 'index,follow',
    status TEXT DEFAULT 'published',
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(entity_id) REFERENCES entities(id),
    FOREIGN KEY(attribute_id) REFERENCES attributes(id)
);

CREATE INDEX IF NOT EXISTS idx_seo_pages_slug
ON seo_pages(slug);

CREATE INDEX IF NOT EXISTS idx_seo_pages_indexable
ON seo_pages(indexable, status);

CREATE INDEX IF NOT EXISTS idx_seo_pages_entity_attr
ON seo_pages(entity_id, attribute_id);
