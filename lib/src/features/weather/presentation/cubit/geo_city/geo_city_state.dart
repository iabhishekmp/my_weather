part of 'geo_city_cubit.dart';

class GeoCityState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<GeoDirectCityEntity>? cities;

  const GeoCityState({required this.isLoading, this.error, this.cities});

  @override
  List<Object> get props => [isLoading, error ?? '', cities ?? []];

  @override
  bool get stringify => true;

  GeoCityState copyWith({
    bool? isLoading,
    String? error,
    List<GeoDirectCityEntity>? cities,
  }) {
    return GeoCityState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      cities: cities ?? this.cities,
    );
  }
}
