-- Keywords seed: part 1 of 3
-- Core + Social Media + Platform keywords

INSERT OR IGNORE INTO keywords (entity_id, attribute_id, keyword, slug, search_volume, keyword_difficulty, search_intent, priority, status) VALUES
-- Core brand keywords (entity_id = 1, no attribute)
(1, NULL, 'font changer', 'font-changer', 70900, 45.0, 'tool', 1, 'active'),
(1, NULL, 'font changer tool', 'font-changer-tool', 12000, 38.0, 'tool', 2, 'active'),
(1, NULL, 'fancy text generator', 'fancy-text-generator', 40500, 42.0, 'tool', 3, 'active'),
(1, NULL, 'stylish text generator', 'stylish-text-generator', 27100, 40.0, 'tool', 4, 'active'),
(1, NULL, 'copy and paste fonts', 'copy-paste-fonts', 18100, 35.0, 'tool', 5, 'active'),
(1, NULL, 'unicode font changer', 'unicode-font-changer', 5400, 28.0, 'tool', 6, 'active'),
(1, NULL, 'cool fonts generator', 'cool-fonts-generator', 9800, 32.0, 'tool', 7, 'active'),
(1, NULL, 'text style changer', 'text-style-changer', 3600, 25.0, 'tool', 8, 'active'),
-- Instagram (attribute_id = 1)
(NULL, 1, 'font changer instagram', 'font-changer-instagram', 22200, 44.0, 'social-media', 1, 'active'),
(NULL, 1, 'instagram font generator', 'instagram-font-generator', 12100, 40.0, 'social-media', 2, 'active'),
(NULL, 1, 'instagram stylish text', 'instagram-stylish-text', 6500, 35.0, 'social-media', 3, 'active'),
(NULL, 1, 'instagram bio font', 'instagram-bio-font', 4200, 32.0, 'social-media', 4, 'active'),
-- Facebook (attribute_id = 2)
(NULL, 2, 'font changer facebook', 'font-changer-facebook', 8400, 38.0, 'social-media', 1, 'active'),
(NULL, 2, 'facebook stylish text', 'facebook-stylish-text', 3200, 30.0, 'social-media', 2, 'active'),
-- WhatsApp (attribute_id = 3)
(NULL, 3, 'font changer whatsapp', 'font-changer-whatsapp', 13500, 40.0, 'social-media', 1, 'active'),
(NULL, 3, 'whatsapp fancy text', 'whatsapp-fancy-text', 5600, 32.0, 'social-media', 2, 'active'),
(NULL, 3, 'whatsapp status font', 'whatsapp-status-font', 7800, 34.0, 'social-media', 3, 'active'),
-- Twitter (attribute_id = 4)
(NULL, 4, 'twitter font changer', 'twitter-font-changer', 6700, 35.0, 'social-media', 1, 'active'),
-- TikTok (attribute_id = 5)
(NULL, 5, 'tiktok font generator', 'tiktok-font-generator', 11000, 42.0, 'social-media', 1, 'active'),
(NULL, 5, 'tiktok stylish text', 'tiktok-stylish-text', 4900, 35.0, 'social-media', 2, 'active'),
-- Snapchat (attribute_id = 6)
(NULL, 6, 'snapchat font changer', 'snapchat-font-changer', 2900, 28.0, 'social-media', 1, 'active'),
-- Telegram (attribute_id = 7)
(NULL, 7, 'telegram font generator', 'telegram-font-generator', 2100, 25.0, 'social-media', 1, 'active'),
-- Pinterest (attribute_id = 8)
(NULL, 8, 'pinterest font changer', 'pinterest-font-changer', 1400, 22.0, 'social-media', 1, 'active'),
-- Threads (attribute_id = 9)
(NULL, 9, 'threads font changer', 'threads-font-changer', 1800, 24.0, 'social-media', 1, 'active'),
-- LinkedIn (attribute_id = 10)
(NULL, 10, 'linkedin font changer', 'linkedin-font-changer', 900, 20.0, 'social-media', 1, 'active'),
-- APK (attribute_id = 11)
(NULL, 11, 'font changer apk', 'font-changer-apk', 14800, 36.0, 'app/platform', 1, 'active'),
(NULL, 11, 'font changer app', 'font-changer-app', 8900, 34.0, 'app/platform', 2, 'active'),
-- Android (attribute_id = 12)
(NULL, 12, 'font changer android', 'font-changer-android', 4500, 30.0, 'app/platform', 1, 'active'),
-- iPhone (attribute_id = 13)
(NULL, 13, 'font changer iphone', 'font-changer-iphone', 3800, 28.0, 'app/platform', 1, 'active'),
-- iOS (attribute_id = 14)
(NULL, 14, 'font changer ios', 'font-changer-ios', 2900, 27.0, 'app/platform', 2, 'active'),
-- Mobile (attribute_id = 16)
(NULL, 16, 'font changer mobile', 'font-changer-mobile', 2100, 25.0, 'app/platform', 1, 'active'),
-- Online (attribute_id = 15)
(NULL, 15, 'online font changer', 'online-font-changer', 20500, 40.0, 'app/platform', 1, 'active'),
-- Web (attribute_id = 18)
(NULL, 18, 'web font changer', 'web-font-changer', 1600, 22.0, 'app/platform', 1, 'active'),
-- Hindi (attribute_id = 21)
(NULL, 21, 'hindi font changer', 'hindi-font-changer', 19000, 42.0, 'language', 1, 'active'),
(NULL, 21, 'hindi stylish text', 'hindi-stylish-text', 5400, 34.0, 'language', 2, 'active'),
(NULL, 21, 'hindi fancy text generator', 'hindi-fancy-text-generator', 3200, 30.0, 'language', 3, 'active'),
-- English (attribute_id = 22)
(NULL, 22, 'english font changer', 'english-font-changer', 3100, 25.0, 'language', 1, 'active'),
-- Arabic (attribute_id = 23)
(NULL, 23, 'arabic font changer', 'arabic-font-changer', 1800, 22.0, 'language', 1, 'active'),
-- Bengali (attribute_id = 24)
(NULL, 24, 'bengali font changer', 'bengali-font-changer', 1200, 20.0, 'language', 1, 'active'),
-- Punjabi (attribute_id = 25)
(NULL, 25, 'punjabi font changer', 'punjabi-font-changer', 2400, 24.0, 'language', 1, 'active'),
-- Gujarati (attribute_id = 26)
(NULL, 26, 'gujarati font changer', 'gujarati-font-changer', 900, 18.0, 'language', 1, 'active'),
-- Marathi (attribute_id = 27)
(NULL, 27, 'marathi font changer', 'marathi-font-changer', 1100, 20.0, 'language', 1, 'active'),
-- Tamil (attribute_id = 28)
(NULL, 28, 'tamil font changer', 'tamil-font-changer', 1400, 21.0, 'language', 1, 'active'),
-- Telugu (attribute_id = 29)
(NULL, 29, 'telugu font changer', 'telugu-font-changer', 1300, 21.0, 'language', 1, 'active'),
-- Urdu (attribute_id = 30)
(NULL, 30, 'urdu font changer', 'urdu-font-changer', 1500, 22.0, 'language', 1, 'active');
