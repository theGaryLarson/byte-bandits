USE targeted_marketing;
DELIMITER //
# Checks if social media platform exists
CREATE FUNCTION check_platform_exists
(
	platform VARCHAR(255)
)
RETURNS BOOLEAN
DETERMINISTIC READS SQL DATA
BEGIN
DECLARE found_platform VARCHAR(255);

SELECT `targeted_marketing`.social_media_platform.platform
INTO found_platform
FROM social_media_platform
WHERE `social_media_platform`.platform = platform;

IF found_platform IS NULL THEN
	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END//
DELIMITER ;

SELECT check_platform_exists('BENDOVER') AS 'Result';