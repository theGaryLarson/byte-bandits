USE targeted_marketing;
-- test this after inserting data into core_profile
DELIMITER //
# inserts the education of core_profile int profile_data table
-- todo: education could be split into its own table. Because many have multiple degrees
CREATE PROCEDURE insert_education
(
	profile_id_var	 	INT,
    education_var		VARCHAR(144)
)
READS SQL DATA
DETERMINISTIC

BEGIN
DECLARE found_edu		VARCHAR(144);

SELECT education INTO found_edu
FROM profile_data
WHERE profile_data.education = education_var;

-- todo: some logic could be done here in an else statement to store previous education as a transaction in a transaction table.
-- if we do not end up splitting education into it's own table.
IF found_edu IS NULL THEN
	INSERT INTO profile_data(core_id, education)
    VALUES (profile_id_var, education_var);
END IF;
END//

DELIMITER ;