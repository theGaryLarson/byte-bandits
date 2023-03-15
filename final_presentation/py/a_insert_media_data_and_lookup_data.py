import random

import mysql.connector
import json
from vm_config import config
from insert_bendover_data_in_table import load_bendover_data_feed


def load_religious_affiliation_lookup_mysql(json_file_path):
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    # Insert each item as a new row in the table
    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            for affiliation in data['religious_affiliation_lookup']:
                add_affiliation = "INSERT INTO religious_affiliation_lookup (affiliation)  VALUES (%s)"
                data_affiliation = (affiliation,)
                cursor.execute(add_affiliation, data_affiliation)

        # Commit the changes
        cnx.commit()


def load_political_affiliation_lookup_mysql(json_file_path):
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    # Insert each item as a new row in the table
    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            for affiliation in data['political_affiliation_lookup']:
                add_affiliation = "INSERT INTO political_affiliation_lookup (affiliation)  VALUES (%s)"
                data_affiliation = (affiliation['party'],)
                cursor.execute(add_affiliation, data_affiliation)

        # Commit the changes
        cnx.commit()


def load_social_issue_view_type_lookup(json_file_path):
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    # Insert each item as a new row in the table
    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            for category in data['social_issue_view_type_lookup']:
                add_category = "INSERT INTO social_issue_view_type_lookup (category)  VALUES (%s)"
                data_category = (category['category'],)
                cursor.execute(add_category, data_category)

        # Commit the changes
        cnx.commit()


def load_social_media_platform(json_file_path):
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    # Insert each item as a new row in the table
    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            for platform in data['social_media_platform']:
                add_platform = "INSERT INTO social_media_platform (platform)  VALUES (%s)"
                data_platform = (platform['platform'],)
                cursor.execute(add_platform, data_platform)

        # Commit the changes
        cnx.commit()

def load_gender(json_file_path):
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    # Insert each item as a new row in the table
    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            for gender in data['gender_options']:
                add_gender = "INSERT INTO gender_lookup (identity, acronym)  VALUES (%s, %s)"
                data_gender = (gender['full_name'], gender['abbrev'])
                cursor.execute(add_gender, data_gender)

        # Commit the changes
        cnx.commit()

def load_marketing_agency(json_file_path):
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    # Insert each item as a new row in the table
    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            for agency in data['marketing_agency']:
                add_agency = "INSERT INTO marketing_agency (name, url, headquarters)  VALUES (%s, %s, %s)"
                data_agency = (agency['name'], agency['website'], agency['headquarters'])
                cursor.execute(add_agency, data_agency)

        # Commit the changes
        cnx.commit()


def load_newspaper(json_file_path):
    """
        load_newspaper is dependent on political_affiliation table
    """
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    # Insert each item as a new row in the table
    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            for newspaper in data['national_newspapers']:
                party_id = None
                if newspaper["associated_party"] is not None:
                    query = "SELECT id FROM political_affiliation_lookup WHERE affiliation = %s"
                    cursor.execute(query, (newspaper["associated_party"],))
                    result = cursor.fetchone()
                    if result is not None:
                        party_id = result[0]
                add_newspaper = "INSERT INTO newspaper (name, political_affiliation_id)  VALUES (%s, %s)"
                data_newspaper = (newspaper['newspaper'], party_id)
                cursor.execute(add_newspaper, data_newspaper)

        # Commit the changes
        cnx.commit()


def load_magazine(json_file_path):
    """
        load_magazine is dependent on political_affiliation table
    """
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    # Insert each item as a new row in the table
    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            for magazine in data['national_magazines']:
                party_id = None
                if magazine["associated_party"] is not None:
                    query = "SELECT id FROM political_affiliation_lookup WHERE affiliation = %s"
                    cursor.execute(query, (magazine["associated_party"],))
                    result = cursor.fetchone()
                    if result is not None:
                        party_id = result[0]
                add_newspaper = "INSERT INTO magazine (name, political_affiliation_id)  VALUES (%s, %s)"
                data_newspaper = (magazine['magazine'], party_id)
                cursor.execute(add_newspaper, data_newspaper)

        # Commit the changes
        cnx.commit()


def load_web_broadcast(json_file_path):
    """
        load_web_broadcast is dependent on political_affiliation table
    """
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    # Insert each item as a new row in the table
    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            for web_broadcast in data['web_broadcast']:
                party_id = None
                if web_broadcast["associated_party"] is not None:
                    query = "SELECT id FROM political_affiliation_lookup WHERE affiliation = %s"
                    cursor.execute(query, (web_broadcast["associated_party"],))
                    result = cursor.fetchone()
                    if result is not None:
                        party_id = result[0]
                add_web_broadcast = "INSERT INTO web_broadcast (name, broadcast_url,  political_affiliation_id)" \
                                    "  VALUES (%s, %s, %s)"
                data_web_broadcast = (web_broadcast['name'], web_broadcast['url'], party_id)
                cursor.execute(add_web_broadcast, data_web_broadcast)

        # Commit the changes
        cnx.commit()


def load_website(json_file_path):
    """
        load_website is dependent on political_affiliation table
    """
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    # Insert each item as a new row in the table
    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            for website in data['website']:
                party_id = None
                if website["associated_party"] is not None:
                    query = "SELECT id FROM political_affiliation_lookup WHERE affiliation = %s"
                    cursor.execute(query, (website["associated_party"],))
                    result = cursor.fetchone()
                    if result is not None:
                        party_id = result[0]
                add_website = "INSERT INTO website (name, website_url,  political_affiliation_id)" \
                              "  VALUES (%s, %s, %s)"
                data_web_website = (website['name'], website['url'], party_id)
                cursor.execute(add_website, data_web_website)

        # Commit the changes
        cnx.commit()



def load_podcast(json_file_path):
    """
        load_podcast is dependent on political_affiliation table
    """
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    # Insert each item as a new row in the table
    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            for podcast in data['podcast']:
                party_id = None
                if podcast["associated_party"] is not None:
                    query = "SELECT id FROM political_affiliation_lookup WHERE affiliation = %s"
                    cursor.execute(query, (podcast["associated_party"],))
                    result = cursor.fetchone()
                    if result is not None:
                        party_id = result[0]
                add_podcast = "INSERT INTO podcast (name, podcast_url,  political_affiliation_id)" \
                              "  VALUES (%s, %s, %s)"
                data_podcast = (podcast['name'], podcast['url'], party_id)
                cursor.execute(add_podcast, data_podcast)

        # Commit the changes
        cnx.commit()


def load_ad(json_file_path):
    """
        load_ad is dependent on tables: political_affiliation, marketing_agency
    """
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    # Insert each item as a new row in the table
    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            for ad in data['ad']:
                party_id = None
                if ad["associated_party"] is not None:
                    party_query = "SELECT id FROM political_affiliation_lookup WHERE affiliation = %s"
                    cursor.execute(party_query, (ad["associated_party"],))
                    party_result = cursor.fetchone()
                    if party_result is not None:
                        party_id = party_result[0]
                agency_id = None
                if ad["marketing_agency"] is not None:
                    agency_query = "SELECT id FROM marketing_agency WHERE name = %s"
                    cursor.execute(agency_query, (ad["marketing_agency"],))
                    agency_result = cursor.fetchone()

                    if agency_result is not None:
                        agency_id = agency_result[0]
                add_ad = "INSERT INTO ad (ad_title, marketing_agency_id,  political_affiliation_id, start_airtime," \
                         "end_airtime, networks)" \
                         "  VALUES (%s, %s, %s, %s, %s, %s)"
                data_ad = (ad['ad_title'], agency_id, party_id, ad["start_airtime"], ad["end_airtime"],
                           json.dumps(ad["networks"]))
                cursor.execute(add_ad, data_ad)

        # Commit the changes
        cnx.commit()



def load_social_issue_view_lookup(json_file_path):
    """
        load_social_issue_view_lookup is dependent on table: social_issue_view_type_lookup
    """
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    # Insert each item as a new row in the table
    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            for issue in data['social_issue_view_lookup']:
                category_id = None
                if issue["category"] is not None:
                    query = "SELECT id FROM social_issue_view_type_lookup WHERE category = %s"
                    cursor.execute(query, (issue["category"],))
                    cat_id = cursor.fetchone()
                    if cat_id is not None:
                        category_id = cat_id[0]
                add_issue = "INSERT INTO social_issue_view_lookup (view, view_type_id)" \
                         "  VALUES (%s, %s)"
                data_issue = (issue['subcategory'], category_id)
                cursor.execute(add_issue, data_issue)

        # Commit the changes
        cnx.commit()


def load_social_media_group_lookup(json_file_path):
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    # Insert each item as a new row in the table
    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            for pair in data['social_media_groups']:
                for idx, group in enumerate(pair["groups"]):
                    name = group["name"]
                    lean = group["political_leaning"]
                    url = group["url"]
                    add_group = "INSERT INTO group_lookup (name, political_lean, group_url)  " \
                                "VALUES (%s, %s, %s)"
                    data_platform = (name, lean, url)
                    cursor.execute(add_group, data_platform)

        # Commit the changes
        cnx.commit()


def load_group(json_file_path):
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    with mysql.connector.connect(**config) as cnx:
        with cnx.cursor() as cursor:
            for pair in data['social_media_groups']:
                statement = "SELECT id FROM social_media_platform WHERE platform = %s;"
                cursor.execute(statement, (pair["platform"],))
                social_media_id = cursor.fetchone()[0]
                for group in pair["groups"]:
                    statement = "SELECT id FROM group_lookup WHERE name = %s"
                    cursor.execute(statement, (group["name"],))
                    group_lookup_id = cursor.fetchone()[0]
                    insert_stmt = "INSERT INTO `group` (group_lookup_id, social_media_platform_id) " \
                                  "VALUES (%s, %s)"
                    data = (group_lookup_id, social_media_id)
                    cursor.execute(insert_stmt, data)
            cnx.commit()


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
                            "WHERE %s = f_name AND %s = l_name;"
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
                cursor.execute(stmt, (count, ))
                user_groups = cursor.fetchall()
                for group in user_groups:
                    random_idx = random.randrange(len(dates))
                    url = "/".join(group['group_url'].split("/")[:3]) + "/" + user["first_name"].lower() + user["last_name"].lower()

                    stmt = "SELECT social_media_platform_id FROM `group` " \
                            "WHERE group.id = %s"

                    values = (group["id"])
                    cursor.execute(stmt, (values,))
                    sm_platform_id = cursor.fetchone()['social_media_platform_id']
                    stmt = "INSERT INTO social_media (core_id, sm_platform_id, user_guid, url, last_active, group_id) " \
                           "VALUES(%s, %s, %s, %s, %s, %s)"
                    values = (core_id, sm_platform_id, None,  url, dates[random_idx], group['id'])
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
                        count = random.randint(6, 10)
                        stmt = "SELECT * FROM ad WHERE political_affiliation_id = %s ORDER BY RAND() LIMIT %s"

                        cursor.execute(stmt, (pol_affil_id, count))
                        user_ads = cursor.fetchall()

                        for ad in user_ads:
                            random_idx = random.randrange(len(dates))
                            length_of_stay_seconds = random.randint(15, 120) # 15 seconds - 2 minutes
                            stmt = "INSERT INTO web_media (core_id, click_timestamp, ad_id, podcast_id, " \
                                   "web_broadcast_id, website_id, length_of_stay_seconds ) " \
                                   "VALUES(%s, %s, %s, %s, %s, %s, %s)"
                            values = (core_id, dates[random_idx], ad['id'], None, None,
                                      None, length_of_stay_seconds)

                            cursor.execute(stmt, values)

                    elif media_entry_type == 'broadcast':
                        count = random.randint(6, 10)
                        stmt = "SELECT * FROM web_broadcast WHERE political_affiliation_id = %s ORDER BY RAND() LIMIT %s"
                        cursor.execute(stmt, (pol_affil_id, count))
                        user_broadcasts = cursor.fetchall()

                        for broadcast in user_broadcasts:
                            random_idx = random.randrange(len(dates))
                            length_of_stay_seconds = random.randint(30, 3720) # 30 seconds - 62 minutes

                            stmt = "INSERT INTO web_media (core_id, click_timestamp, ad_id, podcast_id, " \
                                   "web_broadcast_id, website_id, length_of_stay_seconds ) " \
                                   "VALUES(%s, %s, %s, %s, %s, %s, %s)"
                            values = (core_id, dates[random_idx], None, None, broadcast['id'],
                                      None, length_of_stay_seconds)

                            cursor.execute(stmt, values)

                    elif media_entry_type == 'podcast':
                        count = random.randint(6, 10)
                        stmt = "SELECT * FROM podcast WHERE political_affiliation_id = %s ORDER BY RAND() LIMIT %s"
                        cursor.execute(stmt, (pol_affil_id, count))
                        user_podcasts = cursor.fetchall()

                        for podcast in user_podcasts:
                            random_idx = random.randrange(len(dates))
                            length_of_stay_seconds = random.randint(120, 1920) # 2 minutes - 32 minutes

                            stmt = "INSERT INTO web_media (core_id, click_timestamp, ad_id, podcast_id, " \
                                   "web_broadcast_id, website_id, length_of_stay_seconds ) " \
                                   "VALUES(%s, %s, %s, %s, %s, %s, %s)"
                            values = (core_id, dates[random_idx], None, podcast['id'], None,
                                      None, length_of_stay_seconds)

                            cursor.execute(stmt, values)

                    elif media_entry_type == 'website':
                        count = random.randint(6, 10)
                        stmt = "SELECT * FROM website WHERE political_affiliation_id = %s ORDER BY RAND() LIMIT %s"
                        cursor.execute(stmt, (pol_affil_id, count))
                        user_websites = cursor.fetchall()

                        for website in user_websites:
                            random_idx = random.randrange(len(dates))
                            length_of_stay_seconds = random.randint(180, 2700) # 3 minutes - 45 minutes

                            stmt = "INSERT INTO web_media (core_id, click_timestamp, ad_id, podcast_id, " \
                                   "web_broadcast_id, website_id, length_of_stay_seconds ) " \
                                   "VALUES(%s, %s, %s, %s, %s, %s, %s)"
                            values = (core_id, dates[random_idx], None, None, None,
                                      website['id'], length_of_stay_seconds)

                            cursor.execute(stmt, values)
            cnx.commit()

if __name__ == '__main__':
    load_bendover_data_feed("../json/bendover_data_feed.json")
    load_religious_affiliation_lookup_mysql("../json/religious_affiliation_lookup.json")
    load_political_affiliation_lookup_mysql("../json/political_affiliation_lookup.json")
    load_social_issue_view_type_lookup("../json/social_issue_view_type_lookup.json")
    load_social_media_platform("../json/social_media_platform.json")
    load_gender("../json/gender.json")
    load_marketing_agency("../json/marketing_agency.json")
    load_newspaper("../json/newspaper.json")
    load_magazine("../json/magazine.json")
    load_web_broadcast("../json/web_broadcast.json")
    load_website("../json/website.json")
    load_podcast("../json/podcast.json")
    load_ad("../json/ad.json")
    load_social_issue_view_lookup("../json/social_issue_view_lookup.json")
    load_social_media_group_lookup("../json/social_media_groups.json")
    load_group("../json/social_media_groups.json")
    load_social_media()
    load_web_media()
    print()
