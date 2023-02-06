USE targeted_marketing;
DELIMITER //
CREATE PROCEDURE insert_profile_opinion
(
    core_profile_id_arg         INT,
    opinion_id_arg              INT,
    date_arg                    DATE,
    intensity_arg               INT
)
# fixme: look at IN OUT keywords that way can return flag if exists already to handle transaction
BEGIN
    IF NOT check_exists_profile_opinion(core_profile_id_arg, opinion_id_arg) THEN
        INSERT INTO profile_opinion (core_id, opinion_id, date, intensity)
            VALUES (core_profile_id_arg, opinion_id_arg, date_arg, intensity_arg);
        # return true if is inserted
    # ELSE
        # return false letting us know it exists and need to transfer to opinion transaction table
    END IF;
END//
DELIMITER ;

CALL insert_profile_opinion(15, 15, CURDATE(), 5);
SELECT * FROM profile_opinion;
DELETE FROM profile_opinion WHERE `date` = CURDATE();