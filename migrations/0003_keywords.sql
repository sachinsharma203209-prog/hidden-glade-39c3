-- Migration 0003: keywords table

CREATE TABLE IF NOT EXISTS keywords (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    entity_id INTEGER,
    attribute_id INTEGER,
    keyword TEXT NOT NULL,
    slug TEXT,
    search_volume INTEGER DEFAULT 0,
    keyword_difficulty REAL,
    cpc REAL,
    search_intent TEXT,
    source TEXT,
    priority INTEGER DEFAULT 0,
    status TEXT DEFAULT 'active',
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(entity_id) REFERENCES entities(id),
    FOREIGN KEY(attribute_id) REFERENCES attributes(id)
);

CREATE INDEX IF NOT EXISTS idx_keywords_entity
ON keywords(entity_id);

CREATE INDEX IF NOT EXISTS idx_keywords_attribute
ON keywords(attribute_id);

CREATE INDEX IF NOT EXISTS idx_keywords_status
ON keywords(status);
