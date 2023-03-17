## Instructions to load data
****

### run _final_presentation/schema.sql_
#### Python Files
    # be sure to create a vm_config.py file and include your connection settings

    host = "localhost"
    user = ""
    password = ""
    database = ""
    connector_path = "C:/Program Files/MySQL/mysql-connector-java-1.8.2-bin.jar"
    driver = "com.mysql.jdbc.Driver"
    
    config = {
        'host': "localhost",
        'user': "",
        'password': "",
        'database': "votemate"
    }

1. _run py_by_gary/generate_data.py_
2. _run load_election_data.py_
****
#### sql files

3. _sql/voter_info_by_emily_brank.sql_
4. _sql/ballot_join_by_robel_hailu.sql_

****
_**The database should be loaded and can run queries in the following:**_
 1. _analytics_by_emily_brink.sql_
 2. _media_influences_by_gary_larson_and_nicklas_dipietro.sql_


****
SECTIONS

Clickstreams & Web Media: Gary Larson & Nicklas DiPietro
Ballot Section: Robel Hailu
Voter Profile & Auth: Emily Brink
