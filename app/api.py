from flask import Flask, request, jsonify
from recommender import get_recommendation
from database import log_request, get_restaurants, insert_restaurants #, update_restaurants
import json

app = Flask(__name__)


@app.route('/health')
def health():
    return "Healthy", 200
@app.route('/test')
def health():
    return "test ok!", 200


@app.route('/insert', methods=['POST'])
def insert_restaurants_api():
    restaurant = request.data.decode("utf-8")
    return insert_restaurants(json.loads(restaurant)), 200


# @app.route('/update', methods=['POST'])
# def insert_restaurants_api():
#     restaurant = request.data.decode("utf-8")
#     return update_restaurants(json.loads(restaurant)), 200


@app.route('/recommend', methods=['GET'])
def recommend():

    style = request.args.get('style')
    vegetarian = request.args.get('vegetarian')
    current_time = request.args.get('time')

    restaurants = get_restaurants()


    recommendation = get_recommendation(
        restaurants, style, vegetarian, current_time)

    if not recommendation:
        return jsonify({"error": "No matching restaurant found"}), 404

    log_request(request.args.to_dict(), recommendation)

    return jsonify({"restaurantRecommendation": recommendation}), 200


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
