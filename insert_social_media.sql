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

# left off on social media 6 to go!! #
