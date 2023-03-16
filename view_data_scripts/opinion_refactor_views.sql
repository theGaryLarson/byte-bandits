USE targeted_marketing;

# Brink
CREATE VIEW opinion_refactor_social_issues AS
SELECT core_profile.id, f_name, l_name, `type` AS 'type in type_lookup', opinion AS 'view', intensity
FROM sm_opinion_type
JOIN opinion ON opinion.smo_type_id = sm_opinion_type.id AND `type` != 'Politics' AND `type` != 'Religion'
JOIN profile_opinion ON profile_opinion.opinion_id = opinion.id
JOIN core_profile	 ON profile_opinion.core_id = core_profile.id
ORDER BY opinion_id;

DROP VIEW opinion_refactor_social_issues;

SELECT * FROM opinion_refactor_social_issues;

# Nick
CREATE VIEW opinion_refactor_political_affiliation AS
SELECT core_profile.id, f_name, l_name, `type` AS 'implied by table: not needed for entry', opinion AS 'affiliation', intensity
FROM sm_opinion_type
JOIN opinion ON opinion.smo_type_id = sm_opinion_type.id AND `type` = 'Politics'
JOIN profile_opinion ON profile_opinion.opinion_id = opinion.id
JOIN core_profile	 ON profile_opinion.core_id = core_profile.id
ORDER BY core_profile.id;

SELECT * FROM opinion_refactor_political_affiliation;

# Robel
CREATE VIEW opinion_refactor_religious_affiliation AS
SELECT core_profile.id, f_name, l_name, `type` AS 'implied by table: not needed for entry', opinion AS 'affiliation', intensity
FROM sm_opinion_type
JOIN opinion ON opinion.smo_type_id = sm_opinion_type.id AND `type` = 'Religion'
JOIN profile_opinion ON profile_opinion.opinion_id = opinion.id
JOIN core_profile	 ON profile_opinion.core_id = core_profile.id
ORDER BY core_profile.id;

SELECT * FROM opinion_refactor_religious_affiliation;

