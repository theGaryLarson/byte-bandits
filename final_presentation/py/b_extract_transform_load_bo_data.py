import mysql.connector
from mysql.connector import Error
from vm_config import config

"""
        extract and transforms bendover data feed into structured database in batch increments of 1000
"""

batch_size = 1000


def transfer_core_profile(cursor, bo_data):
    try:
        for row in bo_data:
            # Extract fields from row
            first_name = row['first_name']
            last_name = row['last_name']

            # Transform data into appropriate format for storage in other tables
            insert = "INSERT INTO core_profile (f_name, l_name) VALUES (%s, %s)"
            data = (first_name, last_name)
            cursor.execute(insert, data)
        return True

    except Error as core_profile_error:
        print("Error connecting to MySQL database", core_profile_error)
        return False


def transfer_email(cursor, bo_data):
    try:

        for person in bo_data:
            statement = "SELECT core_profile.id " \
                        "FROM core_profile " \
                        "WHERE %s = f_name AND %s = l_name;"
            values = (person["first_name"], person["last_name"])
            cursor.execute(statement, values)
            results = cursor.fetchone()
            # Extract fields from sql results
            core_id = results["id"]

            # Transform data into appropriate format for storage in other tables
            insert = "INSERT INTO email (core_id, email) VALUES (%s, %s)"
            data = (core_id, person["email"])
            cursor.execute(insert, data)

        return True

    except Error as error:
        print("Error connecting to MySQL database", error)
        return False


def transfer_political_affiliation(cursor, bo_data):
    try:

        for person in bo_data:
            statement = "SELECT core_profile.id " \
                        "FROM core_profile " \
                        "WHERE %s = f_name AND %s = l_name;"
            values = (person["first_name"], person["last_name"])
            cursor.execute(statement, values)
            results = cursor.fetchone()
            # Extract fields from sql results
            core_id = results["id"]

            statement = "SELECT political_affiliation_lookup.id " \
                        "FROM political_affiliation_lookup " \
                        "WHERE affiliation = %s"
            values = (person["political_affiliation"])
            cursor.execute(statement, (values, ))
            results = cursor.fetchone()
            pol_affil_id = results["id"]

            # Transform data into appropriate format for storage in other tables
            insert = "INSERT INTO core_profile_has_political_affiliation " \
                     "(core_profile_id, political_affiliation_id, intensity) " \
                     "VALUES (%s, %s, %s)"
            data = (core_id, pol_affil_id, person["political_intensity"])
            cursor.execute(insert, data)

        return True

    except Error as error:
        print("Error connecting to MySQL database", error)
        return False


def transfer_religious_affiliation(cursor, bo_data):
    try:

        for person in bo_data:
            statement = "SELECT core_profile.id " \
                        "FROM core_profile " \
                        "WHERE %s = f_name AND %s = l_name;"
            values = (person["first_name"], person["last_name"])
            cursor.execute(statement, values)
            results = cursor.fetchone()
            # Extract fields from sql results
            core_id = results["id"]

            statement = "SELECT religious_affiliation_lookup.id " \
                        "FROM religious_affiliation_lookup " \
                        "WHERE affiliation = %s"
            values = (person["religious_affiliation"])
            cursor.execute(statement, (values, ))
            results = cursor.fetchone()
            rel_affil_id = results["id"]

            # Transform data into appropriate format for storage in other tables
            insert = "INSERT INTO core_profile_has_religious_affiliation " \
                     "(core_profile_id, religious_affiliation_look_up_id, intensity) " \
                     "VALUES (%s, %s, %s)"
            data = (core_id, rel_affil_id, person["religious_intensity"])
            cursor.execute(insert, data)

        return True

    except Error as error:
        print("Error connecting to MySQL database", error)
        return False


def transfer_social_issues(cursor, bo_data):
    try:

        for person in bo_data:
            statement = "SELECT core_profile.id " \
                        "FROM core_profile " \
                        "WHERE %s = f_name AND %s = l_name;"
            values = (person["first_name"], person["last_name"])
            cursor.execute(statement, values)
            results = cursor.fetchone()
            # Extract fields from sql results
            core_id = results["id"]
            issue_dict = eval(person["social_issue_views"])
            issue_keys = list(eval(person["social_issue_views"]).keys())
            for key in issue_keys:
                statement = "SELECT id " \
                            "FROM social_issue_view_lookup " \
                            "WHERE view = %s"
                cursor.execute(statement, (key, ))
                results = cursor.fetchone()
                issue_id = results["id"]
                opinion = issue_dict[key]["opinion"]
                intensity = issue_dict[key]["opinion_intensity"]
                post_date = issue_dict[key]["post_date"]
                # Transform data into appropriate format for storage in other tables
                insert = "INSERT INTO core_profile_has_social_issue_view " \
                         "(core_profile_id, social_issue_view_look_up_id, opinion, intensity, post_date) " \
                         "VALUES (%s, %s, %s, %s, %s)"
                data = (core_id, issue_id, opinion, intensity, post_date)
                cursor.execute(insert, data)

        return True

    except Error as error:
        print("Error connecting to MySQL database", error)
        return False


def transfer_social_mate_preference(cursor, bo_data):
    try:

        for person in bo_data:
            statement = "SELECT core_profile.id " \
                        "FROM core_profile " \
                        "WHERE %s = f_name AND %s = l_name;"
            values = (person["first_name"], person["last_name"])
            cursor.execute(statement, values)
            results = cursor.fetchone()
            # Extract fields from sql results
            core_id = results["id"]

            statement = "SELECT id " \
                        "FROM gender_lookup " \
                        "WHERE acronym = %s"
            mate_preferences = eval(person["social_mate_preference"])
            cursor.execute(statement, (mate_preferences["gender"], ))
            results = cursor.fetchone()
            gender_id = results["id"]

            statement = "SELECT id " \
                        "FROM political_affiliation_lookup " \
                        "WHERE affiliation = %s"
            cursor.execute(statement, (mate_preferences["political_affiliation"],))
            results = cursor.fetchone()
            political_affil_id = results["id"]

            statement = "SELECT id " \
                        "FROM religious_affiliation_lookup " \
                        "WHERE affiliation = %s"
            cursor.execute(statement, (mate_preferences["religious_affiliation"],))
            results = cursor.fetchone()
            religious_affil_id = results["id"]

            # Transform data into appropriate format for storage in other tables
            insert = "INSERT INTO social_mate_preference " \
                     "(core_profile_id, gender_id, political_affiliation_id, religious_affiliation_id) " \
                     "VALUES (%s, %s, %s, %s)"
            data = (core_id, gender_id, political_affil_id, religious_affil_id)
            cursor.execute(insert, data)

        return True

    except Error as error:
        print("Error connecting to MySQL database", error)
        return False


def transfer_demographic_data(cursor, bo_data):
    try:

        for person in bo_data:
            statement = "SELECT core_profile.id " \
                        "FROM core_profile " \
                        "WHERE %s = f_name AND %s = l_name;"
            values = (person["first_name"], person["last_name"])
            cursor.execute(statement, values)
            results = cursor.fetchone()
            # Extract fields from sql results
            core_id = results["id"]

            statement = "SELECT id " \
                        "FROM gender_lookup " \
                        "WHERE acronym = %s;"
            values = (person["gender"], )
            cursor.execute(statement, values)
            results = cursor.fetchone()
            # Extract fields from sql results
            gender_id = results["id"]

            # Transform data into appropriate format for storage in other tables
            insert = "INSERT INTO profile_demographic (core_id, gender_id, birthdate, most_recent_education," \
                     " current_occupation) VALUES (%s, %s, %s, %s, %s)"
            data = (core_id, gender_id, person["birthdate"], person["education"], person["occupation"])
            cursor.execute(insert, data)

        return True

    except Error as error:
        print("Error connecting to MySQL database", error)
        return False


if __name__ == '__main__':
    try:
        conn = mysql.connector.connect(**config)

        if conn.is_connected():
            print("Connected to MySQL database")

            main_cursor = conn.cursor(dictionary=True)
            main_cursor.execute("SELECT * FROM bendover_data_feed;")
            batch_data = main_cursor.fetchmany(batch_size)

            transfer_core_profile(main_cursor, batch_data)
            conn.commit()
            print("core_profile loaded successfully!")

            transfer_email(main_cursor, batch_data)
            conn.commit()
            print("email loaded successfully!")

            transfer_political_affiliation(main_cursor, batch_data)
            conn.commit()
            print("political affiliation loaded successfully")

            transfer_religious_affiliation(main_cursor, batch_data)
            conn.commit()
            print("religious affiliation loaded successfully")

            transfer_social_issues(main_cursor, batch_data)
            conn.commit()
            print("social issues loaded successfully")

            transfer_social_mate_preference(main_cursor, batch_data)
            conn.commit()
            print("social mate preferences loaded successfully")

            transfer_demographic_data(main_cursor, batch_data)
            conn.commit()
            print("demographic data loaded successfully")

            main_cursor.close()
            conn.close()

    except Error as e:
        print("Error connecting to MySQL database", e)
