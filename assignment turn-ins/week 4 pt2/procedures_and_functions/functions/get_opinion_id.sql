USE targeted_marketing;
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

DROP PROCEDURE IF EXISTS get_opinion_id;
SELECT get_opinion_id(13, "TEST");
DELETE FROM opinion WHERE opinion = "TEST";