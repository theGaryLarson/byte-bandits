USE targeted_marketing;
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
	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END//
DELIMITER ;
SELECT check_exists_email('gary.larson@seattlecolleges.edu');