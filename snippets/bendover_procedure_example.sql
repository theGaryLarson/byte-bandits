
# In this example, /path/to/bendover_data_feed.csv is the file path to the CSV file,
# and targeted_marketing is the name of the table that the data will be loaded into.
# The FIELDS TERMINATED BY and ENCLOSED BY clauses specify the delimiter and enclosure
# characters used in the CSV file. The LINES TERMINATED BY clause specifies the end-of-line
# character used in the file. The IGNORE 1 ROWS clause tells MySQL to ignore the first row in
# the file, which is typically the header row.

USE targeted_marketing;
DELIMITER //
CREATE PROCEDURE parse_csv()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET @file_not_found = 1;
  LOAD DATA INFILE 'py/bendover_data_feed.csv'
  INTO TABLE targeted_marketing
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS
  (id, first_name, last_name, email, political_affiliation, political_intensity,
   religious_affiliation, religious_intensity, social_issue_views, view_intensity,
   social_mate_preference, gender
  );

  IF @file_not_found THEN
      SELECT 'File not found';
  END IF;
END//
DELIMITER ;
