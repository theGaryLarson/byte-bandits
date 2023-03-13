import mysql.connector
import json
from vm_config import config;


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
                print(add_affiliation, data_affiliation)
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
                print(add_affiliation, data_affiliation)
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
                print(add_category, data_category)
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
                print(add_platform, data_platform)
                cursor.execute(add_platform, data_platform)

        # Commit the changes
        cnx.commit()


if __name__ == '__main__':
    # load_religious_affiliation_lookup_mysql("../json/religious_affiliation_lookup.json")
    # load_political_affiliation_lookup_mysql("../json/political_affiliation_lookup.json")
    # load_social_issue_view_type_lookup("../json/social_issue_view_type_lookup.json")
    load_social_media_platform("../json/social_media_platform.json")
    print()
