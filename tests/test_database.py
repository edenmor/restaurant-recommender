import pytest
from app.database import get_restaurants, log_request
from unittest.mock import MagicMock

# Mock the Azure Table Client
mock_table_service = MagicMock()

def test_get_restaurants(monkeypatch):
    mock_table_service.query_entities.return_value = [
        {
            "PartitionKey": "restaurant",
            "RowKey": "pizza-palace",
            "name": "Pizza Palace",
            "style": "Italian",
            "address": "123 Main St",
            "openHour": "10:00",
            "closeHour": "22:00",
            "vegetarian": True,
        }
    ]
    monkeypatch.setattr("app.database.restaurants_table", mock_table_service)

    restaurants = get_restaurants()
    assert len(restaurants) == 1
    assert restaurants[0]["name"] == "Pizza Palace"

def test_log_request(monkeypatch):
    mock_table_service.create_entity.return_value = None
    monkeypatch.setattr("app.database.logs_table", mock_table_service)

    log_request({"style": "Italian"}, {"name": "Pizza Palace"})
    mock_table_service.create_entity.assert_called_once()
