-- Seed data for Font Changer Entity SEO Platform
-- Run: wrangler d1 execute font-changer-db --file=seed/font-changer.sql

-- ============================================
-- ATTRIBUTE GROUPS
-- ============================================

INSERT OR IGNORE INTO attribute_groups (slug, name, description, sort_order) VALUES
('social-media', 'Social Media', 'Social media platforms for font styling', 1),
('platform', 'Platform / App', 'Platforms and app-related attributes', 2),
('language', 'Language', 'Languages supported by the font changer', 3),
('style', 'Font Style', 'Stylistic font categories', 4),
('gaming', 'Gaming', 'Gaming platforms and communities', 5),
('use-case', 'Use Case', 'Common use cases for stylized text', 6);

-- ============================================
-- ATTRIBUTES (entity_id = 1 = font-changer)
-- ============================================

-- Social Media attributes
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, (SELECT id FROM attribute_groups WHERE slug='social-media'), 'instagram', 'Instagram', 'Stylish fonts for Instagram bios, captions, and profiles', 1),
(1, (SELECT id FROM attribute_groups WHERE slug='social-media'), 'facebook', 'Facebook', 'Custom text styles for Facebook posts, comments, and profiles', 2),
(1, (SELECT id FROM attribute_groups WHERE slug='social-media'), 'whatsapp', 'WhatsApp', 'Fancy text for WhatsApp statuses, messages, and display names', 3),
(1, (SELECT id FROM attribute_groups WHERE slug='social-media'), 'twitter', 'Twitter / X', 'Stylish text for tweets, bios, and display names on Twitter/X', 4),
(1, (SELECT id FROM attribute_groups WHERE slug='social-media'), 'tiktok', 'TikTok', 'Trending font styles for TikTok bios, captions, and comments', 5),
(1, (SELECT id FROM attribute_groups WHERE slug='social-media'), 'snapchat', 'Snapchat', 'Custom fonts for Snapchat usernames, captions, and stories', 6),
(1, (SELECT id FROM attribute_groups WHERE slug='social-media'), 'telegram', 'Telegram', 'Stylish text for Telegram usernames, bios, and channel names', 7),
(1, (SELECT id FROM attribute_groups WHERE slug='social-media'), 'pinterest', 'Pinterest', 'Aesthetic font styles for Pinterest bios, pins, and descriptions', 8),
(1, (SELECT id FROM attribute_groups WHERE slug='social-media'), 'threads', 'Threads', 'Custom text styles for Instagram Threads posts and bios', 9),
(1, (SELECT id FROM attribute_groups WHERE slug='social-media'), 'linkedin', 'LinkedIn', 'Professional font styles for LinkedIn headlines, about sections, and posts', 10);

-- Platform / App attributes
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, (SELECT id FROM attribute_groups WHERE slug='platform'), 'apk', 'APK', 'Mobile app version of the font changer tool for Android devices', 1),
(1, (SELECT id FROM attribute_groups WHERE slug='platform'), 'android', 'Android', 'Font changer optimized for Android phones and tablets', 2),
(1, (SELECT id FROM attribute_groups WHERE slug='platform'), 'iphone', 'iPhone', 'Font changer for iPhone and iOS devices', 3),
(1, (SELECT id FROM attribute_groups WHERE slug='platform'), 'ios', 'iOS', 'Stylish text generator that works on iOS devices', 4),
(1, (SELECT id FROM attribute_groups WHERE slug='platform'), 'online', 'Online', 'Free online font changer tool accessible from any device', 5),
(1, (SELECT id FROM attribute_groups WHERE slug='platform'), 'mobile', 'Mobile', 'Mobile-friendly font changer tool for phones and tablets', 6),
(1, (SELECT id FROM attribute_groups WHERE slug='platform'), 'pc', 'PC', 'Desktop-friendly font generator for Windows and Mac computers', 7),
(1, (SELECT id FROM attribute_groups WHERE slug='platform'), 'web', 'Web', 'Browser-based font changer tool — no installation required', 8);

-- Language attributes
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, (SELECT id FROM attribute_groups WHERE slug='language'), 'hindi', 'Hindi', 'Stylish Hindi text generator — font changer for Hindi text', 1),
(1, (SELECT id FROM attribute_groups WHERE slug='language'), 'english', 'English', 'Font styles for English text, letters, and words', 2),
(1, (SELECT id FROM attribute_groups WHERE slug='language'), 'arabic', 'Arabic', 'Unicode font styles for Arabic text and characters', 3),
(1, (SELECT id FROM attribute_groups WHERE slug='language'), 'bengali', 'Bengali', 'Fancy text styles for Bengali script', 4),
(1, (SELECT id FROM attribute_groups WHERE slug='language'), 'punjabi', 'Punjabi', 'Font changer for Punjabi text and Gurmukhi script', 5),
(1, (SELECT id FROM attribute_groups WHERE slug='language'), 'gujarati', 'Gujarati', 'Stylish font styles for Gujarati text', 6),
(1, (SELECT id FROM attribute_groups WHERE slug='language'), 'marathi', 'Marathi', 'Custom text styles for Marathi language', 7),
(1, (SELECT id FROM attribute_groups WHERE slug='language'), 'tamil', 'Tamil', 'Font styles for Tamil script and text', 8),
(1, (SELECT id FROM attribute_groups WHERE slug='language'), 'telugu', 'Telugu', 'Fancy font generator for Telugu text', 9),
(1, (SELECT id FROM attribute_groups WHERE slug='language'), 'urdu', 'Urdu', 'Stylish text styles for Urdu language and script', 10);

-- Font Style attributes
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, (SELECT id FROM attribute_groups WHERE slug='style'), 'stylish', 'Stylish', 'Modern and stylish Unicode font transformations', 1),
(1, (SELECT id FROM attribute_groups WHERE slug='style'), 'fancy', 'Fancy', 'Fancy and decorative font styles for social media', 2),
(1, (SELECT id FROM attribute_groups WHERE slug='style'), 'bold', 'Bold', 'Bold Unicode text styles for emphasis and impact', 3),
(1, (SELECT id FROM attribute_groups WHERE slug='style'), 'cursive', 'Cursive', 'Cursive and handwritten-style Unicode text', 4),
(1, (SELECT id FROM attribute_groups WHERE slug='style'), 'italic', 'Italic', 'Italic-style Unicode font transformations', 5),
(1, (SELECT id FROM attribute_groups WHERE slug='style'), 'gothic', 'Gothic', 'Gothic and old English-style Unicode text', 6),
(1, (SELECT id FROM attribute_groups WHERE slug='style'), 'calligraphy', 'Calligraphy', 'Calligraphy-style elegant text transformations', 7),
(1, (SELECT id FROM attribute_groups WHERE slug='style'), 'aesthetic', 'Aesthetic', 'Aesthetic and pretty Unicode font styles', 8),
(1, (SELECT id FROM attribute_groups WHERE slug='style'), 'cute', 'Cute', 'Cute and playful font styles for social media', 9),
(1, (SELECT id FROM attribute_groups WHERE slug='style'), 'elegant', 'Elegant', 'Elegant and sophisticated font transformations', 10);

-- Gaming attributes
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, (SELECT id FROM attribute_groups WHERE slug='gaming'), 'free-fire', 'Free Fire', 'Stylish names and text for Free Fire gamers', 1),
(1, (SELECT id FROM attribute_groups WHERE slug='gaming'), 'pubg', 'PUBG', 'Fancy usernames and clan names for PUBG players', 2),
(1, (SELECT id FROM attribute_groups WHERE slug='gaming'), 'bgmi', 'BGMI', 'Font styles for BGMI gaming profiles and squad names', 3),
(1, (SELECT id FROM attribute_groups WHERE slug='gaming'), 'minecraft', 'Minecraft', 'Custom text styles for Minecraft usernames, signs, and chat', 4),
(1, (SELECT id FROM attribute_groups WHERE slug='gaming'), 'roblox', 'Roblox', 'Fancy text for Roblox usernames, group names, and game chat', 5),
(1, (SELECT id FROM attribute_groups WHERE slug='gaming'), 'fortnite', 'Fortnite', 'Stylish names for Fortnite gamertags and battle passes', 6),
(1, (SELECT id FROM attribute_groups WHERE slug='gaming'), 'valorant', 'Valorant', 'Font changer for Valorant agent names and in-game text', 7),
(1, (SELECT id FROM attribute_groups WHERE slug='gaming'), 'cod-mobile', 'Call of Duty Mobile', 'Custom text for CODM usernames, clan tags, and text chat', 8),
(1, (SELECT id FROM attribute_groups WHERE slug='gaming'), 'clash-of-clans', 'Clash of Clans', 'Fancy text for Clash of Clans clan names and player tags', 9),
(1, (SELECT id FROM attribute_groups WHERE slug='gaming'), 'among-us', 'Among Us', 'Stylish text for Among Us player names and chat', 10);

-- Use Case attributes
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, (SELECT id FROM attribute_groups WHERE slug='use-case'), 'username', 'Username', 'Stylish and unique usernames for social media and gaming', 1),
(1, (SELECT id FROM attribute_groups WHERE slug='use-case'), 'nickname', 'Nickname', 'Fancy nicknames for profiles, chat, and games', 2),
(1, (SELECT id FROM attribute_groups WHERE slug='use-case'), 'bio', 'Bio', 'Stylish text for social media bios and profile descriptions', 3),
(1, (SELECT id FROM attribute_groups WHERE slug='use-case'), 'caption', 'Caption', 'Fancy captions for social media posts and photos', 4),
(1, (SELECT id FROM attribute_groups WHERE slug='use-case'), 'status', 'Status', 'Custom status text for WhatsApp, Discord, and other platforms', 5),
(1, (SELECT id FROM attribute_groups WHERE slug='use-case'), 'comment', 'Comment', 'Stylish comments for YouTube, Instagram, Facebook, and more', 6),
(1, (SELECT id FROM attribute_groups WHERE slug='use-case'), 'post', 'Post', 'Fancy text for social media posts and updates', 7),
(1, (SELECT id FROM attribute_groups WHERE slug='use-case'), 'gaming-name', 'Gaming Name', 'Unique and stylish gaming usernames for any game', 8),
(1, (SELECT id FROM attribute_groups WHERE slug='use-case'), 'profile-name', 'Profile Name', 'Custom profile names for social media and apps', 9),
(1, (SELECT id FROM attribute_groups WHERE slug='use-case'), 'clan-name', 'Clan Name', 'Fancy clan and guild names for gaming communities', 10);

-- ============================================
-- KEYWORDS (entity_id = 1 = font-changer)
-- ============================================

INSERT OR IGNORE INTO keywords (entity_id, attribute_id, keyword, slug, search_volume, keyword_difficulty, search_intent, priority, status) VALUES
-- Core brand keywords
(1, NULL, 'font changer', 'font-changer', 70900, 45.0, 'tool', 1, 'active'),
(1, NULL, 'font changer tool', 'font-changer-tool', 12000, 38.0, 'tool', 2, 'active'),
(1, NULL, 'fancy text generator', 'fancy-text-generator', 40500, 42.0, 'tool', 3, 'active'),
(1, NULL, 'stylish text generator', 'stylish-text-generator', 27100, 40.0, 'tool', 4, 'active'),
(1, NULL, 'copy and paste fonts', 'copy-paste-fonts', 18100, 35.0, 'tool', 5, 'active'),
(1, NULL, 'unicode font changer', 'unicode-font-changer', 5400, 28.0, 'tool', 6, 'active'),
(1, NULL, 'cool fonts generator', 'cool-fonts-generator', 9800, 32.0, 'tool', 7, 'active'),
(1, NULL, 'text style changer', 'text-style-changer', 3600, 25.0, 'tool', 8, 'active'),

-- Social media keywords
(NULL, (SELECT id FROM attributes WHERE slug='instagram'), 'font changer instagram', 'font-changer-instagram', 22200, 44.0, 'social-media', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='instagram'), 'instagram font generator', 'instagram-font-generator', 12100, 40.0, 'social-media', 2, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='instagram'), 'instagram stylish text', 'instagram-stylish-text', 6500, 35.0, 'social-media', 3, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='instagram'), 'instagram bio font', 'instagram-bio-font', 4200, 32.0, 'social-media', 4, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='facebook'), 'font changer facebook', 'font-changer-facebook', 8400, 38.0, 'social-media', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='facebook'), 'facebook stylish text', 'facebook-stylish-text', 3200, 30.0, 'social-media', 2, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='whatsapp'), 'font changer whatsapp', 'font-changer-whatsapp', 13500, 40.0, 'social-media', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='whatsapp'), 'whatsapp fancy text', 'whatsapp-fancy-text', 5600, 32.0, 'social-media', 2, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='whatsapp'), 'whatsapp status font', 'whatsapp-status-font', 7800, 34.0, 'social-media', 3, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='twitter'), 'twitter font changer', 'twitter-font-changer', 6700, 35.0, 'social-media', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='tiktok'), 'tiktok font generator', 'tiktok-font-generator', 11000, 42.0, 'social-media', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='tiktok'), 'tiktok stylish text', 'tiktok-stylish-text', 4900, 35.0, 'social-media', 2, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='snapchat'), 'snapchat font changer', 'snapchat-font-changer', 2900, 28.0, 'social-media', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='telegram'), 'telegram font generator', 'telegram-font-generator', 2100, 25.0, 'social-media', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='pinterest'), 'pinterest font changer', 'pinterest-font-changer', 1400, 22.0, 'social-media', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='threads'), 'threads font changer', 'threads-font-changer', 1800, 24.0, 'social-media', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='linkedin'), 'linkedin font changer', 'linkedin-font-changer', 900, 20.0, 'social-media', 1, 'active'),

-- Platform / App keywords
(NULL, (SELECT id FROM attributes WHERE slug='apk'), 'font changer apk', 'font-changer-apk', 14800, 36.0, 'app/platform', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='apk'), 'font changer app', 'font-changer-app', 8900, 34.0, 'app/platform', 2, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='android'), 'font changer android', 'font-changer-android', 4500, 30.0, 'app/platform', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='iphone'), 'font changer iphone', 'font-changer-iphone', 3800, 28.0, 'app/platform', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='ios'), 'font changer ios', 'font-changer-ios', 2900, 27.0, 'app/platform', 2, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='mobile'), 'font changer mobile', 'font-changer-mobile', 2100, 25.0, 'app/platform', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='online'), 'online font changer', 'online-font-changer', 20500, 40.0, 'app/platform', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='web'), 'web font changer', 'web-font-changer', 1600, 22.0, 'app/platform', 1, 'active'),

-- Language keywords
(NULL, (SELECT id FROM attributes WHERE slug='hindi'), 'hindi font changer', 'hindi-font-changer', 19000, 42.0, 'language', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='hindi'), 'hindi stylish text', 'hindi-stylish-text', 5400, 34.0, 'language', 2, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='hindi'), 'hindi fancy text generator', 'hindi-fancy-text-generator', 3200, 30.0, 'language', 3, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='english'), 'english font changer', 'english-font-changer', 3100, 25.0, 'language', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='arabic'), 'arabic font changer', 'arabic-font-changer', 1800, 22.0, 'language', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='bengali'), 'bengali font changer', 'bengali-font-changer', 1200, 20.0, 'language', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='punjabi'), 'punjabi font changer', 'punjabi-font-changer', 2400, 24.0, 'language', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='gujarati'), 'gujarati font changer', 'gujarati-font-changer', 900, 18.0, 'language', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='marathi'), 'marathi font changer', 'marathi-font-changer', 1100, 20.0, 'language', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='tamil'), 'tamil font changer', 'tamil-font-changer', 1400, 21.0, 'language', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='telugu'), 'telugu font changer', 'telugu-font-changer', 1300, 21.0, 'language', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='urdu'), 'urdu font changer', 'urdu-font-changer', 1500, 22.0, 'language', 1, 'active'),

-- Style keywords
(NULL, (SELECT id FROM attributes WHERE slug='stylish'), 'stylish font changer', 'stylish-font-changer', 8200, 35.0, 'style', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='fancy'), 'fancy font changer', 'fancy-font-changer', 15600, 42.0, 'style', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='bold'), 'bold font changer', 'bold-font-changer', 4500, 30.0, 'style', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='cursive'), 'cursive font changer', 'cursive-font-changer', 6700, 33.0, 'style', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='italic'), 'italic font changer', 'italic-font-changer', 2100, 24.0, 'style', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='gothic'), 'gothic font changer', 'gothic-font-changer', 3400, 28.0, 'style', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='calligraphy'), 'calligraphy font changer', 'calligraphy-font-changer', 2800, 26.0, 'style', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='aesthetic'), 'aesthetic font changer', 'aesthetic-font-changer', 5100, 32.0, 'style', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='cute'), 'cute font changer', 'cute-font-changer', 2600, 24.0, 'style', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='elegant'), 'elegant font changer', 'elegant-font-changer', 1800, 22.0, 'style', 1, 'active'),

-- Gaming keywords
(NULL, (SELECT id FROM attributes WHERE slug='free-fire'), 'font changer free fire', 'font-changer-free-fire', 21000, 44.0, 'gaming', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='free-fire'), 'free fire stylish name', 'free-fire-stylish-name', 8900, 38.0, 'gaming', 2, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='free-fire'), 'free fire font generator', 'free-fire-font-generator', 6500, 35.0, 'gaming', 3, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='pubg'), 'pubg font changer', 'pubg-font-changer', 11000, 40.0, 'gaming', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='pubg'), 'pubg stylish name', 'pubg-stylish-name', 5400, 33.0, 'gaming', 2, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='bgmi'), 'bgmi font changer', 'bgmi-font-changer', 7800, 36.0, 'gaming', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='minecraft'), 'minecraft font changer', 'minecraft-font-changer', 9500, 38.0, 'gaming', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='roblox'), 'roblox font changer', 'roblox-font-changer', 16000, 42.0, 'gaming', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='fortnite'), 'fortnite font changer', 'fortnite-font-changer', 5600, 34.0, 'gaming', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='valorant'), 'valorant font changer', 'valorant-font-changer', 3200, 28.0, 'gaming', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='cod-mobile'), 'codm font changer', 'codm-font-changer', 4100, 30.0, 'gaming', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='clash-of-clans'), 'clash of clans font changer', 'clash-of-clans-font-changer', 2800, 26.0, 'gaming', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='among-us'), 'among us font changer', 'among-us-font-changer', 1900, 24.0, 'gaming', 1, 'active'),

-- Use case keywords
(NULL, (SELECT id FROM attributes WHERE slug='username'), 'stylish username generator', 'stylish-username-generator', 67000, 48.0, 'use-case', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='username'), 'cool username fonts', 'cool-username-fonts', 12400, 36.0, 'use-case', 2, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='nickname'), 'fancy nickname generator', 'fancy-nickname-generator', 14500, 38.0, 'use-case', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='bio'), 'bio font generator', 'bio-font-generator', 8900, 35.0, 'use-case', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='caption'), 'stylish caption generator', 'stylish-caption-generator', 7200, 33.0, 'use-case', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='status'), 'whatsapp status font changer', 'whatsapp-status-font-changer', 9800, 36.0, 'use-case', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='comment'), 'stylish comment generator', 'stylish-comment-generator', 3400, 28.0, 'use-case', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='gaming-name'), 'gaming name font changer', 'gaming-name-font-changer', 3800, 29.0, 'use-case', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='profile-name'), 'stylish profile name', 'stylish-profile-name', 2100, 25.0, 'use-case', 1, 'active'),
(NULL, (SELECT id FROM attributes WHERE slug='clan-name'), 'fancy clan name generator', 'fancy-clan-name-generator', 2700, 26.0, 'use-case', 1, 'active');

-- ============================================
-- SEO PAGES
-- ============================================

INSERT OR IGNORE INTO seo_pages (entity_id, attribute_id, slug, page_type, title, meta_description, h1, intro, indexable, robots, status) VALUES
-- Core / pillar page
(1, NULL, 'font-changer', 'core',
 'Font Changer — Fancy & Stylish Fonts Online',
 'Convert any text into stylish Unicode font styles. Copy and paste fancy, bold, cursive, and aesthetic text for Instagram, WhatsApp, bios, and more.',
 'Font Changer',
 'A free online Font Changer tool that transforms your plain text into stylish Unicode font styles instantly. No downloads, no login — just type, preview, and copy.',
 1, 'index,follow', 'published'),

-- Social media pages
(1, (SELECT id FROM attributes WHERE slug='instagram'), 'font-changer/instagram', 'attribute',
 'Font Changer for Instagram — Stylish Text Generator',
 'Create stylish Unicode text for Instagram bios, captions, comments, and profiles. Copy fancy fonts for Instagram instantly.',
 'Font Changer for Instagram',
 'Use this Font Changer for Instagram to transform your text into stylish fonts for bios, captions, comments, and display names. Just type your text and copy the style you like.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='facebook'), 'font-changer/facebook', 'attribute',
 'Font Changer for Facebook — Stylish Text for Posts',
 'Generate fancy and bold text for Facebook posts, comments, bio, and profile. Copy and paste custom text styles on Facebook.',
 'Font Changer for Facebook',
 'Make your Facebook posts and comments stand out with custom font styles. This font changer for Facebook lets you generate bold, cursive, and fancy text for any Facebook update.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='whatsapp'), 'font-changer/whatsapp', 'attribute',
 'Font Changer for WhatsApp — Fancy Status & Message Text',
 'Create stylish text for WhatsApp statuses, messages, and display names. Copy and paste fancy fonts on WhatsApp easily.',
 'Font Changer for WhatsApp',
 'Transform your WhatsApp messages, statuses, and display name with stylish font styles. This font changer for WhatsApp generates cool Unicode text that you can copy and paste anywhere.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='twitter'), 'font-changer/twitter', 'attribute',
 'Font Changer for Twitter (X) — Stylish Tweet Text',
 'Generate fancy fonts for tweets, Twitter/X bios, and display names. Copy stylized text for your Twitter/X profile and posts.',
 'Font Changer for Twitter (X)',
 'Make your tweets and Twitter/X profile stand out with custom font styles. This font changer for Twitter generates bold, italic, cursive, and fancy Unicode text for your tweets and bio.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='tiktok'), 'font-changer/tiktok', 'attribute',
 'Font Changer for TikTok — Stylish Bio & Caption Text',
 'Create trending font styles for TikTok bios, captions, comments, and profile text. Copy and paste cool fonts for TikTok.',
 'Font Changer for TikTok',
 'Make your TikTok bio, captions, and profile text look unique with stylish font styles. This font changer for TikTok helps you generate fun Unicode text to copy and paste on TikTok.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='snapchat'), 'font-changer/snapchat', 'attribute',
 'Font Changer for Snapchat — Stylish Username & Caption Text',
 'Generate fancy fonts for your Snapchat username, captions, and stories. Copy unique Unicode text styles for Snapchat.',
 'Font Changer for Snapchat',
 'Customize your Snapchat username and captions with stylish text styles. This font changer for Snapchat generates copy-paste Unicode fonts that work on Snapchat.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='telegram'), 'font-changer/telegram', 'attribute',
 'Font Changer for Telegram — Stylish Username & Bio',
 'Create stylish text for your Telegram username, bio, and channel name. Copy and paste fancy fonts on Telegram.',
 'Font Changer for Telegram',
 'Make your Telegram username and bio stand out with custom font styles. This font changer for Telegram generates Unicode text you can copy and paste into Telegram.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='pinterest'), 'font-changer/pinterest', 'attribute',
 'Font Changer for Pinterest — Aesthetic Bio & Pin Text',
 'Generate aesthetic and stylish text for Pinterest bios, pin descriptions, and profile. Copy and paste fancy fonts on Pinterest.',
 'Font Changer for Pinterest',
 'Add a touch of style to your Pinterest profile and pins with custom text fonts. This font changer for Pinterest creates aesthetic Unicode text you can copy and paste.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='threads'), 'font-changer/threads', 'attribute',
 'Font Changer for Threads — Stylish Post & Bio Text',
 'Create stylish text for Instagram Threads posts, bios, and replies. Copy and paste fancy fonts on Threads.',
 'Font Changer for Threads',
 'Make your Threads posts and bio look unique with custom font styles. This font changer for Threads generates Unicode text styles that you can copy and paste right away.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='linkedin'), 'font-changer/linkedin', 'attribute',
 'Font Changer for LinkedIn — Professional Profile Text Styles',
 'Generate professional and stylish text for your LinkedIn headline, about section, and posts. Copy-paste custom text for LinkedIn.',
 'Font Changer for LinkedIn',
 'Add a unique touch to your LinkedIn profile with custom text styles. This font changer for LinkedIn helps you generate professional Unicode text for headlines and about sections.',
 1, 'index,follow', 'published'),

-- Platform / App pages
(1, (SELECT id FROM attributes WHERE slug='apk'), 'font-changer/apk', 'attribute',
 'Font Changer APK — Android Font Tool App',
 'Download or use the Font Changer tool on Android. This page explains how to access the font changer on mobile devices.',
 'Font Changer APK',
 'Looking for a Font Changer APK? This tool works directly in your mobile browser — no APK download needed. Access stylish font generation on any Android device instantly.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='android'), 'font-changer/android', 'attribute',
 'Font Changer for Android — Stylish Text Generator',
 'Use the free Font Changer tool on Android phones and tablets. Generate fancy Unicode text directly in your mobile browser.',
 'Font Changer for Android',
 'The Font Changer works perfectly on Android devices. Open the tool in your mobile browser, type your text, and copy stylish fonts without installing any app.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='iphone'), 'font-changer/iphone', 'attribute',
 'Font Changer for iPhone — Stylish Text Generator',
 'Generate fancy Unicode text on your iPhone. The Font Changer works in Safari and any mobile browser on iOS.',
 'Font Changer for iPhone',
 'Use the Font Changer on your iPhone to create stylish text for social media, messages, and profiles. Works directly in Safari — no app installation required.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='ios'), 'font-changer/ios', 'attribute',
 'Font Changer for iOS — Stylish Text on iPhone & iPad',
 'Create fancy and bold Unicode text on iOS devices. Works on iPhone, iPad, and any iOS browser.',
 'Font Changer for iOS',
 'The Font Changer runs on iOS devices through any web browser. Generate stylish text instantly and copy it for use in social media, messages, and more.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='online'), 'font-changer/online', 'attribute',
 'Online Font Changer — Free Web-Based Text Style Tool',
 'Use the free online Font Changer from any device. Generate fancy, bold, cursive, and aesthetic Unicode text in your browser.',
 'Online Font Changer',
 'The online Font Changer lets you transform text into stylish Unicode styles from any device with a browser. No download, no sign-up — type, preview, and copy.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='mobile'), 'font-changer/mobile', 'attribute',
 'Mobile Font Changer — Stylish Text Generator for Phones',
 'Use the Font Changer on mobile phones and tablets. Works on Android and iPhone — generate and copy stylish text on the go.',
 'Mobile Font Changer',
 'The mobile Font Changer works on any phone or tablet. Open it in your browser, enter your text, and copy stylish Unicode fonts for social media, bios, and messages.',
 1, 'index,follow', 'published'),

-- Language pages
(1, (SELECT id FROM attributes WHERE slug='hindi'), 'font-changer/hindi', 'attribute',
 'Hindi Font Changer — Stylish Hindi Text Generator',
 'Transform Hindi text into stylish Unicode font styles. Generate fancy, bold, and cursive Hindi text for social media, bios, and messages.',
 'Hindi Font Changer',
 'The Hindi Font Changer converts your Hindi text into stylish Unicode fonts. Type or paste Hindi text and copy bold, fancy, cursive, and aesthetic Hindi font styles for Instagram, WhatsApp, and more.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='english'), 'font-changer/english', 'attribute',
 'English Font Changer — Stylish English Text Generator',
 'Convert English text into fancy Unicode font styles. Generate bold, cursive, italic, and aesthetic English text for any use.',
 'English Font Changer',
 'The English Font Changer transforms plain English text into stylish Unicode font styles. Type English text and copy bold, fancy, cursive, and other cool text styles instantly.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='arabic'), 'font-changer/arabic', 'attribute',
 'Arabic Font Changer — Stylish Arabic Text Generator',
 'Transform Arabic text into stylish Unicode font styles. Generate fancy and bold Arabic text for social media and messaging.',
 'Arabic Font Changer',
 'The Arabic Font Changer converts your Arabic text into stylish Unicode fonts. Type Arabic text and copy elegant, bold, and fancy Arabic font styles for social media.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='bengali'), 'font-changer/bengali', 'attribute',
 'Bengali Font Changer — Stylish Bengali Text Generator',
 'Convert Bengali text into fancy Unicode font styles. Generate stylish Bengali text for social media, bios, and messages.',
 'Bengali Font Changer',
 'The Bengali Font Changer transforms Bengali text into stylish Unicode fonts. Type Bengali text and copy bold, fancy, and cursive Bengali font styles.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='punjabi'), 'font-changer/punjabi', 'attribute',
 'Punjabi Font Changer — Stylish Punjabi Text Generator',
 'Transform Punjabi text into stylish Unicode font styles. Generate fancy, bold, and cursive Punjabi text for social media.',
 'Punjabi Font Changer',
 'The Punjabi Font Changer converts Punjabi text into stylish Unicode fonts. Type Punjabi text and copy bold, fancy, and cursive Punjabi font styles for Instagram and WhatsApp.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='gujarati'), 'font-changer/gujarati', 'attribute',
 'Gujarati Font Changer — Stylish Gujarati Text Generator',
 'Convert Gujarati text into fancy Unicode font styles. Generate stylish Gujarati text for social media and messaging.',
 'Gujarati Font Changer',
 'The Gujarati Font Changer transforms Gujarati text into stylish Unicode fonts. Type Gujarati text and copy bold, fancy, and cursive Gujarati font styles.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='marathi'), 'font-changer/marathi', 'attribute',
 'Marathi Font Changer — Stylish Marathi Text Generator',
 'Transform Marathi text into stylish Unicode font styles. Generate fancy, bold, and cursive Marathi text for social media.',
 'Marathi Font Changer',
 'The Marathi Font Changer converts Marathi text into stylish Unicode fonts. Type Marathi text and copy bold, fancy, and cursive Marathi font styles.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='tamil'), 'font-changer/tamil', 'attribute',
 'Tamil Font Changer — Stylish Tamil Text Generator',
 'Convert Tamil text into fancy Unicode font styles. Generate stylish Tamil text for social media, bios, and messages.',
 'Tamil Font Changer',
 'The Tamil Font Changer transforms Tamil text into stylish Unicode fonts. Type Tamil text and copy bold, fancy, and cursive Tamil font styles.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='telugu'), 'font-changer/telugu', 'attribute',
 'Telugu Font Changer — Stylish Telugu Text Generator',
 'Transform Telugu text into stylish Unicode font styles. Generate fancy, bold, and cursive Telugu text for social media.',
 'Telugu Font Changer',
 'The Telugu Font Changer converts Telugu text into stylish Unicode fonts. Type Telugu text and copy bold, fancy, and cursive Telugu font styles for Instagram and WhatsApp.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='urdu'), 'font-changer/urdu', 'attribute',
 'Urdu Font Changer — Stylish Urdu Text Generator',
 'Convert Urdu text into fancy Unicode font styles. Generate stylish Urdu text for social media, bios, and messaging.',
 'Urdu Font Changer',
 'The Urdu Font Changer transforms Urdu text into stylish Unicode fonts. Type Urdu text and copy bold, fancy, and cursive Urdu font styles.',
 1, 'index,follow', 'published'),

-- Style pages
(1, (SELECT id FROM attributes WHERE slug='stylish'), 'font-changer/stylish', 'attribute',
 'Stylish Font Changer — Modern Font Text Generator',
 'Generate modern and stylish Unicode font styles. Convert any text into bold, cursive, italic, and aesthetic text styles.',
 'Stylish Font Changer',
 'The Stylish Font Changer transforms your text into modern Unicode font styles. Type any text and copy stylish, bold, cursive, and aesthetic font styles for social media.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='fancy'), 'font-changer/fancy', 'attribute',
 'Fancy Font Changer — Decorative Text Style Generator',
 'Generate fancy and decorative Unicode text styles. Convert text into bold, cursive, bubble, and aesthetic fancy fonts.',
 'Fancy Font Changer',
 'The Fancy Font Changer turns your text into decorative Unicode styles. Type any text and copy fancy, bold, bubble, cursive, and aesthetic font styles for social media profiles.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='bold'), 'font-changer/bold', 'attribute',
 'Bold Font Changer — Bold Unicode Text Generator',
 'Generate bold Unicode text styles. Transform text into bold, double-struck, and heavy-weight Unicode fonts for emphasis.',
 'Bold Font Changer',
 'The Bold Font Changer converts your text into bold Unicode styles. Type any text and copy bold, double-struck, and heavy-weight font styles for social media and messaging.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='cursive'), 'font-changer/cursive', 'attribute',
 'Cursive Font Changer — Handwritten Style Text Generator',
 'Generate cursive and handwritten-style Unicode text. Transform text into elegant script and cursive font styles.',
 'Cursive Font Changer',
 'The Cursive Font Changer transforms text into cursive and handwritten-style Unicode fonts. Type any text and copy elegant script, cursive, and calligraphy-style text.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='italic'), 'font-changer/italic', 'attribute',
 'Italic Font Changer — Italic Unicode Text Generator',
 'Generate italic-style Unicode text. Transform text into italic and slanted Unicode font styles for styling.',
 'Italic Font Changer',
 'The Italic Font Changer converts text into italic Unicode styles. Type any text and copy italic, slanted, and stylized font styles for social media and profiles.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='gothic'), 'font-changer/gothic', 'attribute',
 'Gothic Font Changer — Old English Style Text Generator',
 'Generate Gothic and Old English-style Unicode text. Transform text into dark, bold, and medieval-style font styles.',
 'Gothic Font Changer',
 'The Gothic Font Changer transforms text into Gothic and Old English-style Unicode fonts. Type any text and copy bold gothic, blackletter, and medieval-style text styles.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='calligraphy'), 'font-changer/calligraphy', 'attribute',
 'Calligraphy Font Changer — Elegant Script Text Generator',
 'Generate calligraphy-style Unicode text. Transform text into elegant script and artistic font styles for special uses.',
 'Calligraphy Font Changer',
 'The Calligraphy Font Changer converts text into calligraphy-style Unicode fonts. Type any text and copy elegant script, artistic, and sophisticated font styles.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='aesthetic'), 'font-changer/aesthetic', 'attribute',
 'Aesthetic Font Changer — Pretty Text Style Generator',
 'Generate aesthetic and pretty Unicode text styles. Transform text into cute, dreamy, and visually appealing font styles.',
 'Aesthetic Font Changer',
 'The Aesthetic Font Changer turns text into pretty Unicode styles. Type any text and copy aesthetic, cute, dreamy, and visually pleasing font styles for social media.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='cute'), 'font-changer/cute', 'attribute',
 'Cute Font Changer — Playful Text Style Generator',
 'Generate cute and playful Unicode text styles. Transform text into adorable, fun, and sweet font styles for social media.',
 'Cute Font Changer',
 'The Cute Font Changer converts text into cute Unicode font styles. Type any text and copy adorable, playful, and sweet font styles for bios, captions, and chats.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='elegant'), 'font-changer/elegant', 'attribute',
 'Elegant Font Changer — Sophisticated Text Style Generator',
 'Generate elegant and sophisticated Unicode text styles. Transform text into refined and classy font styles.',
 'Elegant Font Changer',
 'The Elegant Font Changer transforms text into elegant Unicode font styles. Type any text and copy sophisticated, classy, and refined font styles for profiles and special posts.',
 1, 'index,follow', 'published'),

-- Gaming pages
(1, (SELECT id FROM attributes WHERE slug='free-fire'), 'font-changer/free-fire', 'attribute',
 'Font Changer for Free Fire — Stylish FF Name Generator',
 'Create stylish usernames and text for Free Fire. Generate fancy, bold, and cool Unicode names for your Free Fire profile.',
 'Font Changer for Free Fire',
 'Use the Font Changer for Free Fire to create stylish usernames, squad names, and profile text. Generate bold, fancy, and cool Unicode text and copy it for your Free Fire gaming profile.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='pubg'), 'font-changer/pubg', 'attribute',
 'Font Changer for PUBG — Stylish PUBG Name Generator',
 'Create stylish usernames, clan names, and text for PUBG. Generate fancy, bold, and cool Unicode names for your PUBG profile.',
 'Font Changer for PUBG',
 'Use the Font Changer for PUBG to create stylish usernames, squad names, and text for your PUBG profile. Generate bold, fancy, and cool Unicode text to copy and paste.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='bgmi'), 'font-changer/bgmi', 'attribute',
 'Font Changer for BGMI — Stylish BGMI Name Generator',
 'Create stylish usernames, clan tags, and text for BGMI. Generate fancy, bold, and cool Unicode names for your BGMI profile.',
 'Font Changer for BGMI',
 'Use the Font Changer for BGMI to create stylish usernames, clan tags, and profile text. Generate bold, fancy, and cool Unicode text for your BGMI gaming identity.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='minecraft'), 'font-changer/minecraft', 'attribute',
 'Font Changer for Minecraft — Stylish MC Username Generator',
 'Create stylish usernames, signs, and chat text for Minecraft. Generate fancy, bold, and cool Unicode text for your Minecraft world.',
 'Font Changer for Minecraft',
 'Use the Font Changer for Minecraft to create stylish usernames for your Minecraft account and generate fancy text for signs, book titles, and chat in your Minecraft world.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='roblox'), 'font-changer/roblox', 'attribute',
 'Font Changer for Roblox — Stylish Roblox Username Generator',
 'Create stylish usernames and text for Roblox. Generate fancy, bold, and cool Unicode names for your Roblox profile and groups.',
 'Font Changer for Roblox',
 'Use the Font Changer for Roblox to create stylish usernames for your Roblox profile, group names, and game chat. Generate fancy, bold, and cool Unicode text to copy and paste.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='fortnite'), 'font-changer/fortnite', 'attribute',
 'Font Changer for Fortnite — Stylish Fortnite Gamertag Generator',
 'Create stylish gamertags and text for Fortnite. Generate fancy, bold, and cool Unicode names for your Fortnite profile.',
 'Font Changer for Fortnite',
 'Use the Font Changer for Fortnite to create stylish gamertags and profile text. Generate fancy, bold, and cool Unicode text for your Fortnite battle pass and in-game name.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='valorant'), 'font-changer/valorant', 'attribute',
 'Font Changer for Valorant — Stylish Valorant Name Generator',
 'Create stylish agent names and text for Valorant. Generate fancy, bold, and cool Unicode names for your Valorant profile and in-game tags.',
 'Font Changer for Valorant',
 'Use the Font Changer for Valorant to create stylish names for your agent and profile. Generate fancy, bold, and cool Unicode text for Valorant and copy it for your gaming identity.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='cod-mobile'), 'font-changer/cod-mobile', 'attribute',
 'Font Changer for COD Mobile — Stylish CODM Name Generator',
 'Create stylish usernames, clan tags, and text for Call of Duty Mobile. Generate fancy, bold, and cool Unicode names for your CODM profile.',
 'Font Changer for COD Mobile',
 'Use the Font Changer for COD Mobile to create stylish usernames, clan tags, and profile text. Generate bold, fancy, and cool Unicode text for your CODM gaming identity.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='clash-of-clans'), 'font-changer/clash-of-clans', 'attribute',
 'Font Changer for Clash of Clans — Stylish Clan Name Generator',
 'Create stylish clan names and player tags for Clash of Clans. Generate fancy, bold, and cool Unicode text for your CoC profile.',
 'Font Changer for Clash of Clans',
 'Use the Font Changer for Clash of Clans to create stylish clan names, player tags, and profile text. Generate fancy, bold, and cool Unicode text for your Clash of Clans gaming identity.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='among-us'), 'font-changer/among-us', 'attribute',
 'Font Changer for Among Us — Stylish Player Name Generator',
 'Create stylish player names and text for Among Us. Generate fancy, bold, and cool Unicode names for your Among Us profile and chat.',
 'Font Changer for Among Us',
 'Use the Font Changer for Among Us to create stylish player names and chat text. Generate fancy, bold, and cool Unicode text for your Among Us gaming sessions.',
 1, 'index,follow', 'published'),

-- Use case pages
(1, (SELECT id FROM attributes WHERE slug='username'), 'font-changer/username', 'attribute',
 'Stylish Username Generator — Font Changer for Unique Names',
 'Generate stylish and unique usernames with the Font Changer. Create bold, fancy, cursive, and cool text for your social media and gaming usernames.',
 'Stylish Username Generator',
 'The Font Changer helps you create stylish and unique usernames for social media, gaming, and online profiles. Generate bold, fancy, cursive, and cool Unicode text and copy your new username.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='nickname'), 'font-changer/nickname', 'attribute',
 'Fancy Nickname Generator — Font Changer for Cool Nicknames',
 'Generate fancy and cool nicknames with the Font Changer. Create bold, cursive, and stylish text for your nicknames on any platform.',
 'Fancy Nickname Generator',
 'The Font Changer helps you generate fancy and cool nicknames for chat, gaming, and profiles. Type your nickname and copy bold, cursive, and stylish Unicode text styles.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='bio'), 'font-changer/bio', 'attribute',
 'Instagram & Social Media Bio Font Generator',
 'Generate stylish font text for bios on Instagram, WhatsApp, Discord, and other platforms. Create bold, fancy, and cool bio text with the Font Changer.',
 'Bio Font Generator',
 'Use the Font Changer to create stylish bio text for Instagram, WhatsApp status, Discord, and more. Generate bold, fancy, cursive, and aesthetic fonts for your profile bio.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='caption'), 'font-changer/caption', 'attribute',
 'Social Media Caption Font Generator — Stylish Post Captions',
 'Generate stylish caption text for social media posts. Create bold, fancy, and cool captions for Instagram, Facebook, and other platforms.',
 'Caption Font Generator',
 'The Font Changer helps you create stylish captions for social media posts. Type your caption and copy bold, fancy, cursive, and cool Unicode text for Instagram, Facebook, and beyond.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='status'), 'font-changer/status', 'attribute',
 'Status Font Generator — Stylish WhatsApp & Discord Status Text',
 'Generate stylish status text for WhatsApp, Discord, and other platforms. Create bold, fancy, and cool status text with the Font Changer.',
 'Status Font Generator',
 'Use the Font Changer to create stylish status text for WhatsApp status, Discord status, and other platforms. Generate bold, fancy, cursive, and aesthetic Unicode font styles.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='comment'), 'font-changer/comment', 'attribute',
 'Stylish Comment Font Generator — Fancy Text for Comments',
 'Generate stylish comment text for YouTube, Instagram, Facebook, and other platforms. Create bold, fancy, and cool comment text with the Font Changer.',
 'Comment Font Generator',
 'The Font Changer helps you create stylish comments for YouTube, Instagram, Facebook, and other platforms. Generate bold, fancy, cursive, and cool Unicode text for your comments.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='gaming-name'), 'font-changer/gaming-name', 'attribute',
 'Gaming Name Font Generator — Stylish Gamertag Creator',
 'Generate stylish gaming names and gamertags with the Font Changer. Create bold, fancy, cursive, and cool Unicode names for any game.',
 'Gaming Name Font Generator',
 'The Font Changer helps you create stylish gaming names for any game. Generate bold, fancy, cursive, and cool Unicode text and copy your new gamertag for PUBG, Free Fire, Roblox, and more.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='profile-name'), 'font-changer/profile-name', 'attribute',
 'Stylish Profile Name Generator — Font Changer for Profiles',
 'Generate stylish profile names for social media, gaming, and messaging apps. Create bold, fancy, and cool profile names with the Font Changer.',
 'Profile Name Generator',
 'The Font Changer helps you create stylish profile names for Instagram, WhatsApp, Discord, and gaming profiles. Generate bold, fancy, cursive, and cool Unicode text for your profile.',
 1, 'index,follow', 'published'),

(1, (SELECT id FROM attributes WHERE slug='clan-name'), 'font-changer/clan-name', 'attribute',
 'Fancy Clan Name Generator — Stylish Guild & Clan Names',
 'Generate fancy and stylish clan names for PUBG, Free Fire, Discord, and other gaming communities. Create bold and cool Unicode clan names.',
 'Clan Name Generator',
 'The Font Changer helps you create fancy clan names for PUBG, Free Fire, BGMI, Discord, and other gaming communities. Generate bold, fancy, cursive, and cool Unicode text for your clan.',
 1, 'index,follow', 'published');

-- ============================================
-- FAQs (for core page - font-changer)
-- ============================================

INSERT OR IGNORE INTO faqs (page_id, question, answer, sort_order)
SELECT id, question, answer, sort_order FROM (
  SELECT
    (SELECT id FROM seo_pages WHERE slug='font-changer') as page_id,
    'What is a font changer?' as question,
    'A font changer is an online tool that transforms your plain text into stylish Unicode font styles — such as bold, cursive, italic, bubble, gothic, and more. You can then copy the styled text and paste it into social media bios, captions, comments, messages, and profiles. No software installation or login is required.' as answer,
    1 as sort_order
  UNION ALL SELECT
    (SELECT id FROM seo_pages WHERE slug='font-changer'),
    'Are these real font files?',
    'No. The Font Changer tool generates text using Unicode characters — special characters from the Unicode standard that look like styled fonts. These are not downloadable font files (like .ttf or .otf). They work by replacing regular letters with Unicode equivalents that display in a similar style. The text remains plain text, so you can copy and paste it anywhere that supports Unicode.' as answer,
    2 as sort_order
  UNION ALL SELECT
    (SELECT id FROM seo_pages WHERE slug='font-changer'),
    'Is the font changer free to use?',
    'Yes, the Font Changer is completely free to use. There are no subscriptions, no hidden fees, and no registration required. Type your text, choose a style, and copy it — all for free.' as answer,
    3 as sort_order
  UNION ALL SELECT
    (SELECT id FROM seo_pages WHERE slug='font-changer'),
    'Do I need to install anything?',
    'No installation is needed. The Font Changer works entirely in your web browser. Open the page on any device — phone, tablet, or computer — type your text, and start generating styled text instantly.' as answer,
    4 as sort_order
  UNION ALL SELECT
    (SELECT id FROM seo_pages WHERE slug='font-changer'),
    'Does it work on mobile phones?',
    'Yes, the Font Changer is fully mobile-responsive. It works on Android phones, iPhones, tablets, and any device with a modern web browser. The interface adjusts to smaller screens and all copy buttons are easy to tap on mobile.' as answer,
    5 as sort_order
  UNION ALL SELECT
    (SELECT id FROM seo_pages WHERE slug='font-changer'),
    'Can I use the generated text on Instagram?',
    'Yes. The stylish Unicode text generated by the Font Changer works on Instagram for bios, captions, comments, and display names (where Instagram allows Unicode). Copy the style you like and paste it directly into your Instagram app.' as answer,
    6 as sort_order
  UNION ALL SELECT
    (SELECT id FROM seo_pages WHERE slug='font-changer'),
    'What languages does the font changer support?',
    'The Font Changer works with any text that uses Unicode characters, including English, Hindi, Arabic, Bengali, Punjabi, Gujarati, Marathi, Tamil, Telugu, Urdu, and many other languages. Type or paste text in any supported language and generate stylish font styles for it.' as answer,
    7 as sort_order
  UNION ALL SELECT
    (SELECT id FROM seo_pages WHERE slug='font-changer'),
    'Can I download the font styles?',
    'The Font Changer generates Unicode text styles, not downloadable font files. The output is plain text that you copy and paste. If you need an actual downloadable font file (.ttf, .otf), you would need to get that from a font distribution site. The Unicode styles here are for immediate copy-paste use in text fields.' as answer,
    8 as sort_order
  UNION ALL SELECT
    (SELECT id FROM seo_pages WHERE slug='font-changer'),
    'Why do some characters not change style?',
    'Some Unicode transformations are not available for every character. When a character does not have a styled Unicode equivalent, the Font Changer preserves the original character. This ensures your text remains readable. Characters like numbers, punctuation, and certain Unicode ranges may fall back to the original.' as answer,
    9 as sort_order
  UNION ALL SELECT
    (SELECT id FROM seo_pages WHERE slug='font-changer'),
    'Is my text sent to a server?',
    'No. The Font Changer performs all text transformations in your browser using JavaScript. Your text is never sent to any server. The tool runs entirely on the client side, so your input stays private.' as answer,
    10 as sort_order
) AS tmp
WHERE tmp.page_id IS NOT NULL;

-- ============================================
-- RELATED PAGES (manual topically relevant links)
-- ============================================
-- Note: related pages are computed dynamically from D1 based on shared entity,
-- same attribute groups, and keyword relevance. This query defines what gets shown.

-- ============================================
-- SAMPLE REDIRECTS
-- ============================================
INSERT OR IGNORE INTO redirects (source_path, destination_path, status_code) VALUES
('/font-changer/instagraam', '/font-changer/instagram', 301),
('/font-changer/facebok', '/font-changer/facebook', 301);

