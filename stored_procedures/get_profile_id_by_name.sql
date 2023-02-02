USE targeted_marketing;
DELIMITER //
CREATE PROCEDURE get_profile_id (IN first_name VARCHAR(255), IN last_name VARCHAR(255))
BEGIN
  SELECT id
  FROM targeted_marketing.core_profile
  WHERE f_name = first_name AND l_name = last_name;
END//

DELIMITER ;
CALL get_profile_id("John", "Doe");