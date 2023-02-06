DELETE  
FROM `targeted_marketing`.`bendover_data_feed`
WHERE id > 0;
SHOW CREATE TABLE bendover_data_feed;

# ALTER TABLE bendover_data_feed
# CHANGE COLUMN age birthdate DATE;

INSERT INTO `targeted_marketing`.`bendover_data_feed` 
(
	bendover_id,
	first_name,
	last_name,
	email,
	political_affiliation,
	political_intensity,
	religious_affiliation,
	religious_intensity,
	social_issue_views,
	social_issue_post_date,
	social_issue_view_intensity,
	social_mate_preference,
	gender,
	birthdate,
	location,
	education,
	occupation,
	hobbies
) 
VALUES 
('936DA01F-9ABD-4D9D-80C7-02AF85C822A8', 'Jane', 'Doe', 'jane.doe@example.com', 'Liberal', 10, 'Atheist', 1, '{"climate_change": "Pro-action", "immigration": "Pro-immigration", "healthcare": "Pro-universal healthcare"}', '{"climate_change": "2022-04-12", "immigration": "2022-04-13", "healthcare": "2022-04-14"}', '{"climate_change": 10, "immigration": 10, "healthcare": 10}', '{"political_affiliation": "Liberal", "religious_affiliation": "Atheist", "gender": "I"}', 'TM', '1993-02-06', 'New York, NY', "Bachelor's degree in Computer Science", 'Software Engineer', '["Programming", "Reading", "Hiking"]'),
('7C4A8D09-E2F8-496E-AFCE-DA96A76E31A3', 'John', 'Smith', 'john.smith@example.com', 'Conservative', 1, 'Christian', 10, '{"climate_change": "Skeptical", "immigration": "Anti-immigration", "healthcare": "Pro-market healthcare"}', '{"climate_change": "2021-04-12", "immigration": "2021-04-13", "healthcare": "2021-04-14"}', '{"climate_change": 1, "immigration": 1, "healthcare": 1}', '{"political_affiliation": "Conservative", "religious_affiliation": "Christian", "gender": "F"}', 'TF', '2001-02-20', 'Los Angeles, CA', "Associate's degree in Business", 'Entrepreneur', '["Surfing", "Yoga", "Cooking"]'),
('A1B2C3D4-E5F6-G7H8-I9J0-K1L2M3N4O5', 'Emily', 'Johnson', 'emily.johnson@example.com', 'Independent', 5, 'Buddhist', 7, '{"climate_change": "Pro-action", "immigration": "Pro-immigration", "healthcare": "Pro-universal healthcare"}', '{"climate_change": "2022-04-15", "immigration": "2022-04-16", "healthcare": "2022-04-17"}', '{"climate_change": 9, "immigration": 8, "healthcare": 7}', '{"political_affiliation": "Independent", "religious_affiliation": "Buddhist", "gender": "M"}', 'F', '1994-02-06', 'Chicago, IL', "Master's degree in Education", 'Teacher', '["Painting", "Traveling", "Gardening"]'),
('P1Q2R3S4-T5U6-V7W8-X9Y0-Z1A2B3C4D5', 'Michael', 'Brown', 'michael.brown@example.com', 'Conservative', 9, 'Jewish', 8, "{'climate_change': 'Skeptical', 'immigration': 'Anti-immigration', 'healthcare': 'Pro-market healthcare'}", "{'climate_change': '2021-04-15', 'immigration': '2021-04-16', 'healthcare': '2021-04-17'}", '{"climate_change": 1, "immigration": 2, "healthcare": 3}', "{'political_affiliation': 'Conservative', 'religious_affiliation': 'Jewish', 'gender': 'F'}", 'TF', '1998-05-22', 'Houston, TX', "Doctorate degree in Physics", "Research Scientist", '["Astronomy", "Sudoku", "Beer Pong"]'),
('936DA01F-9ABD-4D9D-80C7-02AF85C822A8', 'Jane', 'Doe', 'jane.doe@example.com', 'Liberal', 6, 'Atheist', 4, "{'climate_change': 'Pro-action', 'immigration': 'Pro-immigration', 'healthcare': 'Pro-universal healthcare'}", "{'climate_change': '2023-01-12', 'immigration': '2023-01-13', 'healthcare': '2023-01-14'}", "{'climate_change': 1, 'immigration': 10, 'healthcare': 5}", "{'political_affiliation': 'Liberal', 'religious_affiliation': 'Atheist', 'gender': 'I'}", 'TM', '1998-10-31', 'New York, NY', "Bachelor's degree in Computer Science", "Software Engineer", "['Programming', 'Reading', 'Hiking']")