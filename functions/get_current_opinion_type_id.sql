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

DROP FUNCTION get_current_opinion_type_id;