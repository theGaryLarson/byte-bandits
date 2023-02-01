USE targeted_marketing;
DELIMITER //
CREATE PROCEDURE parse_csv()
BEGIN
  LOAD DATA INFILE 'bendover_data_feed.csv'
  INTO TABLE targeted_marketing
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS
  (id, first_name, last_name, email, political_affiliation, political_intensity,
   religious_affiliation, religious_intensity, social_issue_views, view_intensity,
   social_mate_preference, gender
  );
END//
DELIMITER ;
