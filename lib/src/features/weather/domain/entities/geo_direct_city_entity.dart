import 'package:equatable/equatable.dart';

class GeoDirectCityEntity extends Equatable {
  final String name;
  final LocalNames? localNames;
  final double lat;
  final double lon;
  final String? country;
  final String? state;

  const GeoDirectCityEntity({
    required this.name,
    required this.lat,
    required this.lon,
    this.country,
    this.state,
    this.localNames,
  });

  GeoDirectCityEntity copyWith({
    String? name,
    LocalNames? localNames,
    double? lat,
    double? lon,
    String? country,
    String? state,
  }) => GeoDirectCityEntity(
    name: name ?? this.name,
    localNames: localNames ?? this.localNames,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    country: country ?? this.country,
    state: state ?? this.state,
  );

  factory GeoDirectCityEntity.fromJson(Map<String, dynamic> json) =>
      GeoDirectCityEntity(
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
