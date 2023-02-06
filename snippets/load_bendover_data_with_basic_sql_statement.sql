USE targeted_marketing;
LOAD DATA INFILE 'C:\Users\garyl\repos\AD350_DB\byte_bandits\csv\clean_bendover_data_feed.csv'
INTO TABLE `targeted_marketing`.`bendover_data_feed`
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;