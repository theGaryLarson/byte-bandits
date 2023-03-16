SELECT e.name AS election_name, e.election_start_date, e.election_end_date, s.name AS state_name,
       bc.office, c.fname, c.lname, pl.party AS party_name
FROM votemate.election e
JOIN votemate.ballot_choice bc ON e.id = bc.election_id
JOIN votemate.states s ON bc.states_id = s.id
JOIN votemate.ballot_choice_has_candidate bchc ON bc.id = bchc.ballot_choice_id
JOIN votemate.candidate c ON bchc.candidate_id = c.id
JOIN votemate.party_lookup pl ON c.party_lookup_id = pl.id
ORDER BY e.election_start_date, s.name, bc.office, c.lname;

# could be edited to align with our data
INSERT INTO voter_ballot_started (start, voter_profile_id, ballot_choice_id, candidate_id)
VALUES
('2023-03-01 09:00:00', 1, 1, 1),
('2023-03-01 09:15:00', 2, 1, 2),
('2023-03-01 09:30:00', 3, 2, 3),
('2023-03-01 09:45:00', 4, 2, 4),
('2023-03-01 10:00:00', 5, 3, 1),
('2023-03-01 10:15:00', 6, 3, 2);

INSERT INTO voter_ballot_finished (submission_time, voter_profile_id, ballot_choice_id, candidate_id)
VALUES
('2023-03-01 09:10:00', 1, 1, 1),
('2023-03-01 09:20:00', 2, 1, 2),
('2023-03-01 09:10:00', 3, 3, 1),
('2023-03-01 09:20:00', 4, 3, 2);
