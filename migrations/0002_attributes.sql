-- Migration 0002: attribute_groups and attributes tables

CREATE TABLE IF NOT EXISTS attribute_groups (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    slug TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    sort_order INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS attributes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    group_id INTEGER NOT NULL,
    entity_id INTEGER NOT NULL,
    slug TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    status TEXT DEFAULT 'published',
    sort_order INTEGER DEFAULT 0,
    FOREIGN KEY(group_id) REFERENCES attribute_groups(id),
    FOREIGN KEY(entity_id) REFERENCES entities(id),
    UNIQUE(entity_id, slug)
);

-- Index for faster attribute lookups
CREATE INDEX IF NOT EXISTS idx_attributes_entity_slug
ON attributes(entity_id, slug);
