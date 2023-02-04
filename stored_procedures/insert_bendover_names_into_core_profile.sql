USE targeted_marketing;
DELIMITER //
CREATE PROCEDURE insert_bendover_names_into_core_profile()
BEGIN
	DECLARE f_name_var VARCHAR(45);
	DECLARE l_name_var VARCHAR(45);
	DECLARE cur CURSOR
    FOR SELECT first_name, last_name
    FROM bendover_data_feed;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @done = TRUE;
    OPEN cur;
    insertion_loop: LOOP
		FETCH cur INTO f_name_var, l_Name_var;
        # question - Would it be more optimal to use another cursor than this function which returns every name on an individual query?
		IF get_profile_id_by_name(f_name_var, l_name_var) IS NULL THEN
			INSERT INTO core_profile(f_name, l_name)
			VALUES (f_name_var, l_name_var);
		#ELSE
			-- todo: handle people with same name and aliases
			-- leverage bendover tables unique bendover_id, url of social media table and/or email?
		END IF;
        IF @done THEN
			LEAVE insertion_loop;
        END IF;
	END LOOP;
        CLOSE cur;
END//

DELIMITER ;
CALL insert_bendover_names_into_core_profile();
SELECT get_profile_id_by_name('Michael', 'Brown') AS 'id', f_name, l_name
FROM core_profile
WHERE f_name = 'Michael' AND l_name = 'Brown';
