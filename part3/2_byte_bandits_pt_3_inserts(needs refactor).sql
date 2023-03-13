USE targeted_marketing_pt_3;
##########################################
#            PERSONAL INFO               #
##########################################

INSERT INTO core_profile (f_name, l_name)
VALUES ('John', 'Doe'),
       ('Jane', 'Smith'),
	   ('Bob', 'Johnson'),
	   ('Sara', 'Williams'),
	   ('Gary', 'Larson');
SELECT * FROM core_profile;

INSERT INTO address (core_id, street, apt, city, state, zip, country)
VALUES (11, '123 Main St', 'Apt 4', 'New York', 'NY', '10001', 'USA'),
       (12, '456 Elm St', 'Apt 5', 'Los Angeles', 'CA', '90210', 'USA'),
	   (13, '789 Oak St', 'Apt 6', 'Chicago', 'IL', '60201', 'USA'),
	   (14, '321 Pine St', NULL, 'Houston', 'TX', '77001', 'USA'),
	   (15, '315 Hemlock St', NULL, 'Sequim', 'WA', '98362', 'USA'),
       (15, '13746 Roosevelt Way N', NULL, 'Seattle', 'WA', '98133', 'USA');
       SELECT * FROM address;

INSERT INTO alias (core_id, f_name, l_name)
VALUES (15, 'dotZero', NULL);
SELECT * FROM alias;

# todo insert gender_look_up values
INSERT INTO gender_look_up (identity, acronym)
VALUES
    ('Female', 'F'),
    ('Male', 'M'),
    ('Intersex', 'I'),
    ('Transfemale', 'TF'),
    ('Transmale', 'TM'),
    ('Bigender', 'B');
SELECT * FROM gender_look_up;

# todo: Robel we need to add these. Education and Occupation tables are for past schooling and jobs
INSERT INTO profile_data (core_id, gender_id, ethnicity, birthdate, marital_status, most_recent_education, current_occupation)
VALUES (11, 12, 'Caucasian', '1987-05-23', 'Single', 'Bachelor\'s degree in Computer Science', 'Software Engineer'),
       (12, 11, 'African American', '1993-09-12', 'Married', 'Associate\'s degree in Business', 'Entrepreneur'),
	   (13, 12, 'Asian', '1978-03-15', 'Divorced', 'Master\'s degree in Education', 'Teacher'),
	   (14, 11, '', '1989-07-20', 'Widowed', 'Doctorate degree in Physics', 'Research Scientist'),
       (15, 12, 'Caucasian', '1981-10-04', 'Single', 'Bachelor\'s degree in Computer Science', 'Software Engineer');

# todo: create as view
SELECT f_name, l_name, gender_id, gender_look_up.acronym FROM core_profile
JOIN profile_data
ON core_profile.id = profile_data.core_id
JOIN gender_look_up
ON gender_id = gender_look_up.id;

INSERT INTO ip (core_id, ip_address, is_v4)
VALUES (11, '10.10.0.22', 1),
       (12, '10.0.0.22', 1),
	   (13, '11.1.1.3', 1), 
	   (14, '10.0.1.2', 1),
       (15, '10.5.2.11', 1);

INSERT INTO ip_location (ip_id, city, state, zip, country)
VALUES (1, 'New York', 'NY', '', 'USA'),
       (2, 'Los Angeles', 'CA', '',  'USA'),
	   (3, 'Chicago', 'IL', '',  'USA'),
	   (4, 'Houston', 'TX', '',  'USA'),
       (5, 'Bangkok', 'Watthana', '10110', 'Thailand');

INSERT INTO email (core_id, email)
VALUES (11, 'johndoe@gmail.com'),
       (12, 'janesmith@gmail.com'),
	   (13, 'bobjohnson@gmail.com'),
	   (14, 'sarawilliams@gmail.com'),
       (15, 'gary.larson@email.com');

INSERT INTO phone (core_id, country_code, area_code, extension, line_number)
VALUES (11, '1', '123', '555', '5555'),
       (12, '1','123','555', '5556'),
       (13, '1','456','555', '5557'),
	   (14, '1','456','555', '5558'),
       (15, '1','789','555', '5559');
SELECT * FROM phone;


# fixme: should hobby_name be array entries or should I just pick one hobby for each entry
# todo: Robel, it is an array of hobbies. But people can have more than one hobby. We receive a list of hobbies from a data feed for each profile
INSERT INTO hobby_look_up (hobby_name)
VALUES ('Astronomy'),
    ('Beer Pong'),
    ('Cooking'),
    ('Gardening'),
    ('Hiking'),
    ('Painting'),
    ('Programming'),
    ('Reading'),
    ('Sudoku'),
    ('Surfing'),
    ('Traveling'),
    ('Yoga');

# fixme: I would not have a time spent on hobby. I would have the definition of hobby for our use be something like more than 10 hrs/week
#  then if the topic meets that requirement insert it into this table to get an id to use as a FK in profile_hobby table
# INSERT INTO time_spent_on_hobby_look_up (time_spent)
# VALUES('Daily'),
#       ('Weekly'),
#       ('Weekdays'),
#       ('Weekends');

# todo: Robel these aren't a list of occupations. Occupation may be a good look up but this was used for transactional data (archiving)
# INSERT INTO past_occupation (core_id, job_title)
# VALUES (11, 'Software Engineer'),
#        (12, 'Entrepreneur'),
#        (13, 'Teacher'),
#        (14, 'Research Scientist'),
#        (15, 'Software Engineer');

# todo: can't seem to find fk id's in schema for --> gender_id, political_affiliation_look_up_id, religious_affiliation_look_up_id
# fixme: need fk id's for --> gender_id, political_affiliation_look_up_id, religious_affiliation_look_up_id
# todo: Robel these were not part of the first 5 rows of data because they were not part of the assignment.

#  INSERT INTO social_mate_preference (core_id, gender_id, political_affiliation_look_up_id, religious_affiliation_look_up_id)
#  VALUES (11, 12, 'Liberal', 'Atheist'),
#  	     (12, 11, 'Conservative', 'Christian'),
#         (13, 12, 'Independent', 'Buddhist'),
#         (14, 11, 'Conservative', 'Jewish'),
#         (15, 12, 'Liberal', 'Christian');


# todo: can't seem to find fk id's in schema for --> hobby_id # fixme: need to add the hobbies to the hobby_look_up table then use a SELECT * FROM hobby_look_up to view the ids to enter
    # what is the hobby_id start at if there's no auto_increment value given? does it start at 1? A: Sometimes but I've noticed it is not consistent.
# fixme: need fk id's for --> hobby_id there isn't any hobbies listed. That wasn't developed until a later assignment.
#  the manual inserts did not have any hobbies in the csv file.
INSERT INTO profile_hobby (core_id, hobby_id, weekly_time_spent)
VALUES
    (11, 11, 10),
    (11, 14, 8),
    (12, 12, 9),
    (12, 15, 15),
    (13, 20, 5),
    (13, 21, 5),
    (14, 13, 15),
    (14, 14, 5),
    (15, 17, 25),
    (15, 13, 5);


       
##########################################
#              PRODUCTS                  #
##########################################

INSERT INTO product_type (type)
VALUES ('Electronics'),
       ('Fashion'),
       ('Home & Garden'),
       ('Sports & Outdoors'),
       ('Books');

INSERT INTO product (product_name, product_type_id)
VALUES ('iPhone 14', 11),
       ('Adidas Ultraboost', 13),
       ('Samsung Galaxy S22', 11),
       ('Nike Air Max', 13),
       ('Kindle Paperwhite', 15);

INSERT INTO seller (seller)
VALUES ('Amazon'),
       ('Best Buy'),
       ('Walmart'),
       ('Target'),
       ('Ebay');

INSERT INTO product_by_seller (product_id, seller_id)
VALUES (31, 1),
	   (32, 2),
       (33, 3),
       (34, 4),
       (35, 5);

INSERT INTO profile_product (core_id, product_by_seller_id, rating, last_purchased, price_paid)
VALUES (11, 1, 5, '2022-01-01', '999.99'),
       (12, 2, 4, '2022-02-01', '149.99'),
       (13, 3, 3, '2022-03-01', '799.99'),
       (14, 4, 5, '2022-04-01', '199.99'),
       (15, 5, 4, '2022-05-01', '119.99');

##########################################
#              SERVICES                  #
##########################################

INSERT INTO service_type (category)
VALUES ('gym memberships'),
	   ('streaming services'),
       ('costco card'),
       ('grocery delivery'),
       ('ride sharing');
       
INSERT INTO service (category_id, service)
VALUES ('5', 'Planet Fitness'),
       ('5', '24 Hour Fitness'),
       ('6', 'Amazon Prime'),
       ('6', 'Netflix'),
       ('7', 'Costco Membership'),
       ('8', 'Instacart'),
       ('8', 'Amazon Fresh'),
       ('9', 'Uber'),
       (9, 'Lyft');
       
INSERT INTO profile_service(core_id, service_id)
VALUES ('11', '11'),
	   ('12', '12'),
       ('13', '13'),
       ('14', '14'),
       ('15', '15'),
       ('15', '14');

##########################################
#              OPINIONS                  #
##########################################
DELETE FROM social_issue_view_type_look_up WHERE id > 0;
INSERT INTO social_issue_view_type_look_up (`type`)
VALUES ('Education'),
        ('Healthcare'),
        ('Immigration'),
        ('Foreign Policy'),
        ('Gun Control'),
        ('Climate-Change');

SELECT * FROM social_issue_view_type_look_up;

INSERT INTO political_affiliation_look_up (affiliation)
VALUES    ('Liberal'),
          ('Conservative'),
          ('Independent'),
          ('Conservative');

USE targeted_marketing_pt_3;
INSERT INTO core_profile_has_political_affiliation (core_profile_id, political_affiliation_look_up_id, intensity)
VALUES ( 11, 17, 10),
       ( 12, 18, 1),
       ( 13, 19, 5),
       ( 14, 20, 9);
-- todo: insert opinions according to new schema
-- INSERT INTO sm_opinion_type (type) 
-- VALUES ('Education'),
-- 	   ('Healthcare'),
--        ('Immigration'), # Brink
--        ('Foreign Policy'),
--        ('Gun Control'), # Brink
--        ('Religion'), # Robel
-- 	   ('Politics'), # Nick
-- 	   ('Climate-Change'); # Brink

-- INSERT INTO opinion (smo_type_id, opinion) 
-- VALUES (11, 'I believe in increasing funding for public education'),
--        (12, 'I support universal healthcare access'),
--        (13, 'I support a fair and humane immigration policy'),
--        (14, 'I believe in a non-interventional foreign policy'),
--        (15, 'I support common-sense gun control measures');
--        
-- INSERT INTO profile_opinion (core_id, opinion_id, intensity, `date`)
-- VALUES (11, 11, 1, '2023-01-20'),
--        (12, 12, 10, '2020-03-17'),
--        (13, 13, 5, '2022-08-18'),
--        (14, 14, 7, '2022-07-23'),
--        (15, 15, 4, '2022-04-21');


# todo: Robel, you had entered Atheist 2x. This is a look up table meant to hold unique values
INSERT INTO religious_affiliation_look_up (affiliation)
VALUES ('Atheist'),
       ('Christian'),
       ('Buddhist'),
       ('Jewish');
#        ('Atheist');

# todo: checked the schema to find starting value for religious_affiliation_look_up_id auto-increment, but there wasn't one??
# todo: Robel can't remember but I'm sure I didn't have religious affiliations associated with the first 5 rows of data.
# religious affiliations wasn't required until a later assignment
INSERT INTO core_profile_has_religious_affiliation (religious_affiliation_look_up_id, core_profile_id)
VALUES (2, 15);

# todo: checked the schema to find starting value for core_profile_religious_affiliation auto-increment, but there wasn't one??
# todo: would auto-increment value start at 1 then??
# fixme: timestamp dates are examples, couldn't find actual dates in clean_bendover_data_feed.csv
# todo: robel, these do not exist. This is a table to store the old data as new data comes in.
# INSERT INTO religious_transaction (core_profile_has_religious_affiliation_id, `timestamp`, prev_intensity)
# VALUES (, '2022-10-04', 1),
#        (, '2022-12-31', 10),
#        (, '2023-02-04', 7),
#        (, '2023-02-14', 8),
#        (, '2023-03-02', 4);


##########################################
#            SOCIAL MEDIA                #
##########################################

INSERT INTO social_media_platform (platform)
VALUES ('Facebook'),
       ('Twitter'),
       ('Instagram'),
       ('LinkedIn'),
       ('YouTube');

# fixme need to sort out normalization vs efficiency on this
# INSERT INTO sm_transaction (core_id, smp_id,sm_item_by_seller_id, price_paid, purchase_date)
# VALUES (11, 11, 100.00),
#        (11, 12, 150.00),
#        (12, 13, 200.00),
#        (13, 14, 250.00),
#        (14, 15, 300.00);

INSERT INTO sm_item_type (type)
VALUES ('Retail'),
       ('Services'),
       ('Subscription'),
       ('Influencer Marketing'),
       ('Direct-to-Consumer');
       
INSERT INTO sm_item (type_id, item) 
VALUES (1, 'Fashion items'),
       (2, 'Food delivery'),
       (3, 'Online courses'),
       (4, 'Makeup products'),
       (5, 'Furniture');

INSERT INTO sm_seller (seller)
VALUES ('Fashion Retail Co.'),
('Foodie Delights'),
('E-Learning Inc.'),
('Beauty Box'),
('Furniture Emporium');

INSERT INTO sm_item_by_seller (sm_seller_id, sm_item_id, price)
VALUES (1, 1, 10.00),
       (2, 2, 22.99),
       (3, 3, 33.99),
       (4, 4, 44.99),
       (5, 5, 55.99);

INSERT INTO social_media (core_id, sm_platform_id, user_guid, url, last_active)
VALUES (11, 11,'54966999-feb6-4de4-ae32-3bcad7ed7067', 'https://www.facebook.com/johndoe', '2022-01-01'),
	   (12, 12,'6622b1c8-2adf-4ada-9f7a-6915e4a67e92', 'https://www.twitter.com/janesmith', '2023-01-02'),
       (13, 13, '6e781adb-d622-4a60-a723-8b79fbb45cf0', 'https://www.instagram.com/bobjohnson', '2023-01-03'),
       (14, 14, '2c9eb5b1-8dc6-435e-a717-4c2b75af0113', 'https://www.linkedin.com/sarawilliams', '2021-01-04'),
       (15, 15, '63d0ba09-1d99-4d47-8a58-d10b8412acc2', 'https://www.youtube.com/garylarson', '2023-01-23');

INSERT INTO post (social_media_id, content)
VALUES (11, 'Excited to announce the launch of our new product!'),
       (12, 'Just had the best meeting with our team #teamwork'),
       (13, 'Check out my latest travel adventure on my Instagram story'),
       (14, 'Networking and connecting with like-minded professionals on LinkedIn'),
       (15, 'Watch my latest video on YouTube for tips on personal development');
       
 INSERT INTO `like` (social_media_id, content, liked_url) 
 VALUES (11, 'The benefits of yoga', 'https://www.example.com/yoga-article'),
		(12, 'Make a homemade face mask is great', 'https://www.example.com/diy-face-mask'),
		(13, 'Sustainable living in Urban Areas', 'https://www.example.com/sustainable-living'),
		(14, 'Vegan lasagna recipe', 'https://www.example.com/vegan-lasagna'),
		(15, 'Dua Lipa: Levitating', 'https://www.youtube.com/dualipa-one-kiss');
      
INSERT INTO friend (social_media_id, core_profile_id)
VALUES (11, 12),
       (12, 13),
       (13, 14),
       (14, 15),
       (15, 11);
       
INSERT INTO `group` (id, name, description, group_url, social_media_id) 
VALUES (1, 'Marketing Professionals', 'A group for marketing professionals to connect and share ideas.', 'https://www.facebook.com/groups/marketingprofessionals/', 11),
	   (2, 'Entrepreneurs', 'A group for entrepreneurs to connect and share resources.', 'https://www.facebook.com/groups/entrepreneurs/', 11),
       (3, 'Tech enthusiasts', 'A group for tech enthusiasts to discuss the latest advancements.', 'https://www.facebook.com/groups/techenthusiasts/', 11),
       (4, 'Social Media Strategists', 'A group for social media strategists to discuss best practices and share tips.', 'https://www.facebook.com/groups/socialmediastrategists/', 11),
       (5, 'Startup Founders', 'A group for startup founders to connect and share resources.', 'https://www.facebook.com/groups/startupfounders/', 11);

-- todo: change to fit new schema
-- INSERT INTO sm_opinion_type_by_platform (sm_opinion_type_id, social_media_platform_id)
-- VALUES (11, 11),
-- 	   (11, 12),
--        (11, 13),
--        (11, 14),
--        (11, 15),
--        (12, 11),
-- 	   (12, 12),
--        (12, 13),
--        (12, 14),
--        (12, 15),
--        (13, 11),
-- 	   (13, 12),
--        (13, 13),
--        (13, 14),
--        (13, 15),
--        (14, 11),
-- 	   (14, 12),
--        (14, 13),
--        (14, 14),
--        (14, 15),
--        (15, 11),
-- 	   (15, 12),
--        (15, 13),
--        (15, 14),
--        (15, 15);