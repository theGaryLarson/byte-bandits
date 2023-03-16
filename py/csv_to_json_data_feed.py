import csv
import json
from datetime import datetime

csv_filename = "../csv/clean_bendover_data_feed.csv"
json_filename = "clean_bendover_data_feed.json"

data = {"data": []}

with open(csv_filename, "r") as csv_file:
    reader = csv.DictReader(csv_file)
    for row in reader:
        # Convert political_intensity and religious_intensity to integers
        row["political_intensity"] = int(row["political_intensity"])
        row["religious_intensity"] = int(row["religious_intensity"])

        # Convert social_issue_views to dictionary
        row["social_issue_views"] = json.loads(row["social_issue_views"])

        # Convert social_issue_post_date to dictionary with date values as datetime objects
        social_issue_post_date_dict = json.loads(row["social_issue_post_date"])
        for key, value in social_issue_post_date_dict.items():
            social_issue_post_date_dict[key] = datetime.strptime(value, "%Y-%m-%d").strftime("%Y-%m-%d")
        row["social_issue_post_date"] = social_issue_post_date_dict

        # Convert social_issue_view_intensity to dictionary with integer values
        row["social_issue_view_intensity"] = {key: int(value) for key, value in
                                              json.loads(row["social_issue_view_intensity"]).items()}

        # Convert social_mate_preference to dictionary
        row["social_mate_preference"] = json.loads(row["social_mate_preference"])

        # Calculate birthdate based on age
        row["birthdate"] = (datetime.now() - datetime.strptime(row["age"], "%Y").replace(tzinfo=None)).days // 365
        del row["age"]

        data["data"].append(row)

with open(json_filename, "w") as json_file:
    json.dump(data, json_file, indent=2)
