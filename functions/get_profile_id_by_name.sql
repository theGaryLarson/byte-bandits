USE targeted_marketing;
DELIMITER //
CREATE FUNCTION get_profile_id_by_name
(
	first_name VARCHAR(255),
    last_name VARCHAR(255)
)
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

# error worth mentioning while its obvious. John Doe PK is in every row
SELECT get_profile_id_by_name("John", "Doe"); -- as "Profile ID", f_name, l_name
-- FROM core_profile;