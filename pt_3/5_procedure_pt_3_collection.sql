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
	# fixme: hack solution to my main driver procedure quitting early
	SET @done = FALSE;
	#ELSE
		-- todo: handle people with same name and aliases
		-- leverage bendover tables unique bendover_id, url of social media table and/or email?
END IF;
END//
DELIMITER ;

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
	# fixme: hack solution to my main driver procedure quitting early
	SET @done = FALSE;
END IF;
END//

DELIMITER ;

DELIMITER //
CREATE PROCEDURE insert_email
(
	profile_id_var		INT,
    email_var			VARCHAR(255)
)
BEGIN
IF NOT check_exists_email(email_var) THEN
	INSERT INTO email (core_id, email)
	VALUES(profile_id_var, email_var);
END IF;
END//
DELIMITER ;

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
	# fixme: hack solution to my main driver procedure quitting early
	SET @done = FALSE;
END IF;
END//

DELIMITER ;

DELIMITER //

 # todo: adjust to match new schema
CREATE PROCEDURE insert_profile_opinion
(
    core_profile_id_arg         INT,
    opinion_id_arg              INT,
    date_arg                    DATE,
    intensity_arg               INT
)
# fixme: look at IN OUT keywords that way can return flag if exists already to handle transaction
BEGIN
    IF NOT check_exists_profile_opinion(core_profile_id_arg, opinion_id_arg) THEN
        INSERT INTO profile_opinion (core_id, opinion_id, date, intensity)
            VALUES (core_profile_id_arg, opinion_id_arg, date_arg, intensity_arg);
        # return true if is inserted
    # ELSE
        # return false letting us know it exists and need to transfer to opinion transaction table
    END IF;
END//
DELIMITER ;

DELIMITER //

# inserts platform into social_media_platform table if not already present
CREATE PROCEDURE `insert_platform`
(
	platform VARCHAR(255)
)
BEGIN
IF NOT check_platform_exists(platform) THEN
	INSERT INTO `social_media_platform` (platform)
    VALUES (platform);
END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE insert_profile_data
(
    core_id_var         INT,
    gender_var          VARCHAR(3),
    birthdate_var       DATE,
    education_var       VARCHAR(144),
    occupation_var      VARCHAR(144)
)
BEGIN
    DECLARE curr_id     INT;

    SELECT targeted_marketing.profile_data.core_id
    INTO curr_id
    FROM profile_data
    WHERE core_id = core_id_var;

    IF curr_id IS NULL THEN
        INSERT INTO profile_data(core_id, gender, birthdate, education, occupation)
        VALUES(core_id_var, gender_var, birthdate_var, education_var, occupation_var);
        # fixme: hack to prevent the main driver loop from short circuiting
        SET @done = FALSE;
    END IF;

END //
DELIMITER ;

