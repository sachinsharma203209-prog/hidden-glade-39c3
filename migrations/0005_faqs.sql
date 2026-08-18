-- Migration 0005: faqs table

CREATE TABLE IF NOT EXISTS faqs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    page_id INTEGER NOT NULL,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    sort_order INTEGER DEFAULT 0,
    FOREIGN KEY(page_id) REFERENCES seo_pages(id)
);

CREATE INDEX IF NOT EXISTS idx_faqs_page
ON faqs(page_id);
