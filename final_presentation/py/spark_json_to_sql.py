import json
import mysql.connector
from pyspark.sql import SparkSession
from vm_config import config, host, user, database, password, connector_path


def check_schema(json_feed_data, sql_table, sql_user, sql_password, mysql_host, mysql_database):
    """
        json feed data must have an attribute titled "schema"
        Checks table fields against json attributes to make sure there is a match
        prior to trying to load into table.
    """
    # Connect to MySQL
    connection = mysql.connector.connect(user=sql_user, password=sql_password, host=mysql_host,
                                         database=mysql_database)
    cursor = connection.cursor()

    # Get MySQL table schema
    query = f"DESCRIBE {sql_table}"
    cursor.execute(query)
    mysql_columns = [column[0] for column in cursor.fetchall()]

    # Get JSON schema
    json_columns = [field.name for field in json_feed_data.schema.fields]

    # Compare MySQL and JSON schemas
    if set(mysql_columns) != set(json_columns):
        return False

    return True


def transfer_json_to_mysql(json_file_path, url_mysql, table_mysql, user_mysql, password_mysql, path_to_mysql_connector):
    # Initialize Spark session
    spark = SparkSession.builder \
        .appName("JSON to MySQL") \
        .config("spark.jars", path_to_mysql_connector) \
        .getOrCreate()

    # Read JSON data
    json_data_from_spark = spark.read.json(json_file_path)

    # Write JSON data to MySQL
    json_data_from_spark.write.jdbc(url=url_mysql, table=table_mysql, mode="overwrite", properties=config)

    # Stop Spark session
    spark.stop()


if __name__ == '__main__':
    # Example usage
    json_path = "../../json/clean_bendover_data.json"
    mysql_url = f"jdbc:mysql://{host}/{database}"
    mysql_table = "bendover_data_feed"
    mysql_user = user
    mysql_password = password
    mysql_connector_path = connector_path

    with open(json_path, 'r') as f:
        json_data = json.load(f)
    check_schema(json_data, mysql_table, mysql_user, mysql_password, host, database)
    transfer_json_to_mysql(json_path, mysql_url, mysql_table, mysql_user, mysql_password, mysql_connector_path)
