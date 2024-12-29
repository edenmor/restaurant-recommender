from azure.data.tables import TableServiceClient
import os
import json

STORAGE_ACCOUNT_NAME = os.getenv("STORAGE_ACCOUNT_NAME")
STORAGE_ACCOUNT_KEY = os.getenv("STORAGE_ACCOUNT_KEY")
RESTAURANTS_TABLE = os.getenv("RESTAURANTS_TABLE_NAME", "restaurants")
LOGS_TABLE = os.getenv("LOGS_TABLE_NAME", "requestlogs")

connection_string = f"DefaultEndpointsProtocol=https;AccountName={STORAGE_ACCOUNT_NAME};AccountKey={STORAGE_ACCOUNT_KEY};EndpointSuffix=core.windows.net"
table_service = TableServiceClient.from_connection_string(
    conn_str=connection_string)

restaurants_table = table_service.get_table_client(RESTAURANTS_TABLE)
logs_table = table_service.get_table_client(LOGS_TABLE)


def populate_sample_data():
    with open('restaurant.json', "r") as file:
        content = file.read()
    jres = json.loads(content)

    for restaurant in jres:
        try:
            restaurants_table.create_entity(restaurant)
            print("Sample data populated successfully.")
        except Exception as e:
            print(f"Error populating sample data: {e}")