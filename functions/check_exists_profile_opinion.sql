USE targeted_marketing;
DELIMITER //
CREATE FUNCTION check_exists_profile_opinion
(
    core_profile_id_arg         INT,
    opinion_id_arg              INT
)
RETURNS BOOLEAN
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE profile_opinion_id    INT;

    SELECT id
    INTO profile_opinion_id
    FROM profile_opinion
    WHERE core_profile_id_arg = core_id AND opinion_id_arg = opinion_id;
    IF profile_opinion_id IS  NULL THEN
        # fixme: hack solution to my main driver procedure quitting early
	    SET @done = FALSE;
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END//
DELIMITER ;
SELECT check_exists_profile_opinion(15, 15);
 DROP PROCEDURE IF EXISTS  check_exists_profile_opinion;