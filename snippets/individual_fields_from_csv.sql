DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET @file_not_found = 1;

LOAD DATA INFILE '/path/to/bendover_data_feed.csv'
INTO TABLE targeted_marketing
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(first_name, last_name);

IF @file_not_found THEN
  SELECT 'File not found';
END IF;
