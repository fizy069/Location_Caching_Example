import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../lib/services/cache_service.dart';
import '../lib/models/location.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('Cache and retrieve location', () async {
    final cache = LocationCache();
    final location = Location(
      address: 'Test Address',
      latitude: 12.34,
      longitude: 56.78,
    );

    await cache.saveLocation(location);

    final retrievedLocation = await cache.getLocation('Test Address');

    expect(retrievedLocation, isNotNull);
    expect(retrievedLocation?.address, equals('Test Address'));
    expect(retrievedLocation?.latitude, equals(12.34));
    expect(retrievedLocation?.longitude, equals(56.78));
  });
}
