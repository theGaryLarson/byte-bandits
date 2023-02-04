USE targeted_marketing;
DELIMITER //
# returns social media platform primary key (id)
CREATE FUNCTION get_sm_platform_id
(
	platform VARCHAR(255)
)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
DECLARE result_id INT;

SELECT id INTO result_id
FROM social_media_platform
WHERE social_media_platform.platform = platform;

RETURN result_id;
END//
DELIMITER ;

-- 11	Facebook
-- 12	Twitter
-- 13	Instagram
-- 14	LinkedIn
-- 15	YouTube
-- 16	BENDOVER
SELECT get_sm_platform_id("BENDOVER");
SELECT get_sm_platform_id("Twitter");
SELECT get_sm_platform_id("UGUGBUBUG");

	