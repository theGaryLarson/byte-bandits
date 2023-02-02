DROP PROCEDURE IF EXISTS InsertOpinion;

DELIMITER //

CREATE PROCEDURE 'InsertOpinion'()
BEGIN
    DECLARE not_found = FALSE;
DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET not_found = TRUE;
INSERT INTO opinion (opinion, intensity) VALUES ('from csv', 'from csv');
INSERT INTO sm_opinion_type (type) VALUES ('from csv');
IF not_found = TRUE THEN
    SELECT 'Values not inserted - no values found.' AS message;
ELSE
    SELECT 'Values inserted.' AS message;
END IF;
END//
DELIMITER ;
CALL InsertOpinion();