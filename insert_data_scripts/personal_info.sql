INSERT INTO core_profile (f_name, l_name)
VALUES ('John', 'Doe'), ('Jane', 'Smith'), ('Bob', 'Johnson'), ('Sara', 'Williams'), (NULL, NULL);

INSERT INTO phone (core_id, phone_num)
VALUES (1, '555-555-5555'), (2, '555-555-5556'), (3, '555-555-5557'), (4, '555-555-5558'), (5, '555-555-5559');

INSERT INTO address (core_id, street, apt, city, state, zip, country)
VALUES (1, '123 Main St', 'Apt 1', 'New York', 'NY', '11111', 'USA'), (2, '456 Park Ave', '', 'Los Angeles', 'CA', '22222', 'USA'), (3, '789 Elm St', '', 'Chicago', 'IL', '33333', 'USA'), (4, '1011 Oak St', '', 'Houston', 'TX', '44444', 'USA'), (5, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO alias (core_id, alias)
VALUES (1, 'JDoe'), (2, 'JSmith'), (3, 'BJohnson'), (4, 'SWilliams'), (5, 'MBrown');

INSERT INTO profile_data (core_id, age, gender, income)
VALUES (1, 30, 'male', '$50,000'), (2, 25, 'female', '$40,000'), (3, 35, 'male', '$60,000'), (4, 28, 'female', '$55,000'), (5, 40, 'male', '$70,000');

INSERT INTO ip (core_id, ip_address, is_v4)
VALUES (1, '192.168.1.1', 1), (2, '192.168.1.2', 1), (3, '192.168.1.3', 1), (4, '192.168.1.4', 1), (5, '192.168.1.5', 1);

INSERT INTO ip_location (ip_id, city, state, country)
VALUES (1, 'New York', 'NY', 'USA'), (2, 'Los Angeles', 'CA', 'USA'), (3, 'Chicago', 'IL', 'USA'), (4, 'Houston', 'TX', 'USA'), (5, 'Seattle', 'WA', 'USA');

INSERT INTO email (core_id, email)
VALUES (1, 'johndoe@example.com'), (2, 'janesmith@example.com'), (3, 'bobjohnson@example.com'), (4, 'sarawilliams@example.com'), (5, 'mikebrown@example.com');