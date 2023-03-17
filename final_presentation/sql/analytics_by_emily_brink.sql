# what were they registered as and when did they register
SELECT v.username, p.date, pl.party
FROM voter_profile AS v  
JOIN party_registration AS p
ON v.id=p.voter_profile_id
JOIN voter_ballot_finished as vbf
on vbf.voter_profile_id = v.id
JOIN candidate as c
ON c.id = vbf.candidate_id
JOIN party_lookup as pl
ON pl.id = p.party_lookup_id;

# what party did they vote for and when
SELECT v.username, pl.party, vbf.submission_time
FROM voter_profile AS v  
JOIN voter_ballot_finished as vbf
on vbf.voter_profile_id = v.id
JOIN candidate as c
ON c.id = vbf.candidate_id
JOIN party_lookup as pl
ON pl.id = c.party_lookup_id;

# viewing political affiliation and intensity over time
SELECT v.username, c.f_name, c.l_name, pa.intensity, pt.prev_intensity, pt.timestamp, pal.affiliation
FROM voter_profile AS v  
JOIN core_profile AS c
ON c.id=v.core_id  
JOIN core_profile_has_political_affiliation as pa
ON c.id = pa.core_profile_id
JOIN political_affiliation_lookup as pal
ON pal.id = pa.political_affiliation_id
JOIN political_transaction as pt
ON pt.core_profile_has_political_affiliation_id = pa.political_affiliation_id
WHERE pt.timestamp BETWEEN 
NOW() AND DATE_ADD(NOW(), INTERVAL 1 YEAR);

# viewing websites username has viewed, when they visited, how long they visited, what affiliation the sites had
SELECT v.username, wm.timestamp, wm.length_of_stay_seconds, w.name, pal.affiliation
FROM voter_profile AS v  
JOIN website as w
JOIN political_affiliation_lookup as pal
ON w.political_affiliation_id = pal.id
JOIN web_media AS wm
ON wm.website_id = w.id
ON wm.core_id=v.core_id  
WHERE wm.timestamp BETWEEN 
NOW() AND DATE_ADD(NOW(), INTERVAL 1 MONTH);

# how many suspicious friends have they added over year before election
SELECT SUM(f.suspicious) AS NumSuspiciousFriends FROM friend f
WHERE f.timestamp BETWEEN
NOW() AND DATE_ADD(NOW(), INTERVAL 1 YEAR);

# suspicious friends' affiliations 
SELECT f.suspicious, c.l_name, c.f_name, pal.affiliation
FROM core_profile AS c
JOIN core_profile_has_political_affiliation AS ca
ON c.id = ca.core_profile_id
JOIN political_affiliation_lookup as pal
ON ca.political_affiliation_id = pal.affiliation
JOIN friend as f
ON f.core_profile_id = c.id
WHERE f.timestamp BETWEEN
NOW() AND DATE_ADD(NOW(), INTERVAL 1 YEAR);

# viewing username with full name
SELECT v.username, c.f_name, c.l_name
FROM voter_profile AS v  
JOIN core_profile AS c
ON c.id=v.core_id;


