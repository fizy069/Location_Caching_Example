# location_caching_example


---

# Location Search App

A Flutter application that allows users to search for locations by address and view their corresponding coordinates. The app optimizes API usage by caching results locally, reducing costs and improving efficiency.



---

## Features
- **Search Locations:** Enter an address to fetch its coordinates using an external API (e.g., Google Maps or similar).
- **Local Caching:** Reuse previously searched locations from local storage to minimize API calls.
- **Clean UI:** Intuitive interface with modern design elements and clear feedback mechanisms.
- **Error Handling:** Displays appropriate messages for API errors or invalid inputs.

---

## Getting Started

### Prerequisites
- Flutter 3.x or later
- Google Maps API Key (or other service API key)

### Installation
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/location-search-app.git
   cd location-search-app
   ```
2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```
3. **Add API Key:**
   - Open the `location_secrets.dart` file in `lib/secrets/`.
   - Replace the API KEY with your actual API key for the geolocation service. This can be obtained from the google cloud console.

---

## Usage
1. Run the app:
   ```bash
   flutter run
   ```
2. Enter a location in the search field and click "Search Location."
3. If the location has been searched before, it will be fetched from the local cache. Otherwise, the app will use the API to fetch the coordinates and cache the result.

---


## Optimization Techniques
1. **Local Storage with SQLite:**
   - Reduces repetitive API calls for frequently searched locations.
2. **Debouncing Input (Optional):**
   - Prevents unnecessary searches while the user is still typing.
3. **Efficient UI:**
   - Includes loading indicators and clear feedback to enhance user experience.

---

## Dependencies
- [Flutter](https://flutter.dev/)
- [sqflite](https://pub.dev/packages/sqflite) - SQLite plugin for Flutter
- [http](https://pub.dev/packages/http) - For API requests

---
