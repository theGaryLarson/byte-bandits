DROP PROCEDURE IF EXISTS InsertOpinion;

DELIMITER //

CREATE PROCEDURE 'InsertOpinion'()
BEGIN
    DECLARE not_found = FALSE;
DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET not_found = TRUE;
DECLARE opinion VARCHAR;
DECLARE intensity INT;
DECLARE opinion_type VARCHAR;
INSERT INTO opinion (opinion, intensity) VALUES (opinion, intensity);
IF NOT EXISTS (SELECT * FROM sm_opinion_type WHERE type = opinion_type ) THEN
    INSERT INTO sm_opinion_type (type) VALUES (opinion_type);
IF not_found = TRUE THEN
    SELECT 'Values not inserted - no values found.' AS message;
ELSE
    SELECT 'Values inserted.' AS message;
END IF;
END//
DELIMITER ;
CALL InsertOpinion();