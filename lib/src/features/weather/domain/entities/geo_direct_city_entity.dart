import 'package:equatable/equatable.dart';

class GeoDirectCity extends Equatable {
  final String name;
  final LocalNames? localNames;
  final double lat;
  final double lon;
  final String country;
  final String state;

  const GeoDirectCity({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
    this.localNames,
  });

  GeoDirectCity copyWith({
    String? name,
    LocalNames? localNames,
    double? lat,
    double? lon,
    String? country,
    String? state,
  }) => GeoDirectCity(
    name: name ?? this.name,
    localNames: localNames ?? this.localNames,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    country: country ?? this.country,
    state: state ?? this.state,
  );

  factory GeoDirectCity.fromJson(Map<String, dynamic> json) => GeoDirectCity(
    name: json['name'],
    localNames:
        json['local_names'] == null
            ? null
            : LocalNames.fromJson(json['local_names']),
    lat: json['lat']?.toDouble(),
    lon: json['lon']?.toDouble(),
    country: json['country'],
    state: json['state'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'local_names': localNames?.toJson(),
    'lat': lat,
    'lon': lon,
    'country': country,
    'state': state,
  };

  @override
  List<Object?> get props => [name, localNames, lat, lon, country, state];
}

class LocalNames {
  final String? fr;
  final String? uk;
  final String? bn;
  final String? en;

  LocalNames({this.fr, this.uk, this.bn, this.en});

  LocalNames copyWith({String? fr, String? uk, String? bn, String? en}) =>
      LocalNames(
        fr: fr ?? this.fr,
        uk: uk ?? this.uk,
        bn: bn ?? this.bn,
        en: en ?? this.en,
      );

  factory LocalNames.fromJson(Map<String, dynamic> json) => LocalNames(
    fr: json['fr'],
    uk: json['uk'],
    bn: json['bn'],
    en: json['en'],
  );

  Map<String, dynamic> toJson() => {'fr': fr, 'uk': uk, 'bn': bn, 'en': en};
}
