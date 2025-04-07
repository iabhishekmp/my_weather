part of 'weather_cubit.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final WeatherEntity weather;

  const WeatherLoaded(this.weather);

  @override
  List<Object> get props => [weather];
}

final class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}

final class WeatherForecastLoading extends WeatherState {}

final class WeatherForecastLoaded extends WeatherState {
  final ForecastEntity forecast;

  const WeatherForecastLoaded(this.forecast);

  @override
  List<Object> get props => [forecast];
}

final class WeatherForecastError extends WeatherState {
  final String message;

  const WeatherForecastError(this.message);

  @override
  List<Object> get props => [message];
}
