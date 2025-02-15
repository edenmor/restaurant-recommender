import uuid
from azure.data.tables import TableServiceClient
import os
import json

# Setup Azure Storage
STORAGE_ACCOUNT_NAME = os.getenv("STORAGE_ACCOUNT_NAME")
STORAGE_ACCOUNT_KEY = os.getenv("STORAGE_ACCOUNT_KEY")
RESTAURANTS_TABLE = os.getenv("RESTAURANTS_TABLE_NAME", "restaurants")
LOGS_TABLE = os.getenv("LOGS_TABLE_NAME", "requestlogs")

connection_string = f"DefaultEndpointsProtocol=https;AccountName={STORAGE_ACCOUNT_NAME};AccountKey={STORAGE_ACCOUNT_KEY};EndpointSuffix=core.windows.net"
table_service = TableServiceClient.from_connection_string(
    conn_str=connection_string)

restaurants_table = table_service.get_table_client(RESTAURANTS_TABLE)
logs_table = table_service.get_table_client(LOGS_TABLE)


def get_restaurants():
    return [entity for entity in restaurants_table.query_entities("PartitionKey eq 'restaurant'")]


def log_request(request, response):
    try:
        logs_table.create_entity({
            "PartitionKey": "log",
            "RowKey": str(uuid.uuid4()),  # Use a UUID for unique RowKey
            "request": str(request),
            "response": str(response)
        })
    except Exception as e:
        print(f"Error logging request: {e}")


def insert_restaurants(restaurant):
    try:
        restaurants_table.create_entity(restaurant)
        return "Sample data populated successfully."
    except Exception as e:
        return f"Error populating sample data: {e}"
