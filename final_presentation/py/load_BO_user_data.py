import mysql.connector
import json
from vm_config import host, user, password, database


def load_bendover_data_feed(json_file_path):
    # Load JSON data from file
    with open(json_file_path, 'r') as f:
        data = json.load(f)

    # Connect to MySQL database
    db = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )

    # Create cursor object to execute SQL queries
    cursor = db.cursor()

    # Loop through each person's information and insert it into the MySQL table
    for person in data["data"]:
        sql = "INSERT INTO bendover_data_feed (" \
              "bendover_id," \
              "first_name," \
              "last_name," \
              "email," \
              "political_affiliation," \
              "political_intensity," \
              "religious_affiliation," \
              "religious_intensity," \
              "social_issue_views," \
              "social_mate_preference," \
              "gender," \
              "birthdate," \
              "location," \
              "education," \
              "occupation," \
              "hobbies) " \
              "VALUES (" \
              "%s, " \
              "%s," \
              "%s," \
              "%s," \
              "%s," \
              "%s," \
              "%s," \
              "%s," \
              "%s," \
              "%s," \
              "%s," \
              "%s," \
              "%s," \
              "%s," \
              "%s," \
              "%s)"
        values = (
            person["id"],
            person["first_name"],
            person["last_name"],
            person["email"],
            person["political_affiliation"],
            person["political_intensity"],
            person["religious_affiliation"],
            person["religious_intensity"],
            json.dumps(person["social_issues"]),
            json.dumps(person["social_mate_preference"]),
            person["gender"],
            person["birthdate"],
            person["location"],
            person["education"],
            person["occupation"],
            json.dumps(person["hobbies"])
        )
        print(values)
        cursor.execute(sql, values)
        db.commit()

    # Close the database connection
    db.close()
