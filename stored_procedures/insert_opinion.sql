DROP PROCEDURE IF EXISTS InsertOpinion;

DELIMITER //

CREATE PROCEDURE 'InsertOpinion'()
BEGIN
    DECLARE not_found = FALSE;
DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET not_found = TRUE;
DECLARE opinion VARCHAR;
DECLARE intensity INT;
INSERT INTO opinion (opinion, intensity) VALUES (opinion, intensity);
INSERT INTO sm_opinion_type (type) VALUES ('from csv');
IF not_found = TRUE THEN
    SELECT 'Values not inserted - no values found.' AS message;
ELSE
    SELECT 'Values inserted.' AS message;
END IF;
END//
DELIMITER ;
CALL InsertOpinion();