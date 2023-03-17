import mysql.connector
from mysql.connector import Error

from final_presentation.py_by_gary.json_extraction_methods import *
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
            cursor.execute(statement, (values,))
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
            cursor.execute(statement, (values,))
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
                cursor.execute(statement, (key,))
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
            cursor.execute(statement, (mate_preferences["gender"],))
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
            values = (person["gender"],)
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


def load_social_media():
    from random_dates import dates
    import random

    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor(dictionary=True, buffered=True) as cursor:
            user_stmt = "SELECT * FROM bendover_data_feed;"
            cursor.execute(user_stmt)
            users = cursor.fetchall()
            count = random.randint(3, 6)
            for user in users:
                statement = "SELECT core_profile.id " \
                            "FROM core_profile " \
                            "WHERE f_name = %s AND l_name = %s;"
                values = (user["first_name"], user["last_name"])
                cursor.execute(statement, values)
                results = cursor.fetchone()
                core_id = results["id"]

                if user["political_affiliation"] == "Democratic Party":
                    stmt = "SELECT * FROM group_lookup WHERE political_lean = 'left' ORDER BY RAND() LIMIT %s"
                elif user["political_affiliation"] == "Republican Party":
                    stmt = "SELECT * FROM group_lookup WHERE political_lean = 'right' ORDER BY RAND() LIMIT %s"
                else:
                    stmt = "SELECT * FROM group_lookup ORDER BY RAND() LIMIT %s"
                cursor.execute(stmt, (count,))
                user_groups = cursor.fetchall()
                for group in user_groups:
                    random_idx = random.randrange(len(dates))
                    url = "/".join(group['group_url'].split("/")[:3]) + "/" + user["first_name"].lower() + user[
                        "last_name"].lower()

                    stmt = "SELECT social_media_platform_id FROM `group` " \
                           "WHERE group.id = %s"

                    values = (group["id"])
                    cursor.execute(stmt, (values,))
                    sm_platform_id = cursor.fetchone()['social_media_platform_id']
                    stmt = "INSERT INTO social_media (core_id, sm_platform_id, user_guid, url, last_active, group_id) " \
                           "VALUES(%s, %s, %s, %s, %s, %s)"
                    values = (core_id, sm_platform_id, None, url, dates[random_idx], group['id'])
                    cursor.execute(stmt, values)
            cnx.commit()


def load_web_media():
    from random_dates import dates
    import random
    web_media_types = ["ad", "broadcast", "podcast", "website"]

    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor(dictionary=True, buffered=True) as cursor:
            user_stmt = "SELECT * FROM bendover_data_feed;"
            cursor.execute(user_stmt)
            users = cursor.fetchall()
            for user in users:

                statement = "SELECT core_profile.id " \
                            "FROM core_profile " \
                            "WHERE %s = f_name AND %s = l_name;"
                values = (user["first_name"], user["last_name"])
                cursor.execute(statement, values)
                results = cursor.fetchone()
                core_id = results["id"]

                statement = "SELECT id FROM political_affiliation_lookup WHERE affiliation = %s"
                cursor.execute(statement, (user["political_affiliation"],))
                pol_affil_id = cursor.fetchone()["id"]

                for media_entry_type in ["ad", "broadcast", "podcast", "website"]:
                    if media_entry_type == 'ad':
                        count = random.randint(8, 15)
                        stmt = "SELECT * FROM ad WHERE political_affiliation_id = %s ORDER BY RAND() LIMIT %s"

                        cursor.execute(stmt, (pol_affil_id, count))
                        user_ads = cursor.fetchall()

                        for ad in user_ads:
                            random_idx = random.randrange(len(dates))
                            length_of_stay_seconds = random.randint(15, 120)  # 15 seconds - 2 minutes
                            stmt = "INSERT INTO web_media (core_id, click_timestamp, ad_id, podcast_id, " \
                                   "web_broadcast_id, website_id, length_of_stay_seconds ) " \
                                   "VALUES(%s, %s, %s, %s, %s, %s, %s)"
                            values = (core_id, dates[random_idx], ad['id'], None, None,
                                      None, length_of_stay_seconds)

                            cursor.execute(stmt, values)

                    elif media_entry_type == 'broadcast':
                        count = random.randint(3, 10)
                        stmt = "SELECT * " \
                               "FROM web_broadcast " \
                               "WHERE political_affiliation_id = %s ORDER BY RAND() LIMIT %s"
                        cursor.execute(stmt, (pol_affil_id, count))
                        user_broadcasts = cursor.fetchall()

                        for broadcast in user_broadcasts:
                            random_idx = random.randrange(len(dates))
                            length_of_stay_seconds = random.randint(30, 3720)  # 30 seconds - 62 minutes

                            stmt = "INSERT INTO web_media (core_id, click_timestamp, ad_id, podcast_id, " \
                                   "web_broadcast_id, website_id, length_of_stay_seconds ) " \
                                   "VALUES(%s, %s, %s, %s, %s, %s, %s)"
                            values = (core_id, dates[random_idx], None, None, broadcast['id'],
                                      None, length_of_stay_seconds)

                            cursor.execute(stmt, values)

                    elif media_entry_type == 'podcast':
                        count = random.randint(6, 10)
                        stmt = "SELECT * " \
                               "FROM podcast " \
                               "WHERE political_affiliation_id = %s ORDER BY RAND() LIMIT %s"
                        cursor.execute(stmt, (pol_affil_id, count))
                        user_podcasts = cursor.fetchall()

                        for podcast in user_podcasts:
                            random_idx = random.randrange(len(dates))
                            length_of_stay_seconds = random.randint(120, 1920)  # 2 minutes - 32 minutes

                            stmt = "INSERT INTO web_media (core_id, click_timestamp, ad_id, podcast_id, " \
                                   "web_broadcast_id, website_id, length_of_stay_seconds ) " \
                                   "VALUES(%s, %s, %s, %s, %s, %s, %s)"
                            values = (core_id, dates[random_idx], None, podcast['id'], None,
                                      None, length_of_stay_seconds)

                            cursor.execute(stmt, values)

                    elif media_entry_type == 'website':
                        count = random.randint(9, 18)
                        stmt = "SELECT * " \
                               "FROM website " \
                               "WHERE political_affiliation_id = %s ORDER BY RAND() LIMIT %s"
                        cursor.execute(stmt, (pol_affil_id, count))
                        user_websites = cursor.fetchall()

                        for website in user_websites:
                            random_idx = random.randrange(len(dates))
                            length_of_stay_seconds = random.randint(180, 2700)  # 3 minutes - 45 minutes

                            stmt = "INSERT INTO web_media (core_id, click_timestamp, ad_id, podcast_id, " \
                                   "web_broadcast_id, website_id, length_of_stay_seconds ) " \
                                   "VALUES(%s, %s, %s, %s, %s, %s, %s)"
                            values = (core_id, dates[random_idx], None, None, None,
                                      website['id'], length_of_stay_seconds)

                            cursor.execute(stmt, values)
            cnx.commit()


def load_printed_media_subscriptions():
    import random

    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor(dictionary=True, buffered=True) as cursor:
            user_stmt = "SELECT * FROM bendover_data_feed;"
            cursor.execute(user_stmt)
            users = cursor.fetchall()

            for subscriber in users:
                statement = "SELECT core_profile.id " \
                            "FROM core_profile " \
                            "WHERE f_name = %s AND l_name = %s;"
                values = (subscriber["first_name"], subscriber["last_name"])
                cursor.execute(statement, values)
                results = cursor.fetchone()
                core_id = results["id"]

                for printed_media_type in ["newspaper", "magazine"]:
                    if printed_media_type == "newspaper":
                        count = random.randint(1, 6)
                        stmt = "SELECT * FROM newspaper WHERE political_affiliation_id = " \
                               "(SELECT id FROM political_affiliation_lookup WHERE affiliation = %s) " \
                               "ORDER BY RAND() LIMIT %s"
                        cursor.execute(stmt, (subscriber["political_affiliation"], count))
                        newspapers = cursor.fetchall()

                        for paper in newspapers:
                            stmt = "INSERT INTO printed_media_subscription (core_id, newspaper_id, magazine_id) " \
                                   "VALUES(%s, %s, %s)"
                            values = (core_id, paper['id'], None)
                            cursor.execute(stmt, values)

                    if printed_media_type == "magazine":
                        count = random.randint(3, 6)
                        stmt = "SELECT * FROM magazine WHERE political_affiliation_id = " \
                               "(SELECT id FROM political_affiliation_lookup WHERE affiliation = %s) " \
                               "ORDER BY RAND() LIMIT %s"
                        cursor.execute(stmt, (subscriber["political_affiliation"], count))
                        magazines = cursor.fetchall()

                        for magazine in magazines:
                            stmt = "INSERT INTO printed_media_subscription (core_id, newspaper_id, magazine_id) " \
                                   "VALUES(%s, %s, %s)"
                            values = (core_id, None, magazine['id'])
                            cursor.execute(stmt, values)
            cnx.commit()


if __name__ == '__main__':
    try:
        conn = mysql.connector.connect(**config)

        if conn.is_connected():
            print("Connected to MySQL database")

            # load json
            load_bendover_data_feed("../json/bendover_data_feed.json")
            load_religious_affiliation_lookup_mysql("../json/religious_affiliation_lookup.json")
            load_political_affiliation_lookup_mysql("../json/political_affiliation_lookup.json")
            load_social_issue_view_type_lookup("../json/social_issue_view_type_lookup.json")
            load_social_issue_view_lookup("../json/social_issue_view_lookup.json")
            load_social_media_platform("../json/social_media_platform.json")
            load_gender("../json/gender.json")
            load_marketing_agency("../json/marketing_agency.json")
            load_newspaper("../json/newspaper.json")
            load_magazine("../json/magazine.json")
            load_web_broadcast("../json/web_broadcast.json")
            load_website("../json/website.json")
            load_podcast("../json/podcast.json")
            load_ad("../json/ad.json")
            load_social_media_group_lookup("../json/social_media_groups.json")
            load_group("../json/social_media_groups.json")
            print("json loaded successfully")

            main_cursor = conn.cursor(dictionary=True)
            main_cursor.execute("SELECT * FROM bendover_data_feed;")
            batch_data = main_cursor.fetchmany(batch_size)

            transfer_core_profile(main_cursor, batch_data)
            conn.commit()
            print("core_profile transferred successfully!")

            transfer_email(main_cursor, batch_data)
            conn.commit()
            print("email transferred successfully!")

            transfer_political_affiliation(main_cursor, batch_data)
            conn.commit()
            print("political affiliation transferred successfully")

            transfer_religious_affiliation(main_cursor, batch_data)
            conn.commit()
            print("religious affiliation transferred successfully")

            transfer_social_issues(main_cursor, batch_data)
            conn.commit()
            print("social issues transferred successfully")

            transfer_social_mate_preference(main_cursor, batch_data)
            conn.commit()
            print("social mate preferences transferred successfully")

            transfer_demographic_data(main_cursor, batch_data)
            conn.commit()
            print("demographic data transferred successfully")

            load_social_media()
            print("social media loaded successfully")

            load_web_media()
            print("web media loaded successfully")

            load_printed_media_subscriptions()
            print("printed media subscriptions loaded successfully")

            main_cursor.close()
            conn.close()

    except Error as e:
        print("Error connecting to MySQL database", e)
