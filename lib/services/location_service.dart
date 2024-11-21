import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location_caching_example/secrets/location_secrets.dart';

class LocationService {
  final String apiKey = LocationSecrets.MAPS_API_KEY;
  // LocationService(this.apiKey);
  Future<Map<String, dynamic>> fetchCoordinates(String address) async {
    
  print('apiKey: $apiKey');
    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey');
    final response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        final location = data['results'][0]['geometry']['location'];
        return {
          'lat': location['lat'],
          'lng': location['lng'],
          'address': address,
        };
      }
    }
    throw Exception('Failed to fetch location.');
  }
}
