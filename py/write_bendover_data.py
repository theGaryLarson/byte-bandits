import csv
import json

# Load JSON data from file
with open('../json/bendover_data.json', 'r') as f:
    data = json.load(f)

# Write data to CSV file
with open('../csv/bendover_data_feed.csv', 'w', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=data['data'][0].keys())
    writer.writeheader()
    for row in data['data']:
        writer.writerow(row)
