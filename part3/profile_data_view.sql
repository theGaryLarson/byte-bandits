USE targeted_marketing_pt_3;
CREATE VIEW profile_data_view AS
SELECT core_profile.id AS 'Core id',
							f_name,
                            l_name,
                            profile_data.id AS 'Profile Data id',
                            gender_look_up.acronym AS Gender,
                            ROUND(DATEDIFF(CURDATE(), birthdate) / 365.25) AS Age,
                            most_recent_education AS 'Latest Education',
                            current_occupation AS 'Current Occupation'
FROM core_profile
JOIN profile_data
ON core_profile.id = profile_data.core_id
JOIN gender_look_up ON gender_look_up.id = profile_data.gender_id
ORDER BY 'Core id';

SELECT * FROM profile_data_view;