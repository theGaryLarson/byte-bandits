DELIMITER //

CREATE PROCEDURE insert_social_mate_preference
(
	core_id_var 			INT
)
BEGIN
DECLARE mate_preference		VARCHAR(200);
DECLARE political_affil		VARCHAR(45);
DECLARE religious_affil		VARCHAR(45);
DECLARE gender_pref			VARCHAR(4);
SELECT social_mate_preference
INTO mate_preference
FROM bendover_data_feed;

SET political_affil =  JSON_EXTRACT(mate_preference, $political_affiliation);
SET religious_affil = JSON_EXTRACT(mate_preference, $religious_affiliation);
SET gender_pref = JSON_EXTRACT(mate_preference, $gender);

-- SELECT bendover_id, f_name, l_name
-- FROM bendover_data_feed,
-- WHERE 
END//