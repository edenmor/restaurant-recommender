from datetime import datetime

def is_open(restaurant, current_time):
    open_time = datetime.strptime(restaurant['openHour'], "%H:%M").time()
    close_time = datetime.strptime(restaurant['closeHour'], "%H:%M").time()
    current = datetime.strptime(current_time, "%H:%M").time()
    return open_time <= current <= close_time

def get_recommendation(restaurants, style=None, vegetarian=None, current_time=None):
    print(f"Filtering for style={style}, vegetarian={vegetarian}, current_time={current_time}")
    print("All restaurants:", restaurants)

    # Filter restaurants by criteria
    filtered = [
        r for r in restaurants
        if (not style or r['style'].lower() == style.lower())
        and (not vegetarian or str(r['vegetarian']).lower() == vegetarian.lower())
        and (not current_time or is_open(r, current_time))
    ]

    print("Filtered restaurants:", filtered)
    return filtered[0] if filtered else None

