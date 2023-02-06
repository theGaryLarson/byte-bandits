USE targeted_marketing;
DELIMITER //
CREATE PROCEDURE insert_bendover_names_into_core_profile()
BEGIN
	DECLARE f_name_var 		VARCHAR(45);
	DECLARE l_name_var 		VARCHAR(45);
    DECLARE row_not_found 	TINYINT DEFAULT FALSE;
    DECLARE present_id		INT;
    
	DECLARE cur CURSOR FOR
		SELECT first_name, last_name
		FROM bendover_data_feed;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET row_not_found = TRUE;
    OPEN cur;
    
    WHILE row_not_found = FALSE DO
		FETCH cur INTO f_name_var, l_Name_var;
        SELECT id
        INTO present_id
        FROM core_profile
        WHERE f_name = f_name_var AND l_name = l_name_var;
        
		IF present_id IS NULL THEN
			INSERT INTO core_profile(f_name, l_name)
			VALUES (f_name_var, l_name_var);
            # fixme: hack solution to prevent short circuiting of loop iteration
            SET row_not_found = FALSE;
		#ELSE
			-- todo: handle people with same name and aliases
			-- leverage bendover tables unique bendover_id, url of social media table and/or email?
		END IF;
	END WHILE;
        CLOSE cur;
END//

DELIMITER ;

# troubleshooting statements...
CALL insert_bendover_names_into_core_profile();
SELECT get_profile_id_by_name('Michael', 'Brown') AS 'id', f_name, l_name
FROM core_profile
WHERE f_name = 'Michael' AND l_name = 'Brown';
DROP PROCEDURE IF EXISTS insert_bendover_names_into_core_profile;
SELECT id
	FROM core_profile
	WHERE f_name = 'Jane' AND l_name = 'Doe';
DELETE FROM core_profile WHERE f_name = 'Jane' AND l_name = 'Doe';
