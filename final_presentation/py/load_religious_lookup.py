import mysql.connector
import json
from vm_config import host, user, password, database
# Load JSON data from file
with open('../json/religious_affiliation_lookup.json', 'r') as f:
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

# Insert each religious affiliation as a new row in the table
for affiliation in data['religious_affiliation_lookup']:
    add_affiliation = ("INSERT INTO religious_affiliation_lookup "
                       "(affiliation) "
                       "VALUES (%s)")
    data_affiliation = (affiliation,)
    cursor.execute(add_affiliation, data_affiliation)


# Commit the changes and close the connection
db.commit()
cursor.close()
db.close()
