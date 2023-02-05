USE targeted_marketing;
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

CALL insert_email(15 ,'gary.larson@seattlecolleges.edu');