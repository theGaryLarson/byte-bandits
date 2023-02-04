USE targeted_marketing;
DELIMITER //
CREATE PROCEDURE insert_core_profile_name
(
	f_name_var VARCHAR(45),
	l_name_var VARCHAR(45)
)
BEGIN
IF get_profile_id_by_name(f_name_var, l_name_var) IS NULL THEN
	INSERT INTO core_profile(f_name, l_name)
    VALUES (f_name_var, l_name_var);
	#ELSE
		-- todo: handle people with same name and aliases
		-- leverage bendover tables unique bendover_id, url of social media table and/or email?
END IF;
END//

DELIMITER ;
CALL insert_core_profile_name('Robel', 'Hailu');
SELECT get_profile_id_by_name('Robel', 'Hailu') AS 'id', f_name, l_name
FROM core_profile
WHERE f_name = 'Robel' AND l_name = 'Hailu';
