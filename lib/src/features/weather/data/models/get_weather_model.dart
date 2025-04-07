import 'package:equatable/equatable.dart';

class GetWeatherModel extends Equatable {
  const GetWeatherModel({
    required this.lat,
    required this.lon,
    required this.units,
  });
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

  @override
  String toString() => 'GetWeatherModel(lat: $lat, lon: $lon, units: $units)';

  @override
  List<Object?> get props => [lat, lon, units];
}
