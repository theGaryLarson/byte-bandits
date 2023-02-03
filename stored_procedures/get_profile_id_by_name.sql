USE targeted_marketing;
DELIMITER //
CREATE FUNCTION get_profile_id (first_name VARCHAR(255), last_name VARCHAR(255))
RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
  DECLARE result INT;
  SELECT id INTO result
  FROM targeted_marketing.core_profile
  WHERE f_name = first_name AND l_name = last_name;
  RETURN result;
END//
DELIMITER ;

SELECT get_profile_id("John", "Doe") as "Profile ID";