import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_weather/src/core/errors/failures.dart';
import 'package:my_weather/src/features/weather/domain/entities/forecast_entity.dart';
import 'package:my_weather/src/features/weather/domain/entities/weather_entity.dart';
import 'package:my_weather/src/features/weather/domain/repositories/weather_repo.dart';
import 'package:my_weather/src/features/weather/domain/usecases/get_forecast_usecase.dart';
import 'package:my_weather/src/features/weather/domain/usecases/usecase_params.dart';

import 'get_current_weather_usecase_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late GetForecastUseCase useCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    useCase = GetForecastUseCase(mockWeatherRepository);
  });

  const tParams = GetCurrentWeatherParams(
    lat: 12.34,
    lon: 56.78,
    units: 'metric',
  );
  const tForecastEntity = ForecastEntity(
    list: [WeatherEntity(dt: 1743832800), WeatherEntity(dt: 1743843600)],
  );

  test(
    'should return ForecastEntity when the call to repository is successful',
    () async {
      // Arrange
      when(
        mockWeatherRepository.getForecastWeather(tParams),
      ).thenAnswer((_) async => const Right(tForecastEntity));

      // Act
      final result = await useCase(tParams);

      // Assert
      expect(result, const Right<Failure, ForecastEntity>(tForecastEntity));
      verify(mockWeatherRepository.getForecastWeather(tParams));
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );

  test('should return Failure when the call to repository fails', () async {
    // Arrange
    when(
      mockWeatherRepository.getForecastWeather(tParams),
    ).thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await useCase(tParams);

    // Assert
    expect(result, Left<Failure, ForecastEntity>(ServerFailure()));
    verify(mockWeatherRepository.getForecastWeather(tParams));
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
