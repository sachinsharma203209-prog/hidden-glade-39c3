-- Migration 0001: entities table
CREATE TABLE IF NOT EXISTS entities (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    slug TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    status TEXT DEFAULT 'published',
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Seed the primary entity
INSERT OR IGNORE INTO entities (slug, name, description, status)
VALUES (
    'font-changer',
    'Font Changer',
    'A free online tool to transform plain text into stylish Unicode font styles for social media, bios, captions, and profiles.',
    'published'
);
