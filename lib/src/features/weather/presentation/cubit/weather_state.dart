part of 'weather_cubit.dart';

final class WeatherState extends Equatable {
  final WeatherEntity? weather;
  final ForecastEntity? forecast;
  final bool isLoading;
  final String? error;

  const WeatherState({
    required this.isLoading,
    this.weather,
    this.forecast,
    this.error,
  });

  WeatherState copyWith({
    WeatherEntity? weather,
    ForecastEntity? forecast,
    bool? isLoading,
    String? error,
  }) {
    return WeatherState(
      weather: weather ?? this.weather,
      forecast: forecast ?? this.forecast,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
    weather ?? '',
    forecast ?? '',
    isLoading,
    error ?? '',
  ];

  @override
  bool get stringify => true;
}
