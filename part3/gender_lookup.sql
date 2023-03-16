USE targeted_marketing_pt_3;

##########
CREATE VIEW gender_look_up_view AS
SELECT core_profile.id	AS 'Core id',
				f_name, l_name AS 'Profile_data_id',
				gender_id, gender_look_up.acronym AS 'Gender'
FROM core_profile
JOIN profile_data
ON core_profile.id = profile_data.core_id
JOIN gender_look_up
ON gender_id = gender_look_up.id
ORDER BY 'Core id';

SELECT * FROM gender_look_up_view;

CREATE VIEW social_mate_preference_political_affiliation_view AS
SELECT core_profile.id	AS 'Core id',
				f_name, l_name AS 'Profile_data_id',
        political_affiliation_look_up.id, political_affiliation_look_up.affiliation AS 'Political affiliation',
        core_profile_has_political_affiliation.intensity AS 'Political affiliation intensity'
FROM core_profile
JOIN social_mate_preference
ON core_profile.id = social_mate_preference.core_id
JOIN political_affiliation_look_up
ON social_mate_preference.political_affiliation_look_up_id = political_affiliation_look_up.id
JOIN core_profile_has_political_affiliation
ON political_affiliation_look_up.id = core_profile_has_political_affiliation.political_affiliation_look_up_id;

SELECT * FROM social_mate_preference_political_affiliation_view;

# throws an error saying duplicate column name id, but I'm not creating a column named id?
# CREATE VIEW social_mate_preference_religious_affiliation_view AS
# SELECT core_profile.id	AS 'Core id',
# 				f_name, l_name AS 'Profile_data_id',
#         religious_affiliation_look_up.id, religious_affiliation_look_up.affiliation AS 'Religious affiliation',
#         religious_transaction.id, religious_transaction.prev_intensity, religious_transaction.`timestamp` AS 'Religious transaction'
# FROM core_profile
# JOIN social_mate_preference
# ON core_profile.id = social_mate_preference.core_profile_id
# JOIN religious_affiliation_look_up
# ON social_mate_preference.religious_affiliation_look_up_id = religious_affiliation_look_up.id
# JOIN core_profile_has_religious_affiliation
# ON religious_affiliation_look_up.id = core_profile_has_religious_affiliation.religious_affiliation_look_up_id
# JOIN religious_transaction
# ON core_profile_has_religious_affiliation.religious_affiliation_look_up_id = religious_transaction.id;
#
# SELECT * FROM social_mate_preference_religious_affiliation_view;

##########
