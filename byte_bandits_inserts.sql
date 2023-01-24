##########################################
#            PERSONAL INFO               #
##########################################

INSERT INTO core_profile (f_name, l_name)
VALUES ('John', 'Doe'),
       ('Jane', 'Smith'),
	   ('Bob', 'Johnson'),
	   ('Sara', 'Williams'),
	   ('Gary', 'Larson');

INSERT INTO address (core_id, street, apt, city, state, zip, country)
VALUES (11, '123 Main St', 'Apt 4', 'New York', 'NY', '10001', 'USA'),
       (12, '456 Elm St', 'Apt 5', 'Los Angeles', 'CA', '90210', 'USA'),
	   (13, '789 Oak St', 'Apt 6', 'Chicago', 'IL', '60201', 'USA'),
	   (14, '321 Pine St', NULL, 'Houston', 'TX', '77001', 'USA'),
	   (15, '315 Hemlock St', NULL, 'Sequim', 'WA', '98362', 'USA'),
       (15, '13746 Roosevelt Way N', NULL, 'Seattle', 'WA', '98133', 'USA');

INSERT INTO alias (core_id, f_name, l_name)
VALUES (11, 'John', 'Doe'),
       (12, 'Jane', 'Smith'),
	   (13, 'Bob', 'Johnson'),
	   (14, 'Sara', 'Williams'),
       (15, 'Michael', 'Larson'),
       (15, 'dotZero', NULL);

INSERT INTO profile_data (core_id, gender, ethnicity, birthdate, marital_status)
VALUES (11, 'M', 'Caucasian', '1987-05-23', 'Single'),
       (12, 'F', 'African American', '1993-09-12', 'Married'),
	   (13, 'M', 'Asian', '1978-03-15', 'Divorced'),
	   (14, 'F', 'Hispanic', '1989-07-20', 'Widowed');

INSERT INTO ip (core_id, ip_address, is_v4)
VALUES (11, '192.168.1.1', 1),
       (12, '192.168.1.2', 1),
	   (13, '192.168.1.3', 1), 
	   (14, '192.168.1.4', 1),
       (15, '192.168.1.5', 1);

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

INSERT INTO phone (core_id, phone_num)
VALUES (11, '555-555-5555'),
       (12, '555-555-5556'),
       (13, '555-555-5557'),
	   (14, '555-555-5558'),
       (15, '555-555-5559');
       
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

INSERT INTO sm_opinion_type (type) 
VALUES ('Education'),
	   ('Healthcare'),
       ('Immigration'),
       ('Foreign Policy'),
       ('Gun Control');

INSERT INTO opinion (smo_type_id, opinion) 
VALUES (11, 'I believe in increasing funding for public education'), 
       (12, 'I support universal healthcare access'),
       (13, 'I support a fair and humane immigration policy'),
       (14, 'I believe in a non-interventional foreign policy'),
       (15, 'I support common-sense gun control measures');
       
INSERT INTO profile_opinion (core_id, opinion_id) 
VALUES (11, 10), 
       (12, 11),
       (13, 12),
       (14, 13),
       (15, 14);

##########################################
#            SOCIAL MEDIA                #
##########################################

INSERT INTO social_media_platform (platform)
VALUES ('Facebook'),
       ('Twitter'),
       ('Instagram'),
       ('LinkedIn'),
       ('YouTube');
       
INSERT INTO sm_transaction (core_id, smp_id, price_paid) 
VALUES (11, 11, 100.00), 
       (11, 12, 150.00),
       (12, 13, 200.00),
       (13, 14, 250.00),
       (14, 15, 300.00);

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

INSERT INTO sm_item_by_seller (sm_transaction_id, sm_seller_id, sm_item_id) 
VALUES (1, 1, 1), 
       (2, 2, 2), 
       (3, 3, 3), 
       (4, 4, 4), 
       (5, 5, 5);

INSERT INTO social_media (core_id, sm_platform_id, url, last_active)
VALUES (11, 11, 'https://www.facebook.com/johndoe', '2022-01-01'),
	   (12, 12, 'https://www.twitter.com/janesmith', '2023-01-02'),
       (13, 13, 'https://www.instagram.com/bobjohnson', '2023-01-03'),
       (14, 14, 'https://www.linkedin.com/sarawilliams', '2021-01-04'),
       (15, 15, 'https://www.youtube.com/garylarson', '2023-01-23');

INSERT INTO post (social_media_id, content)
VALUES (11, 'Excited to announce the launch of our new product!'),
       (12, 'Just had the best meeting with our team #teamwork'),
       (13, 'Check out my latest travel adventure on my Instagram story'),
       (14, 'Networking and connecting with like-minded professionals on LinkedIn'),
       (15, 'Watch my latest video on YouTube for tips on personal development');
       
 INSERT INTO `like` (social_media_id, content, url) 
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
       
INSERT INTO `group` (id, name, description, url, social_media_id) 
VALUES (1, 'Marketing Professionals', 'A group for marketing professionals to connect and share ideas.', 'https://www.facebook.com/groups/marketingprofessionals/', 11),
	   (2, 'Entrepreneurs', 'A group for entrepreneurs to connect and share resources.', 'https://www.facebook.com/groups/entrepreneurs/', 11),
       (3, 'Tech enthusiasts', 'A group for tech enthusiasts to discuss the latest advancements.', 'https://www.facebook.com/groups/techenthusiasts/', 11),
       (4, 'Social Media Strategists', 'A group for social media strategists to discuss best practices and share tips.', 'https://www.facebook.com/groups/socialmediastrategists/', 11),
       (5, 'Startup Founders', 'A group for startup founders to connect and share resources.', 'https://www.facebook.com/groups/startupfounders/', 11);

INSERT INTO sm_opinion_type_by_platform (sm_opinion_type_id, social_media_platform_id)
VALUES (11, 11),
	   (11, 12),
       (11, 13),
       (11, 14),
       (11, 15),
       (12, 11),
	   (12, 12),
       (12, 13),
       (12, 14),
       (12, 15),
       (13, 11),
	   (13, 12),
       (13, 13),
       (13, 14),
       (13, 15),
       (14, 11),
	   (14, 12),
       (14, 13),
       (14, 14),
       (14, 15),
       (15, 11),
	   (15, 12),
       (15, 13),
       (15, 14),
       (15, 15);