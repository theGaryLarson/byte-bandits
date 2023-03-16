USE targeted_marketing;
CREATE VIEW profile_opinion_view AS
SELECT profile_opinion.id AS 'Core id', f_name, l_name, sm_opinion_type.type AS 'Category', opinion_id, opinion.opinion, intensity, `date` AS 'Post-date'
FROM targeted_marketing.profile_opinion
JOIN core_profile
ON core_profile.id = profile_opinion.core_id
JOIN opinion
ON opinion.id = opinion_id
JOIN sm_opinion_type
ON opinion.smo_type_id = sm_opinion_type.id
ORDER BY category, intensity DESC, l_name, f_name;

SELECT * FROM profile_opinion_view;