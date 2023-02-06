USE targeted_marketing;
-- DROP PROCEDURE IF EXISTS insert_platform;
-- SHOW CREATE TABLE social_media_platform;

DELIMITER //
# inserts platform into social_media_platform table if not already present
CREATE PROCEDURE `insert_platform` 
(
	platform VARCHAR(255)
)
BEGIN
IF NOT check_platform_exists(platform) THEN
	INSERT INTO `social_media_platform` (platform)
    VALUES (platform);
END IF;
END//
DELIMITER ;

CALL insert_platform('BENDOVER');