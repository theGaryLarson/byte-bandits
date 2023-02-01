DELIMITER $$

CREATE PROCEDURE get_services_with_opinion_types(IN profile_id INT)
BEGIN
    SELECT s.name AS service_name,
           c.first_name,
           c.last_name,
           ot.name AS opinion_type,
           smp.name AS social_media_platform
    FROM core_profile c
    JOIN service s ON c.id = s.core_profile_id
    JOIN sm_opinion_type_by_platform sotp ON s.id = sotp.sm_opinion_type_id
    JOIN sm_opinion_type ot ON sotp.sm_opinion_type_id = ot.id
    JOIN social_media_platform smp ON sotp.social_media_platform_id = smp.id
    WHERE c.id = profile_id;
END$$

DELIMITER ;
