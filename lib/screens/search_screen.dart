import 'package:flutter/material.dart';
import '../services/location_service.dart';
import '../services/cache_service.dart';
import '../models/location.dart';

class LocationSearchScreen extends StatefulWidget {
  const LocationSearchScreen({super.key});

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final _locationService = LocationService();
  final _locationCache = LocationCache();
  final _controller = TextEditingController();

  String? _result;
  bool _isLoading = false;

  Future<void> _searchLocation(String address) async {
    setState(() {
      _isLoading = true;
      _result = null;
    });

    final cachedLocation = await _locationCache.getLocation(address);
    if (cachedLocation != null) {
      setState(() {
        _result =
            'Cached: ${cachedLocation.address} (${cachedLocation.latitude}, ${cachedLocation.longitude})';
        _isLoading = false;
      });
      return;
    }

    try {
      final locationData = await _locationService.fetchCoordinates(address);
      final location = Location(
        address: address,
        latitude: locationData['lat'],
        longitude: locationData['lng'],
      );
      await _locationCache.saveLocation(location);

      setState(() {
        _result =
            'API: ${location.address} (${location.latitude}, ${location.longitude})';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _result = 'Error fetching location. Please enter a valid location and check your network connection.';
        _isLoading = false;
      });
    }
  }

  void _clearInput() {
    setState(() {
      _controller.clear();
      _result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Search'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter address',
                labelStyle: const TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _clearInput,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _controller.text.trim().isEmpty
                    ? null
                    : () => _searchLocation(_controller.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Search Location',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (_result != null)
              Card(
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _result!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }
}
