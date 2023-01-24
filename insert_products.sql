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