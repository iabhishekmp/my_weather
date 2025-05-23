import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_weather/src/core/errors/failures.dart';
import 'package:my_weather/src/core/services/location_services.dart';
import 'package:my_weather/src/features/weather/domain/entities/forecast_entity.dart';
import 'package:my_weather/src/features/weather/domain/entities/weather_entity.dart';
import 'package:my_weather/src/features/weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:my_weather/src/features/weather/domain/usecases/get_forecast_usecase.dart';
import 'package:my_weather/src/features/weather/presentation/cubit/weather/weather_cubit.dart';

import 'weather_cubit_test.mocks.dart';

@GenerateMocks([GetCurrentWeatherUsecase, LocationServices, GetForecastUseCase])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late WeatherCubit weatherCubit;
  late MockGetCurrentWeatherUsecase mockGetCurrentWeatherUsecase;
  late MockLocationServices mockLocationServices;
  late MockGetForecastUseCase mockGetForecastUseCase;

  setUp(() {
    mockGetCurrentWeatherUsecase = MockGetCurrentWeatherUsecase();
    mockGetForecastUseCase = MockGetForecastUseCase();
    mockLocationServices = MockLocationServices();

    weatherCubit = WeatherCubit(
      mockGetCurrentWeatherUsecase,
      mockGetForecastUseCase,
      mockLocationServices,
    );
  });

  const tWeatherEntity = WeatherEntity(name: 'Surat');
  const tForecastEntity = ForecastEntity(message: 200);
  final tPosition = Position(
    latitude: 12.34,
    longitude: 56.78,
    timestamp: DateTime.now(),
    accuracy: 50,
    altitude: 100,
    altitudeAccuracy: 50,
    heading: 0,
    headingAccuracy: 50,
    speed: 10,
    speedAccuracy: 50,
  );

  tearDown(() {
    weatherCubit.close();
  });

  test('initial state is WeatherInitial', () {
    expect(weatherCubit.state, const WeatherState(isLoading: false));
  });

  blocTest<WeatherCubit, WeatherState>(
    '''emits [WeatherLoading, WeatherLoaded] when weather data is fetched successfully''',
    build: () {
      when(
        mockLocationServices.getCurrentLocation(),
      ).thenAnswer((_) async => Right<String, Position>(tPosition));
      when(
        mockGetCurrentWeatherUsecase(any),
      ).thenAnswer((_) async => const Right(tWeatherEntity));
      return weatherCubit;
    },
    act: (cubit) => cubit.fetchWeather(units: 'metric'),
    expect:
        () => [
          const WeatherState(isLoading: true),
          const WeatherState(isLoading: false, weather: tWeatherEntity),
        ],
  );

  blocTest<WeatherCubit, WeatherState>(
    'emits [WeatherLoading, WeatherError] when location fetching fails',
    build: () {
      when(
        mockLocationServices.getCurrentLocation(),
      ).thenAnswer((_) async => const Left('Location services are disabled.'));
      return weatherCubit;
    },
    act: (cubit) => cubit.fetchWeather(units: 'metric'),
    expect:
        () => [
          const WeatherState(isLoading: true),
          const WeatherState(
            isLoading: false,
            error: 'Location services are disabled.',
          ),
        ],
  );

  blocTest<WeatherCubit, WeatherState>(
    'emits [WeatherLoading, WeatherError] when weather fetching fails',
    build: () {
      when(
        mockLocationServices.getCurrentLocation(),
      ).thenAnswer((_) async => Right(tPosition));
      when(
        mockGetCurrentWeatherUsecase(any),
      ).thenAnswer((_) async => Left(ServerFailure(message: 'Test Failure')));
      return weatherCubit;
    },
    act: (cubit) => cubit.fetchWeather(units: 'metric'),
    expect:
        () => [
          const WeatherState(isLoading: true),
          const WeatherState(
            isLoading: false,
            error: 'Server Failure: Test Failure',
          ),
        ],
  );

  blocTest<WeatherCubit, WeatherState>(
    '''emits [WeatherForecastLoading, WeatherForecastLoaded] when forecast data is fetched successfully''',
    build: () {
      when(
        mockLocationServices.getCurrentLocation(),
      ).thenAnswer((_) async => Right<String, Position>(tPosition));
      when(
        mockGetForecastUseCase(any),
      ).thenAnswer((_) async => const Right(tForecastEntity));
      return weatherCubit;
    },
    act: (cubit) => cubit.fetchForecast(units: 'metric'),
    expect:
        () => [
          const WeatherState(isLoading: true),
          const WeatherState(isLoading: false, forecast: tForecastEntity),
        ],
  );

  blocTest<WeatherCubit, WeatherState>(
    '''emits [WeatherForecastLoading, WeatherForecastError] when forecast fetching fails''',
    build: () {
      when(
        mockLocationServices.getCurrentLocation(),
      ).thenAnswer((_) async => Right(tPosition));
      when(
        mockGetForecastUseCase(any),
      ).thenAnswer((_) async => Left(ServerFailure(message: 'Test Failure')));
      return weatherCubit;
    },
    act: (cubit) => cubit.fetchForecast(units: 'metric'),
    expect:
        () => [
          const WeatherState(isLoading: true),
          const WeatherState(
            isLoading: false,
            error: 'Server Failure: Test Failure',
          ),
        ],
  );

  blocTest<WeatherCubit, WeatherState>(
    '''emits [WeatherForecastLoading, WeatherForecastError] when location fetching fails''',
    build: () {
      when(
        mockLocationServices.getCurrentLocation(),
      ).thenAnswer((_) async => const Left('Location services are disabled.'));
      return weatherCubit;
    },
    act: (cubit) => cubit.fetchForecast(units: 'metric'),
    expect:
        () => [
          const WeatherState(isLoading: true),
          const WeatherState(
            isLoading: false,
            error: 'Location services are disabled.',
          ),
        ],
  );
}
