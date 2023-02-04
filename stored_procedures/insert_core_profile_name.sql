USE targeted_marketing;
DELIMITER //
CREATE PROCEDURE insert_bendover_names_into_core_profile()
BEGIN
-- todo: pull the data from bendover_data_feed table rather than parameters
DECLARE f_name_var VARCHAR(45);
DECLARE l_name_var VARCHAR(45);

SELECT first_name, last_name
INTO f_name_var, l_name_var
FROM bendover_data_feed;

IF get_profile_id_by_name(f_name_var, l_name_var) IS NULL THEN
	INSERT INTO core_profile(f_name, l_name)
    VALUES (f_name_var, l_name_var);
#ELSE
	-- todo: handle people with same name and aliases
    -- leverage bendover tables unique bendover_id, url of social media table and/or email?
END IF;
END//

DELIMITER ;
CALL insert_core_profile_names();
SELECT get_profile_id_by_name('Robel', 'Hailu') AS 'id', f_name, l_name
FROM core_profile
WHERE f_name = 'Robel' AND l_name = 'Hailu';
