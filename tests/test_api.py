# import pytest
# from app.api import app
# from unittest.mock import patch

# @pytest.fixture
# def client():
#     app.config["TESTING"] = True
#     with app.test_client() as client:
#         yield client

# @patch("app.database.get_restaurants")
# @patch("app.database.log_request")
# def test_recommend_endpoint(mock_log_request, mock_get_restaurants, client):
#     mock_get_restaurants.return_value = [
#         {
#             "PartitionKey": "restaurant",
#             "RowKey": "pizza-palace",
#             "name": "Pizza Palace",
#             "style": "Italian",
#             "address": "123 Main St",
#             "openHour": "10:00",
#             "closeHour": "22:00",
#             "vegetarian": True,
#         }
#     ]

#     response = client.get("/recommend?style=Italian&vegetarian=true&time=12:00")
#     assert response.status_code == 200
#     data = response.get_json()
#     assert "restaurantRecommendation" in data
#     assert data["restaurantRecommendation"]["name"] == "Pizza Palace"
#     mock_log_request.assert_called_once()

# @patch("app.database.get_restaurants")
# def test_recommend_not_found(mock_get_restaurants, client):
#     mock_get_restaurants.return_value = []

#     response = client.get("/recommend?style=Mexican&vegetarian=true&time=12:00")
#     assert response.status_code == 404
#     data = response.get_json()
#     assert "error" in data
