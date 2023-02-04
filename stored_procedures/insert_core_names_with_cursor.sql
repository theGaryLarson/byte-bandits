USE targeted_marketing;
DELIMITER //
CREATE PROCEDURE insert_bendover_names_into_core_profile()
BEGIN
	-- todo: pull the data from bendover_data_feed table rather than parameters
	DECLARE f_name_var VARCHAR(45);
	DECLARE l_name_var VARCHAR(45);
	DECLARE cur CURSOR
    FOR SELECT first_name, last_name
    FROM bendover_data_feed;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @done = 1;
    OPEN cur;
    label: LOOP
		FETCH cur INTO f_name_var, l_Name_var;
		IF get_profile_id_by_name(f_name_var, l_name_var) IS NULL THEN
			INSERT INTO core_profile(f_name, l_name)
			VALUES (f_name_var, l_name_var);
			#ELSE
				-- todo: handle people with same name and aliases
				-- leverage bendover tables unique bendover_id, url of social media table and/or email?
		END IF;
        IF @done = 1 THEN LEAVE label;
        END IF;
	END LOOP;
        CLOSE cur;
END//

DELIMITER ;
CALL insert_bendover_names_into_core_profile();
SELECT get_profile_id_by_name('Michael', 'Brown') AS 'id', f_name, l_name
FROM core_profile
WHERE f_name = 'Michael' AND l_name = 'Brown';
