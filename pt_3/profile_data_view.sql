USE targeted_marketing_pt_3;
CREATE VIEW profile_data_view AS
SELECT core_profile.id AS 'Core id',
							f_name,
                            l_name,
                            profile_data.id AS 'Profile Data id',
                            gender,
                            ROUND(DATEDIFF(CURDATE(), birthdate) / 365.25) AS 'Age',
                            education AS 'Latest Education',
                            occupation AS 'Current Occupation'
FROM core_profile
JOIN profile_data
ON core_profile.id = profile_data.core_id
ORDER BY 'Core id';

SELECT * FROM profile_data_view;