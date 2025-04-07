part of 'geo_city_cubit.dart';

class GeoCityState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<GeoDirectCityEntity>? cities;
  final bool hasSearched;

  const GeoCityState({
    required this.isLoading,
    this.error,
    this.cities,
    this.hasSearched = false,
  });

  @override
  List<Object> get props => [isLoading, error ?? '', cities ?? [], hasSearched];

  @override
  bool get stringify => true;

  GeoCityState copyWith({
    bool? isLoading,
    String? error,
    List<GeoDirectCityEntity>? cities,
    bool? hasSearched,
  }) {
    return GeoCityState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      cities: cities ?? this.cities,
      hasSearched: hasSearched ?? this.hasSearched,
    );
  }
}
