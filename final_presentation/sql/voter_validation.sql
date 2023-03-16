SELECT vp.id, vp.username, vp.password, vp.salt, t.secret
FROM voter_profile vp
JOIN 2fa t ON vp.id = t.voter_profile_id
WHERE vp.username = '[username]';