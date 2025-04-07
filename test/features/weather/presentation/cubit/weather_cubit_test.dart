import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_weather/src/core/errors/failures.dart';
import 'package:my_weather/src/core/services/location_services.dart';
import 'package:my_weather/src/features/weather/domain/entities/weather_entity.dart';
import 'package:my_weather/src/features/weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:my_weather/src/features/weather/presentation/cubit/weather_cubit.dart';

import 'weather_cubit_test.mocks.dart';

@GenerateMocks([GetCurrentWeatherUsecase, LocationServices])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late WeatherCubit weatherCubit;
  late MockGetCurrentWeatherUsecase mockGetCurrentWeatherUsecase;
  late MockLocationServices mockLocationServices;

  setUp(() {
    mockGetCurrentWeatherUsecase = MockGetCurrentWeatherUsecase();
    mockLocationServices = MockLocationServices();
    weatherCubit = WeatherCubit(
      mockGetCurrentWeatherUsecase,
      mockLocationServices,
    );
  });

  const tWeatherEntity = WeatherEntity(name: 'Surat');
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
    expect(weatherCubit.state, WeatherInitial());
  });

  blocTest<WeatherCubit, WeatherState>(
    'emits [WeatherLoading, WeatherLoaded] when weather data is fetched successfully',
    build: () {
      when(
        mockLocationServices.getCurrentLocation(),
      ).thenAnswer((_) async => Right<String, Position>(tPosition));
      when(
        mockGetCurrentWeatherUsecase(any),
      ).thenAnswer((_) async => const Right(tWeatherEntity));
      return weatherCubit;
    },
    act: (cubit) => cubit.getCurrentWeather(units: 'metric'),
    expect: () => [WeatherLoading(), const WeatherLoaded(tWeatherEntity)],
  );

  blocTest<WeatherCubit, WeatherState>(
    'emits [WeatherLoading, WeatherError] when location fetching fails',
    build: () {
      when(
        mockLocationServices.getCurrentLocation(),
      ).thenAnswer((_) async => const Left('Location services are disabled.'));
      return weatherCubit;
    },
    act: (cubit) => cubit.getCurrentWeather(units: 'metric'),
    expect:
        () => [
          WeatherLoading(),
          const WeatherError('Location services are disabled.'),
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
    act: (cubit) => cubit.getCurrentWeather(units: 'metric'),
    expect:
        () => [
          WeatherLoading(),
          const WeatherError('Server Failure: Test Failure'),
        ],
  );
}
