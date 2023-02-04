# some thoughts on profile_data table. It may be better to create a procedure that takes all table fields as arguments
# then we could use IF statements to check IF NULL. That would save us some queries to the database.
USE targeted_marketing;
-- test this after inserting data into core_profile
DELIMITER //
# inserts the occupation of core_profile int profile_data table
-- todo: occupation could be split into its own table. Because many have multiple jobs (at once and over time).
CREATE PROCEDURE insert_occupation
(
	profile_id_var	 	INT,
    job_var				VARCHAR(144)
)
READS SQL DATA
DETERMINISTIC

BEGIN
DECLARE found_job		VARCHAR(144);

SELECT occupation INTO found_job
FROM profile_data
WHERE profile_data.occupation = job_var;

-- todo: some logic could be done here in an else statement to store previous occupation as a transaction in a transaction table.
-- if we do not end up splitting occupation into it's own table.
IF found_job IS NULL THEN
	INSERT INTO profile_data(core_id, occupation)
    VALUES (profile_id_var, job_var);
END IF;
END//

DELIMITER ;