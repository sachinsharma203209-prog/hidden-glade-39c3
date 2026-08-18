-- Seed data for Font Changer Entity SEO Platform
-- Run: wrangler d1 execute font-changer-db --file=seed/font-changer.sql
--
-- Attribute group IDs (inserted in order):
-- 1 = social-media, 2 = platform, 3 = language, 4 = style, 5 = gaming, 6 = use-case

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
-- ATTRIBUTES (entity_id = 1, group_id hardcoded)
-- Split into batches to avoid SQLite compound SELECT limits
-- ============================================

-- --- Social Media (group_id = 1) ---
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 1, 'instagram', 'Instagram', 'Stylish fonts for Instagram bios, captions, and profiles', 1);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 1, 'facebook', 'Facebook', 'Custom text styles for Facebook posts, comments, and profiles', 2);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 1, 'whatsapp', 'WhatsApp', 'Fancy text for WhatsApp statuses, messages, and display names', 3);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 1, 'twitter', 'Twitter / X', 'Stylish text for tweets, bios, and display names on Twitter/X', 4);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 1, 'tiktok', 'TikTok', 'Trending font styles for TikTok bios, captions, and comments', 5);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 1, 'snapchat', 'Snapchat', 'Custom fonts for Snapchat usernames, captions, and stories', 6);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 1, 'telegram', 'Telegram', 'Stylish text for Telegram usernames, bios, and channel names', 7);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 1, 'pinterest', 'Pinterest', 'Aesthetic font styles for Pinterest bios, pins, and descriptions', 8);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 1, 'threads', 'Threads', 'Custom text styles for Instagram Threads posts and bios', 9);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 1, 'linkedin', 'LinkedIn', 'Professional font styles for LinkedIn headlines, about sections, and posts', 10);

-- --- Platform / App (group_id = 2) ---
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 2, 'apk', 'APK', 'Mobile app version of the font changer tool for Android devices', 1);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 2, 'android', 'Android', 'Font changer optimized for Android phones and tablets', 2);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 2, 'iphone', 'iPhone', 'Font changer for iPhone and iOS devices', 3);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 2, 'ios', 'iOS', 'Stylish text generator that works on iOS devices', 4);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 2, 'online', 'Online', 'Free online font changer tool accessible from any device', 5);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 2, 'mobile', 'Mobile', 'Mobile-friendly font changer tool for phones and tablets', 6);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 2, 'pc', 'PC', 'Desktop-friendly font generator for Windows and Mac computers', 7);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 2, 'web', 'Web', 'Browser-based font changer tool - no installation required', 8);

-- --- Language (group_id = 3) ---
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 3, 'hindi', 'Hindi', 'Stylish Hindi text generator - font changer for Hindi text', 1);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 3, 'english', 'English', 'Font styles for English text, letters, and words', 2);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 3, 'arabic', 'Arabic', 'Unicode font styles for Arabic text and characters', 3);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 3, 'bengali', 'Bengali', 'Fancy text styles for Bengali script', 4);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 3, 'punjabi', 'Punjabi', 'Font changer for Punjabi text and Gurmukhi script', 5);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 3, 'gujarati', 'Gujarati', 'Stylish font styles for Gujarati text', 6);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 3, 'marathi', 'Marathi', 'Custom text styles for Marathi language', 7);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 3, 'tamil', 'Tamil', 'Font styles for Tamil script and text', 8);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 3, 'telugu', 'Telugu', 'Fancy font generator for Telugu text', 9);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 3, 'urdu', 'Urdu', 'Stylish text styles for Urdu language and script', 10);

-- --- Font Style (group_id = 4) ---
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 4, 'stylish', 'Stylish', 'Modern and stylish Unicode font transformations', 1);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 4, 'fancy', 'Fancy', 'Fancy and decorative font styles for social media', 2);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 4, 'bold', 'Bold', 'Bold Unicode text styles for emphasis and impact', 3);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 4, 'cursive', 'Cursive', 'Cursive and handwritten-style Unicode text', 4);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 4, 'italic', 'Italic', 'Italic-style Unicode font transformations', 5);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 4, 'gothic', 'Gothic', 'Gothic and old English-style Unicode text', 6);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 4, 'calligraphy', 'Calligraphy', 'Calligraphy-style elegant text transformations', 7);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 4, 'aesthetic', 'Aesthetic', 'Aesthetic and pretty Unicode font styles', 8);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 4, 'cute', 'Cute', 'Cute and playful font styles for social media', 9);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 4, 'elegant', 'Elegant', 'Elegant and sophisticated font transformations', 10);

-- --- Gaming (group_id = 5) ---
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 5, 'free-fire', 'Free Fire', 'Stylish names and text for Free Fire gamers', 1);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 5, 'pubg', 'PUBG', 'Fancy usernames and clan names for PUBG players', 2);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 5, 'bgmi', 'BGMI', 'Font styles for BGMI gaming profiles and squad names', 3);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 5, 'minecraft', 'Minecraft', 'Custom text styles for Minecraft usernames, signs, and chat', 4);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 5, 'roblox', 'Roblox', 'Fancy text for Roblox usernames, group names, and game chat', 5);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 5, 'fortnite', 'Fortnite', 'Stylish names for Fortnite gamertags and battle passes', 6);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 5, 'valorant', 'Valorant', 'Font changer for Valorant agent names and in-game text', 7);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 5, 'cod-mobile', 'Call of Duty Mobile', 'Custom text for CODM usernames, clan tags, and text chat', 8);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 5, 'clash-of-clans', 'Clash of Clans', 'Fancy text for Clash of Clans clan names and player tags', 9);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 5, 'among-us', 'Among Us', 'Stylish text for Among Us player names and chat', 10);

-- --- Use Case (group_id = 6) ---
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 6, 'username', 'Username', 'Stylish and unique usernames for social media and gaming', 1);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 6, 'nickname', 'Nickname', 'Fancy nicknames for profiles, chat, and games', 2);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 6, 'bio', 'Bio', 'Stylish text for social media bios and profile descriptions', 3);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 6, 'caption', 'Caption', 'Fancy captions for social media posts and photos', 4);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 6, 'status', 'Status', 'Custom status text for WhatsApp, Discord, and other platforms', 5);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 6, 'comment', 'Comment', 'Stylish comments for YouTube, Instagram, Facebook, and more', 6);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 6, 'post', 'Post', 'Fancy text for social media posts and updates', 7);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 6, 'gaming-name', 'Gaming Name', 'Unique and stylish gaming usernames for any game', 8);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 6, 'profile-name', 'Profile Name', 'Custom profile names for social media and apps', 9);
INSERT OR IGNORE INTO attributes (entity_id, group_id, slug, name, description, sort_order) VALUES
(1, 6, 'clan-name', 'Clan Name', 'Fancy clan and guild names for gaming communities', 10);
