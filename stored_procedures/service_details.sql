DELIMITER $$

CREATE PROCEDURE `GetServiceDetails` (IN serviceID INT)
BEGIN
  SELECT s.id, s.name, s.description, s.price, tm.name AS 'target_market',
         smp.name AS 'platform', smot.name AS 'opinion_type', g.name AS 'group_name'
  FROM service s
  INNER JOIN targeted_market tm ON s.targeted_market_id = tm.id
  INNER JOIN sm_opinion_type smot ON s.sm_opinion_type_id = smot.id
  INNER JOIN sm_opinion_type_by_platform spot ON smot.id = spot.sm_opinion_type_id
  INNER JOIN social_media_platform smp ON spot.social_media_platform_id = smp.id
  INNER JOIN social_media sm ON smp.id = sm.id
  INNER JOIN `group` g ON sm.id = g.social_media_id
  WHERE s.id = serviceID;
END $$

DELIMITER ;
