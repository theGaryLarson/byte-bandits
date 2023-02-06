DELIMITER //
CREATE PROCEDURE json_convert() 

BEGIN
DECLARE json_string	VARCHAR(255);
# need to iterate over because more than one. (USE CURSOR)
SELECT concat('[', social_issue_views, ']') INTO json_string FROM bendover_data_feed LIMIT 1;

SELECT JSON_EXTRACT(json_string, '$[0].immigration') AS 'climate change';
END//
DELIMITER ;
CALL json_convert();
DROP PROCEDURE json_convert;