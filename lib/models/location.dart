class Location {
  final String address;
  final double latitude;
  final double longitude;

  Location({required this.address, required this.latitude, required this.longitude});

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      address: map['address'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
