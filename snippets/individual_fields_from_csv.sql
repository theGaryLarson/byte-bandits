
# This will load the data from the file /path/to/bendover_data_feed.csv and insert
# only the first name and last name into the table targeted_marketing. The fields
# in the csv file are separated by commas, and values are enclosed by double quotes.
# The first row of the csv file will be ignored (the header), and the values from each
# subsequent row will be inserted into the table.

DELIMITER //
CREATE PROCEDURE load_bendover_data()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET @file_not_found = 1;

  LOAD DATA INFILE 'py/bendover_data_feed.csv'
  INTO TABLE targeted_marketing
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS
  (first_name, last_name);

  IF @file_not_found THEN
    SELECT 'File not found';
  END IF;
END//

DELIMITER ;
