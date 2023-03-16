INSERT INTO district_lookup (district) VALUES
('District 1'),
('District 2'),
('District 3'),
('District 4'),
('District 5'),
('District 6');


INSERT INTO voter_profile (core_id, district_lookup_id, username, password, salt, email, device_id, login_date) VALUES
(11, 1, 'jane_doe', 'a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5', 'abc123def456ghi789', 'jane_doe@example.com', 'f0e1d2c3b4a59687', '2023-01-01 00:00:00'),
(12, 2, 'john_smith', 'b2c3d4e5f6g7h8i9j0k1l2m3n4o5a1', 'def456ghi789abc123', 'john_smith@example.com', '1a2b3c4d5e6f7g8h9i0j', '2023-01-01 00:00:00'),
(13, 3, 'emily_johnson', 'c3d4e5f6g7h8i9j0k1l2m3n4o5a1b2', 'ghi789abc123def456', 'emily_johnson@example.com', '9j0k1l2m3n4o5p6q7r8', '2023-01-01 00:00:00'),
(14, 4, 'michael_brown', 'd4e5f6g7h8i9j0k1l2m3n4o5a1b2c3', 'abc123ghi789def456', 'michael_brown@example.com', '8s7t6u5v4w3x2y1z0a1', '2023-01-01 00:00:00'),
(15, 5, 'andy_mcdaniels', 'e5f6g7h8i9j0k1l2m3n4o5a1b2c3d4', 'def456abc123ghi789', 'andy_mcdaniels@example.com', '7a6b5c4d3e2f1g0h9i8', '2023-01-01 00:00:00'),
(16, 6, 'bernie_schneider', 'f6g7h8i9j0k1l2m3n4o5a1b2c3d4e5', 'ghi789def456abc123', 'bernie_schneider@example.com', '6z5y4x3w2v1u0t9s8r7', '2023-01-01 00:00:00');

INSERT INTO voter_log (voter_profile_id, last_login, last_device_id) VALUES
(1, '2023-01-01 00:00:00', 'f0e1d2c3b4a59687'),
(2, '2023-01-01 00:00:00', '1a2b3c4d5e6f7g8h9i0j'),
(3, '2023-01-01 00:00:00', '9j0k1l2m3n4o5p6q7r8'),
(4, '2023-01-01 00:00:00', '8s7t6u5v4w3x2y1z0a1'),
(5, '2023-01-01 00:00:00', '7a6b5c4d3e2f1g0h9i8'),
(6, '2023-01-01 00:00:00', '6z5y4x3w2v1u0t9s8r7');

INSERT INTO `2fa` (voter_profile_id, secret, recover_code_1, recover_code_2, recover_code_3)
VALUES
(1, 'a1b2c3d4e5f6g7h8i9j0', 'R1C1a2', 'R2C1b3', 'R3C1c4'),
(2, 'k9l8m7n6o5p4q3r2s1', 'R1C2a2', 'R2C2b3', 'R3C2c4'),
(3, 't1u2v3w4x5y6z7a8b9', 'R1C3a2', 'R2C3b3', 'R3C3c4'),
(4, 'c9d8e7f6g5h4i3j2k1', 'R1C4a2', 'R2C4b3', 'R3C4c4'),
(5, 'l1m2n3o4p5q6r7s8t9', 'R1C5a2', 'R2C5b3', 'R3C5c4'),
(6, 'u9v8w7x6y5z4a3b2c1', 'R1C6a2', 'R2C6b3', 'R3C6c4');

INSERT INTO primary_address (voter_profile_id, street, street_2, city, state, zip, date)
VALUES
(1, '123 Main St', NULL, 'Los Angeles', 'CA', 90001, '2022-01-01 00:00:00'),
(2, '456 Oak St', 'Apt 3B', 'Chicago', 'IL', 60601, '2022-02-05 00:00:00'),
(3, '789 Pine St', NULL, 'New York', 'NY', 10001, '2022-03-10 00:00:00'),
(4, '246 Elm St', NULL, 'Houston', 'TX', 77001, '2022-04-15 00:00:00'),
(5, '135 Maple St', 'Apt 4C', 'Miami', 'FL', 33101, '2022-05-20 00:00:00'),
(6, '864 Walnut St', NULL, 'Seattle', 'WA', 98101, '2022-06-25 00:00:00');

# could be edited to align with our data
INSERT INTO party_registration (voter_profile_id, party_lookup_id, date)
VALUES
(1, 1, '2022-01-15 00:00:00'),
(2, 2, '2022-02-10 00:00:00'),
(3, 4, '2022-03-05 00:00:00'),
(4, 2, '2022-04-01 00:00:00'),
(5, 1, '2022-05-27 00:00:00'),
(6, 1, '2022-06-22 00:00:00');




