import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_weather/src/core/errors/failures.dart';
import 'package:my_weather/src/features/weather/domain/entities/weather_entity.dart';
import 'package:my_weather/src/features/weather/domain/repositories/weather_repo.dart';
import 'package:my_weather/src/features/weather/domain/usecases/get_current_weather_usecase.dart';

import 'get_current_weather_usecase_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late GetCurrentWeatherUsecase usecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetCurrentWeatherUsecase(mockWeatherRepository);
  });

  const tLat = 37.7749;
  const tLon = -122.4194;
  const tUnits = 'metric';
  const tParams = Params(lat: tLat, lon: tLon, units: tUnits);
  const tWeatherEntity = WeatherEntity(name: 'Surat');

  test('should get current weather from the repository', () async {
    // Arrange
    when(
      mockWeatherRepository.getCurrentWeather(tParams),
    ).thenAnswer((_) async => const Right(tWeatherEntity));

    // Act
    final result = await usecase(tParams);

    // Assert
    expect(result, const Right<Failure, WeatherEntity>(tWeatherEntity));
    verify(mockWeatherRepository.getCurrentWeather(tParams));
    verifyNoMoreInteractions(mockWeatherRepository);
  });

  test('should return failure when repository fails', () async {
    // Arrange
    when(
      mockWeatherRepository.getCurrentWeather(tParams),
    ).thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await usecase(tParams);

    // Assert
    expect(result, Left<Failure, WeatherEntity>(ServerFailure()));
    verify(mockWeatherRepository.getCurrentWeather(tParams));
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
