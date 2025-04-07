import 'package:equatable/equatable.dart';

class GetGeoDirectCityModel extends Equatable {
  final String query;
  final int limit;

  const GetGeoDirectCityModel({required this.query, required this.limit});

  GetGeoDirectCityModel copyWith({String? query, int? limit}) {
    return GetGeoDirectCityModel(
      query: query ?? this.query,
      limit: limit ?? this.limit,
    );
  }

  @override
  String toString() => 'GeoDirectModel(query: $query, limit: $limit)';

  @override
  List<Object?> get props => [query, limit];
}
