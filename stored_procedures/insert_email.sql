USE targeted_marketing;
DELIMITER //
CREATE PROCEDURE insert_email
(
	profile_id		INT,
    email			VARCHAR(255)
)
BEGIN
IF NOT check_exists_email(email) THEN
	INSERT INTO email
	VALUE(profile_id, email);
END IF;
END