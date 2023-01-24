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
