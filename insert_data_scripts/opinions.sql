INSERT INTO sm_opinion_type (`type`) 
VALUES ('Education'),
	   ('Healthcare'),
       ('Immigration'),
       ('Foreign Policy'),
       ('Gun Control');

SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO opinion (smo_type_id, opinion) 
VALUES (11, 'I believe in increasing funding for public education'), 
       (12, 'I support universal healthcare access'),
       (13, 'I support a fair and humane immigration policy'),
       (14, 'I believe in a non-interventional foreign policy'),
       (15, 'I support common-sense gun control measures');
SET FOREIGN_KEY_CHECKS = 1;

SELECT * FROM sm_opinion_type;
SELECT opinion.id, opinion.opinion, sm_opinion_type.type
FROM opinion
JOIN sm_opinion_type
ON opinion.smo_type_id = sm_opinion_type.id;


