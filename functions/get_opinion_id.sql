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
WHERE opinion.opinion = opinon_var;

IF found_opinion_id IS NULL THEN
	INSERT INTO opinion
    VALUES(smo_type_id_var, opinion_var);
    
    SELECT opinion.id INTO found_opinion_id
	FROM opinion
	WHERE opinion.opinion = opinion_var;
    RETURN found_opinion_id;
ELSE
	RETURN found_opinion_id;
END IF;
END//
DELIMITER ;