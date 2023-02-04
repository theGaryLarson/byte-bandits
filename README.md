## Byte Bandits Group SQL Project | Targeted Marketing
AD350 group project. Repo created for sharing and merging scripts. Don't worry about breaking it. I know enough where we can rollback to previous commits.
But if you want to play around and learn to use git in a collaborative way I suggest creating a branch then doing a pull request to merge changes.

### Folders and their Purpose
* **csv** - contains all the csv files that have been converted from json
* **json** - contains the json files. (_this is how we get data from our data feeds_)
* **py** - contains python scripts for converting json to csv and converting opinions into likert scale rating
* **snippets** - some tidbits and incomplete procedures experimenting with different aspects of SQL
* **stored_procedures** - contains all the stored procedure scripts for the targeted_marketing schema
* **functions** - helper methods to make procedures code more readable
* **view_data_scripts** - contains all the views created for the targeted_marketing schema

### Core Files (targeted_marketing schema)
* **byte_bandits_schema.sql** - creates all tables and their relationships
* **byte_bandits_inserts.sql** - inserts some example data into the tables (_at least 5 rows of data_)
* **csv/clean_bendover_data_feed.csv** - use this file or the json equivalent when creating stored procedures to load data
  * Jane Doe is intentionally entered 2x. There is an opinion intensity change. It may be easier to view in the json file
