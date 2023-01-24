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