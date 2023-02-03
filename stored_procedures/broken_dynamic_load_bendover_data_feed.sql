USE targeted_marketing;
DELIMITER //
DELIMITER //
CREATE FUNCTION load_bendover_data_feed()
RETURNS BOOLEAN
BEGIN
  DECLARE cmd TEXT DEFAULT 'LOAD DATA INFILE "clean_bendover_data_feed.csv" INTO TABLE bendover_data_feed FIELDS TERMINATED BY "," ENCLOSED BY \'"\' LINES TERMINATED BY "\n" IGNORE 1 ROWS';
  DECLARE CONTINUE HANDLER FOR 1329
  SET @cmd = cmd;
  BEGIN
    SELECT 'File not found';
    RETURN FALSE;
  END;

  PREPARE stmt FROM @cmd;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
  RETURN TRUE;
END//
DELIMITER ;
CALL load_bendover_data_feed();