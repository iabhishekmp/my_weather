class GetWeatherModel {
  GetWeatherModel({required this.lat, required this.lon, required this.units});
  final double lat;
  final double lon;
  final String units;

  GetWeatherModel copyWith({double? lat, double? lon, String? units}) {
    return GetWeatherModel(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      units: units ?? this.units,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'lat': lat, 'lon': lon, 'units': units};
  }

  @override
  String toString() => 'GetWeatherModel(lat: $lat, lon: $lon, units: $units)';
}
