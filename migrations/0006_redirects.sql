-- Migration 0006: redirects table

CREATE TABLE IF NOT EXISTS redirects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    source_path TEXT UNIQUE NOT NULL,
    destination_path TEXT NOT NULL,
    status_code INTEGER DEFAULT 301
);

CREATE INDEX IF NOT EXISTS idx_redirects_source
ON redirects(source_path);
