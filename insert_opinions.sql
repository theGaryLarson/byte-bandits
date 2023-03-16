USE targeted_marketing_pt_3;
INSERT INTO political_affiliation_look_up (affiliation)
VALUES ('Education'),
        ('Healthcare'),
        ('Immigration'),
        ('Foreign Policy'),
        ('Gun Control'),
        ('Religion'),
        ('Politics'),
        ('Climate-Change');

SELECT * FROM political_affiliation_look_up;


# inserts prior to refactor

# INSERT INTO sm_opinion_type (type)
# VALUES ('Education'),
# 	   ('Healthcare'),
#        ('Immigration'),
#        ('Foreign Policy'),
#        ('Gun Control');
#
# INSERT INTO opinion (smo_type_id, opinion)
# VALUES (11, 'I believe in increasing funding for public education'),
#        (12, 'I support universal healthcare access'),
#        (13, 'I support a fair and humane immigration policy'),
#        (14, 'I believe in a non-interventional foreign policy'),
#        (15, 'I support common-sense gun control measures');
#
# INSERT INTO profile_opinion (core_id, opinion_id)
# VALUES (11, 10),
#        (12, 11),
#        (13, 12),
#        (14, 13),
#        (15, 14);

