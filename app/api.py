from flask import Flask, request, jsonify
from app.recommender import get_recommendation
from app.database import log_request, get_restaurants

app = Flask(__name__)
@app.route('/health')
def health():
    return "Healthy", 200
@app.route('/recommend', methods=['GET'])
def recommend():
    # Extract query parameters
    style = request.args.get('style')
    vegetarian = request.args.get('vegetarian')
    current_time = request.args.get('time')
    
    # Fetch restaurant data
    restaurants = get_restaurants()
    
    # Get a recommendation
    recommendation = get_recommendation(restaurants, style, vegetarian, current_time)
    
    if not recommendation:
        return jsonify({"error": "No matching restaurant found"}), 404
    
    # Log the request and response
    log_request(request.args.to_dict(), recommendation)
    
    return jsonify({"restaurantRecommendation": recommendation}), 200

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
