-- SEO Pages seed
-- Run: wrangler d1 execute font-changer-db --remote --file=seed/seo-pages.sql

-- ============================================
-- CORE PAGE (font-changer)
-- ============================================

INSERT OR IGNORE INTO seo_pages (entity_id, attribute_id, slug, page_type, title, meta_description, h1, intro, indexable, robots, status) VALUES
(1, NULL, 'font-changer', 'core',
 'Font Changer - Fancy & Stylish Fonts Online',
 'Convert any text into stylish Unicode font styles. Copy and paste fancy, bold, cursive, and aesthetic text for Instagram, WhatsApp, bios, and more.',
 'Font Changer',
 'A free online Font Changer tool that transforms your plain text into stylish Unicode font styles instantly. No downloads, no login - just type, preview, and copy.',
 1, 'index,follow', 'published');

-- ============================================
-- SOCIAL MEDIA PAGES (entity_id=1, attribute_ids 1-10)
-- ============================================

INSERT OR IGNORE INTO seo_pages (entity_id, attribute_id, slug, page_type, title, meta_description, h1, intro, indexable, robots, status) VALUES
(1, 1, 'font-changer/instagram', 'attribute',
 'Font Changer for Instagram - Stylish Text Generator',
 'Create stylish Unicode text for Instagram bios, captions, comments, and profiles. Copy fancy fonts for Instagram instantly.',
 'Font Changer for Instagram',
 'Use this Font Changer for Instagram to transform your text into stylish fonts for bios, captions, comments, and display names. Just type your text and copy the style you like.',
 1, 'index,follow', 'published');

INSERT OR IGNORE INTO seo_pages (entity_id, attribute_id, slug, page_type, title, meta_description, h1, intro, indexable, robots, status) VALUES
(1, 2, 'font-changer/facebook', 'attribute',
 'Font Changer for Facebook - Stylish Text for Posts',
 'Generate fancy and bold text for Facebook posts, comments, bio, and profile. Copy and paste custom text styles on Facebook.',
 'Font Changer for Facebook',
 'Make your Facebook posts and comments stand out with custom font styles. This font changer for Facebook lets you generate bold, cursive, and fancy text for any Facebook update.',
 1, 'index,follow', 'published');

INSERT OR IGNORE INTO seo_pages (entity_id, attribute_id, slug, page_type, title, meta_description, h1, intro, indexable, robots, status) VALUES
(1, 3, 'font-changer/whatsapp', 'attribute',
 'Font Changer for WhatsApp - Fancy Status & Message Text',
 'Create stylish text for WhatsApp statuses, messages, and display names. Copy and paste fancy fonts on WhatsApp easily.',
 'Font Changer for WhatsApp',
 'Transform your WhatsApp messages, statuses, and display name with stylish font styles. This font changer for WhatsApp generates cool Unicode text that you can copy and paste anywhere.',
 1, 'index,follow', 'published');

INSERT OR IGNORE INTO seo_pages (entity_id, attribute_id, slug, page_type, title, meta_description, h1, intro, indexable, robots, status) VALUES
(1, 4, 'font-changer/twitter', 'attribute',
 'Font Changer for Twitter (X) - Stylish Tweet Text',
 'Generate fancy fonts for tweets, Twitter/X bios, and display names. Copy stylized text for your Twitter/X profile and posts.',
 'Font Changer for Twitter (X)',
 'Make your tweets and Twitter/X profile stand out with custom font styles. This font changer for Twitter generates bold, italic, cursive, and fancy Unicode text for your tweets and bio.',
 1, 'index,follow', 'published');

INSERT OR IGNORE INTO seo_pages (entity_id, attribute_id, slug, page_type, title, meta_description, h1, intro, indexable, robots, status) VALUES
(1, 5, 'font-changer/tiktok', 'attribute',
 'Font Changer for TikTok - Stylish Bio & Caption Text',
 'Create trending font styles for TikTok bios, captions, comments, and profile text. Copy and paste cool fonts for TikTok.',
 'Font Changer for TikTok',
 'Make your TikTok bio, captions, and profile text look unique with stylish font styles. This font changer for TikTok helps you generate fun Unicode text to copy and paste on TikTok.',
 1, 'index,follow', 'published');

INSERT OR IGNORE INTO seo_pages (entity_id, attribute_id, slug, page_type, title, meta_description, h1, intro, indexable, robots, status) VALUES
(1, 6, 'font-changer/snapchat', 'attribute',
 'Font Changer for Snapchat - Stylish Username & Caption Text',
 'Generate fancy fonts for your Snapchat username, captions, and stories. Copy unique Unicode text styles for Snapchat.',
 'Font Changer for Snapchat',
 'Customize your Snapchat username and captions with stylish text styles. This font changer for Snapchat generates copy-paste Unicode fonts that work on Snapchat.',
 1, 'index,follow', 'published');

INSERT OR IGNORE INTO seo_pages (entity_id, attribute_id, slug, page_type, title, meta_description, h1, intro, indexable, robots, status) VALUES
(1, 7, 'font-changer/telegram', 'attribute',
 'Font Changer for Telegram - Stylish Username & Bio',
 'Create stylish text for your Telegram username, bio, and channel name. Copy and paste fancy fonts on Telegram.',
 'Font Changer for Telegram',
 'Make your Telegram username and bio stand out with custom font styles. This font changer for Telegram generates Unicode text you can copy and paste into Telegram.',
 1, 'index,follow', 'published');

INSERT OR IGNORE INTO seo_pages (entity_id, attribute_id, slug, page_type, title, meta_description, h1, intro, indexable, robots, status) VALUES
(1, 8, 'font-changer/pinterest', 'attribute',
 'Font Changer for Pinterest - Aesthetic Bio & Pin Text',
 'Generate aesthetic and stylish text for Pinterest bios, pin descriptions, and profile. Copy and paste fancy fonts on Pinterest.',
 'Font Changer for Pinterest',
 'Add a touch of style to your Pinterest profile and pins with custom text fonts. This font changer for Pinterest creates aesthetic Unicode text you can copy and paste.',
 1, 'index,follow', 'published');

INSERT OR IGNORE INTO seo_pages (entity_id, attribute_id, slug, page_type, title, meta_description, h1, intro, indexable, robots, status) VALUES
(1, 9, 'font-changer/threads', 'attribute',
 'Font Changer for Threads - Stylish Post & Bio Text',
 'Create stylish text for Instagram Threads posts, bios, and replies. Copy and paste fancy fonts on Threads.',
 'Font Changer for Threads',
 'Make your Threads posts and bio look unique with custom font styles. This font changer for Threads generates Unicode text styles that you can copy and paste right away.',
 1, 'index,follow', 'published');

INSERT OR IGNORE INTO seo_pages (entity_id, attribute_id, slug, page_type, title, meta_description, h1, intro, indexable, robots, status) VALUES
(1, 10, 'font-changer/linkedin', 'attribute',
 'Font Changer for LinkedIn - Professional Profile Text Styles',
 'Generate professional and stylish text for your LinkedIn headline, about section, and posts. Copy-paste custom text for LinkedIn.',
 'Font Changer for LinkedIn',
 'Add a unique touch to your LinkedIn profile with custom text styles. This font changer for LinkedIn helps you generate professional Unicode text for headlines and about sections.',
 1, 'index,follow', 'published');
