import mysql.connector
import json
from vm_config import config;
from load_BO_user_data import load_bendover_data_feed


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
        load_podcast is dependent on political_affiliation table
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
                        agency_id = party_result[0]
                add_ad = "INSERT INTO ad (name, marketing_agency_id,  political_affiliation_id)" \
                         "  VALUES (%s, %s, %s)"
                data_ad = (ad['ad_title'], agency_id, party_id)
                cursor.execute(add_ad, data_ad)

        # Commit the changes
        cnx.commit()


if __name__ == '__main__':
    load_bendover_data_feed("../json/bendover_data_feed.json")
    load_religious_affiliation_lookup_mysql("../json/religious_affiliation_lookup.json")
    load_political_affiliation_lookup_mysql("../json/political_affiliation_lookup.json")
    load_social_issue_view_type_lookup("../json/social_issue_view_type_lookup.json")
    load_social_media_platform("../json/social_media_platform.json")
    load_marketing_agency("../json/marketing_agency.json")
    # methods dependent on political_affiliation_lookup table
    load_newspaper("../json/newspaper.json")
    load_magazine("../json/magazine.json")
    load_web_broadcast("../json/web_broadcast.json")
    load_website("../json/website.json")
    load_podcast("../json/podcast.json")
    # dependent on marketing_agency and political_affiliation_lookup tables
    load_ad("../json/ad.json")
    print()
