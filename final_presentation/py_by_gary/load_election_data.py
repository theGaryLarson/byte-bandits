import mysql.connector
import json


def insert_party_lookup_data(json_file_path, config):
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            parties = data["political_affiliation_lookup"]
            for row in parties:
                cursor.execute("""
                INSERT INTO party_lookup (party)
                VALUES (%s)
                """, (row["party"],))
            cnx.commit()


def insert_election_data(json_file_path, config):
    with open(json_file_path, 'r') as f:
        data = json.load(f)
    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor(dictionary=True) as cursor:
            # Insert election data
            elections = data["elections"]
            for election in elections:
                cursor.execute("""
                    INSERT INTO election (name, election_start_date, election_end_date)
                    VALUES (%s, %s, %s)
                """, (election["name"], election["start_time"], election["end_time"]))
                election_id = cursor.lastrowid

                # Insert states and their ballot choices
                for state in election["states"]:
                    cursor.execute("""
                        INSERT INTO states (name)
                        VALUES (%s)
                    """, (state["name"],))
                    state_id = cursor.lastrowid

                    for ballot_choice in state["ballot_choices"]:
                        cursor.execute("""
                            INSERT INTO ballot_choice (office, states_id, election_id)
                            VALUES (%s, %s, %s)
                        """, (ballot_choice["office"], state_id, election_id))
                        ballot_choice_id = cursor.lastrowid

                        # Insert candidates and create relationships with ballot choices
                        for candidate in ballot_choice["candidates"]:
                            cursor.execute("""
                                INSERT INTO candidate (fname, lname, party_lookup_id)
                                VALUES (%s, %s, (SELECT id FROM party_lookup WHERE party = %s))
                            """, (candidate["first_name"], candidate["last_name"], candidate["party"]))
                            candidate_id = cursor.lastrowid

                            cursor.execute("""
                                INSERT INTO ballot_choice_has_candidate (ballot_choice_id, candidate_id)
                                VALUES (%s, %s)
                            """, (ballot_choice_id, candidate_id))

                cnx.commit()


if __name__ == '__main__':
    from vm_config import config as vm_config

    insert_party_lookup_data("../json/political_affiliation_lookup.json", vm_config)
    insert_election_data("../json/election_ballot.json", vm_config)
