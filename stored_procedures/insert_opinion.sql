
-- FOR CSV....how to use this with unkempt data??
-- LOAD DATA INFILE 'c:/tmp/discounts.csv' 
-- INTO TABLE discounts 
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- ALSO need to make sure this is being linked by a key to core_profile...hmmm

DROP PROCEDURE IF EXISTS InsertOpinion;

DELIMITER //

CREATE PROCEDURE 'InsertOpinion'()
BEGIN
    DECLARE not_found = FALSE;
DECLARE CONTINUE HANDLER FOR NOT 1329
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