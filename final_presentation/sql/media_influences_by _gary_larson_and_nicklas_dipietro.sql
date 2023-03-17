################################################
# physical external influences (subscriptions) #
################################################

# magazine political lean
SELECT
       CONCAT(f_name, ' ', l_name) AS Name,
       magazine.name AS Magazine,
       political_affiliation_lookup.affiliation AS "Political Lean"
FROM core_profile
JOIN printed_media_subscription ON core_profile.id = printed_media_subscription.core_id
JOIN magazine ON printed_media_subscription.newspaper_id = magazine.id
JOIN political_affiliation_lookup ON magazine.political_affiliation_id = political_affiliation_lookup.id;

# count of magazine subscriptions to determine influence
SELECT
  political_affiliation_lookup.affiliation AS "Political Party",
  COUNT(core_profile.id) AS "Magazine Subscriptions"
FROM  core_profile
JOIN  printed_media_subscription ON core_profile.id = printed_media_subscription.core_id
JOIN  magazine ON printed_media_subscription.newspaper_id = magazine.id
RIGHT JOIN  political_affiliation_lookup ON magazine.political_affiliation_id = political_affiliation_lookup.id
GROUP BY  political_affiliation_lookup.affiliation
ORDER BY  count(core_profile.id) DESC;

# newspaper political lean
SELECT CONCAT(f_name, ' ', l_name) AS Name,
       newspaper.name AS Newspapers,
       political_affiliation_lookup.affiliation AS "Political Lean"
FROM core_profile
JOIN printed_media_subscription ON core_profile.id = printed_media_subscription.core_id
JOIN newspaper ON printed_media_subscription.newspaper_id = newspaper.id
RIGHT JOIN political_affiliation_lookup ON newspaper.political_affiliation_id = political_affiliation_lookup.id
ORDER BY affiliation;

# count of newspaper subscriptions to determine influence
SELECT
  political_affiliation_lookup.affiliation AS "Political Party",
  COUNT(core_profile.id) AS "Newspaper Subscriptions"
FROM  core_profile
JOIN  printed_media_subscription ON core_profile.id = printed_media_subscription.core_id
JOIN  newspaper ON printed_media_subscription.newspaper_id = newspaper.id
RIGHT JOIN  political_affiliation_lookup ON newspaper.political_affiliation_id = political_affiliation_lookup.id
GROUP BY  political_affiliation_lookup.affiliation
ORDER BY  count(core_profile.id) DESC;

###################################################
# digital external influences (internet activity) #
###################################################

# amount of time spent on web broadcasts
SELECT CONCAT(f_name, ' ', l_name) AS Name,
       web_broadcast.name AS "Web Broadcast",
       web_media.length_of_stay_seconds/60 AS minutes_active,
       political_affiliation_lookup.affiliation AS media_political_interests
FROM core_profile
JOIN web_media ON core_profile.id = web_media.core_id
JOIN web_broadcast ON web_media.web_broadcast_id = web_broadcast.id
JOIN political_affiliation_lookup ON web_broadcast.political_affiliation_id = political_affiliation_lookup.id
ORDER BY length_of_stay_seconds DESC, affiliation;

# aggregate of number of web broadcast viewers and time spent
SELECT
  web_broadcast.name AS "Web Broadcast",
  political_affiliation_lookup.affiliation AS media_political_interests,
  COUNT(core_profile.id) AS "Total Number of Viewers",
  SUM(web_media.length_of_stay_seconds / 60) AS "Total Minutes Watched"
FROM  core_profile
JOIN  web_media ON core_profile.id = web_media.core_id
JOIN  web_broadcast ON web_media.web_broadcast_id = web_broadcast.id
JOIN  political_affiliation_lookup ON web_broadcast.political_affiliation_id = political_affiliation_lookup.id
GROUP BY  web_broadcast.name, political_affiliation_lookup.affiliation
ORDER BY  count(core_profile.id) DESC;

# amount of time spent on websites
SELECT CONCAT(f_name, ' ', l_name) AS Name,
       website.name AS Website,
       web_media.length_of_stay_seconds/60 AS minutes_active,
       political_affiliation_lookup.affiliation AS political_interests
FROM core_profile
JOIN web_media ON core_profile.id = web_media.core_id
JOIN website ON web_media.website_id = website.id
JOIN political_affiliation_lookup ON website.political_affiliation_id = political_affiliation_lookup.id
ORDER BY length_of_stay_seconds DESC, affiliation;

# aggregate of number of website viewers and time spent
SELECT
  website.name AS Website,
  political_affiliation_lookup.affiliation AS political_interests,
  COUNT(core_profile.id) AS "Total Number of Viewers",
  SUM(web_media.length_of_stay_seconds / 60) AS "Total Minutes Active"
FROM  core_profile
JOIN  web_media ON core_profile.id = web_media.core_id
JOIN  website ON web_media.website_id = website.id
JOIN  political_affiliation_lookup ON website.political_affiliation_id = political_affiliation_lookup.id
GROUP BY  website.name, political_affiliation_lookup.affiliation
ORDER BY  "Total Number of Viewers" DESC, political_affiliation_lookup.affiliation;

# amount of time spent on podcasts
SELECT CONCAT(f_name, ' ', l_name) AS Name,
       podcast.name AS Website,
       web_media.length_of_stay_seconds/60 AS minutes_listened,
       political_affiliation_lookup.affiliation AS political_interests
FROM core_profile
JOIN web_media ON core_profile.id = web_media.core_id
JOIN podcast ON web_media.website_id = podcast.id
JOIN political_affiliation_lookup ON podcast.political_affiliation_id = political_affiliation_lookup.id
ORDER BY length_of_stay_seconds DESC, affiliation;

# aggregate number of  podcast listeners and time spent
SELECT
  podcast.name AS Podcast,
  political_affiliation_lookup.affiliation AS political_interests,
  COUNT(core_profile.id) AS "Total Number of Listeners",
  SUM(web_media.length_of_stay_seconds / 60) AS "Total Minutes Listened"
FROM  core_profile
JOIN  web_media ON core_profile.id = web_media.core_id
JOIN  podcast ON web_media.podcast_id = podcast.id
JOIN  political_affiliation_lookup ON podcast.political_affiliation_id = political_affiliation_lookup.id
GROUP BY  podcast.name, political_affiliation_lookup.affiliation
ORDER BY  "Total Number of Listeners" DESC, political_affiliation_lookup.affiliation;


##########################
# SOCIAL MEDIA INFLUENCE #
##########################

# user social media groups
SELECT
       CONCAT(f_name, ' ', l_name) AS Name,
       smp.platform AS platform,
       group_lookup.name AS `group`,
       political_lean
FROM core_profile
JOIN social_media ON  core_profile.id = social_media.core_id
JOIN social_media_platform smp ON social_media.sm_platform_id = smp.id
JOIN `group` ON social_media.group_id = `group`.id
JOIN group_lookup ON `group`.group_lookup_id = group_lookup.id
ORDER BY political_lean;

# count of members
SELECT
  group_lookup.name AS `group`,
  political_affiliation_lookup.affiliation AS "Political Lean",
  COUNT(core_profile.id) AS "Number of Members"
FROM  core_profile
JOIN  social_media ON core_profile.id = social_media.core_id
JOIN social_media_platform ON social_media.sm_platform_id = social_media_platform.id
JOIN `group` ON social_media.group_id = `group`.id
JOIN group_lookup ON `group`.group_lookup_id = group_lookup.id
JOIN core_profile_has_political_affiliation cphpa ON core_profile.id = cphpa.core_profile_id
JOIN political_affiliation_lookup ON cphpa.political_affiliation_id = political_affiliation_lookup.id
GROUP BY group_lookup.name, political_affiliation_lookup.affiliation
ORDER BY COUNT(core_profile.id) DESC;


# user social views
SELECT CONCAT(f_name, ' ', l_name) AS Name, category, view, opinion, intensity, post_date
FROM core_profile
JOIN core_profile_has_social_issue_view ON core_profile.id = core_profile_has_social_issue_view.core_profile_id
JOIN social_issue_view_lookup ON core_profile_has_social_issue_view.social_issue_view_look_up_id = social_issue_view_lookup.id
JOIN social_issue_view_type_lookup sivtl ON social_issue_view_lookup.view_type_id = sivtl.id
ORDER BY post_date;
