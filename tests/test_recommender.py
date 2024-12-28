import pytest
from app.recommender import get_recommendation, is_open

def test_is_open():
    restaurant = {"openHour": "10:00", "closeHour": "22:00"}
    assert is_open(restaurant, "12:00") == True
    assert is_open(restaurant, "09:00") == False
    assert is_open(restaurant, "23:00") == False

def test_get_recommendation():
    restaurants = [
        {
            "name": "Pizza Palace",
            "style": "Italian",
            "address": "123 Main St",
            "openHour": "10:00",
            "closeHour": "22:00",
            "vegetarian": True,
        },
        {
            "name": "Sushi World",
            "style": "Japanese",
            "address": "456 Ocean Ave",
            "openHour": "11:00",
            "closeHour": "21:00",
            "vegetarian": False,
        },
    ]
    recommendation = get_recommendation(restaurants, style="Italian", vegetarian="true", current_time="12:00")
    assert recommendation["name"] == "Pizza Palace"

    recommendation = get_recommendation(restaurants, style="Japanese", vegetarian="false", current_time="12:00")
    assert recommendation["name"] == "Sushi World"

    recommendation = get_recommendation(restaurants, style="Italian", vegetarian="false", current_time="23:00")
    assert recommendation is None
