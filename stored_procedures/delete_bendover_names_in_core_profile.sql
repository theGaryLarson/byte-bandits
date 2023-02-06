USE targeted_marketing;
DELIMITER //
CREATE PROCEDURE delete_bendover_names_in_core_profile()
BEGIN
	DECLARE bendover_f_name VARCHAR(45);
    DECLARE bendover_l_name VARCHAR(45);
	DECLARE cur CURSOR
    FOR SELECT first_name, last_name
    FROM bendover_data_feed;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @done = TRUE;
    
    OPEN cur;
    delete_loop: LOOP
		FETCH cur INTO bendover_f_name, bendover_l_name;
		DELETE
		FROM core_profile
		WHERE core_profile.f_name = bendover_f_name AND core_profile.l_name = bendover_l_name;
        IF @done THEN LEAVE delete_loop;
        END IF;
	END LOOP;
	CLOSE cur;
END//
DELIMITER ;
CALL delete_bendover_names_in_core_profile();