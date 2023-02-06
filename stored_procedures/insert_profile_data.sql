USE targeted_marketing;
DELIMITER //
CREATE PROCEDURE insert_profile_data
(
    core_id_var         INT,
    gender_var          VARCHAR(3),
    birthdate_var       DATE,
    education_var       VARCHAR(144),
    occupation_var      VARCHAR(144)
)
BEGIN
    DECLARE curr_id     INT;

    SELECT targeted_marketing.profile_data.core_id
    INTO curr_id
    FROM profile_data
    WHERE core_id = core_id_var;

    IF curr_id IS NULL THEN
        INSERT INTO profile_data(core_id, gender, birthdate, education, occupation)
        VALUES(core_id_var, gender_var, birthdate_var, education_var, occupation_var);
        # fixme: hack to prevent the main driver loop from short circuiting
        SET @done = FALSE;
    END IF;

END //
DELIMITER ;