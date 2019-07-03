---
--- MySQL sql script
-- for moving from an URL to another one
--- when restore a WordPress site (database)
---


UPDATE wp_options SET option_value = replace(option_value, 'http://oldURL.com', 'https://newURL.com') WHERE option_name = 'home' OR option_name = 'siteurl';
UPDATE wp_options SET option_value = replace(option_value, 'http://www.oldURL.com', 'https://newURL.com') ;

UPDATE wp_posts SET guid = replace(guid, 'http://www.oldURL.com','https://newURL.com');

UPDATE wp_posts SET post_content = replace(post_content, 'http://www.oldURL.com', 'https://newURL.com');

UPDATE wp_postmeta SET meta_value = replace(meta_value,'http://www.oldURL.com','https://newURL.com');

