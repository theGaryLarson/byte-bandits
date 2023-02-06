USE `byte-bandits-sandbox`;
DELIMITER //
CREATE FUNCTION check_exists_email
(
	email_var			VARCHAR(255)
)
RETURNS BOOLEAN
READS SQL DATA
DETERMINISTIC
BEGIN
DECLARE found_email		VARCHAR(255);

SELECT email.email INTO found_email
FROM email
WHERE email.email = email_var;

IF found_email IS NULL THEN
    # fixme: hack solution to my main driver procedure quitting early
    SET @done = FALSE;
	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION check_exists_profile_opinion
(
    core_profile_id_arg         INT,
    opinion_id_arg              INT
)
RETURNS BOOLEAN
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE profile_opinion_id    INT;

    SELECT id
    INTO profile_opinion_id
    FROM profile_opinion
    WHERE core_profile_id_arg = core_id AND opinion_id_arg = opinion_id;
    IF profile_opinion_id IS  NULL THEN
        # fixme: hack solution to my main driver procedure quitting early
	    SET @done = FALSE;
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END//
DELIMITER ;

DELIMITER //
# Checks if social media platform exists
CREATE FUNCTION check_platform_exists
(
	platform VARCHAR(255)
)
RETURNS BOOLEAN
DETERMINISTIC READS SQL DATA
BEGIN
DECLARE found_platform VARCHAR(255);

SELECT `byte-bandits-sandbox`.social_media_platform.platform
INTO found_platform
FROM social_media_platform
WHERE `social_media_platform`.platform = platform;

IF found_platform IS NULL THEN
    # fixme: hack solution to my main driver procedure quitting early
	SET @done = FALSE;

	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION get_current_opinion_type_id
(
	opinion_type_var VARCHAR(45)
)
RETURNS BOOLEAN
READS SQL DATA
DETERMINISTIC

BEGIN
DECLARE found_id		INT;
DECLARE found_type		VARCHAR(45);

SELECT id , `type`
INTO found_id, found_type
FROM sm_opinion_type
WHERE sm_opinion_type.`type` = opinion_type_var;

IF found_type IS NULL THEN
	INSERT INTO sm_opinion_type
    VALUES (opinion_type_var);

    SELECT id
    INTO found_id
    FROM sm_opinion_type
    WHERE sm_opinion_type.`type` = opinion_type_var;
	# fixme: hack solution to my main driver procedure quitting early
	SET @done = FALSE;
    RETURN found_id;
ELSE
	RETURN found_id;
END IF;
END//

DELIMITER ;

DELIMITER //
CREATE FUNCTION get_opinion_id
(
	smo_type_id_var		INT,
	opinion_var 		VARCHAR(255)
)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
DECLARE found_opinion_id 	INT;
DECLARE found_opinion 		VARCHAR(255);

SELECT opinion.id, opinion.opinion
INTO found_opinion_id, found_opinion
FROM opinion
WHERE opinion.opinion = opinion_var;

IF found_opinion_id IS NULL THEN
	INSERT INTO opinion (smo_type_id, opinion)
    VALUES(smo_type_id_var, opinion_var);

    SELECT opinion.id
    INTO found_opinion_id
	FROM opinion
	WHERE opinion.opinion = opinion_var;

	# fixme: hack solution to my main driver procedure quitting early
	SET @done = FALSE;

    RETURN found_opinion_id;
ELSE
	RETURN found_opinion_id;
END IF;
END//
DELIMITER ;

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
  FROM `byte-bandits-sandbox`.core_profile
  WHERE f_name = first_name AND l_name = last_name;
  IF result IS NULL THEN
      # fixme: hack solution to my main driver procedure quitting early
      SET @done = FALSE;
  END IF;
  RETURN result;
END//
DELIMITER ;

DELIMITER //
# returns social media platform primary key (id)
CREATE FUNCTION get_sm_platform_id
(
	platform VARCHAR(255)
)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
DECLARE result_id INT;

SELECT id INTO result_id
FROM social_media_platform
WHERE social_media_platform.platform = platform;

IF result_id IS NULL THEN
    SET @done = FALSE;
END IF;

RETURN result_id;
END//
DELIMITER ;
