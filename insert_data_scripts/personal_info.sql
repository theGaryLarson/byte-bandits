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