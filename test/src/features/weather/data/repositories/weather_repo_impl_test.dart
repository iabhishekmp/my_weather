import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_weather/src/core/api/api_exceptions.dart';
import 'package:my_weather/src/core/errors/failures.dart';
import 'package:my_weather/src/features/weather/data/datasources/weather_datasource.dart';
import 'package:my_weather/src/features/weather/data/models/get_weather_model.dart';
import 'package:my_weather/src/features/weather/data/repositories/weather_repo_impl.dart';
import 'package:my_weather/src/features/weather/domain/entities/forecast_entity.dart';
import 'package:my_weather/src/features/weather/domain/entities/weather_entity.dart';
import 'package:my_weather/src/features/weather/domain/usecases/usecase_params.dart';

import 'weather_repo_impl_test.mocks.dart';

@GenerateMocks([WeatherDatasourceImpl])
void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherDatasourceImpl mockDataSource;

  setUp(() {
    mockDataSource = MockWeatherDatasourceImpl();
    repository = WeatherRepositoryImpl(mockDataSource);
  });

  const tParams = GetCurrentWeatherParams(
    lat: 37.7749,
    lon: -122.4194,
    units: 'metric',
  );
  const tWeatherEntity = WeatherEntity(name: 'Surat');
  const tForecastEntity = ForecastEntity(
    list: [WeatherEntity(dt: 1743832800), WeatherEntity(dt: 1743843600)],
  );

  group('getCurrentWeather', () {
    test(
      'should return WeatherEntity when the call to data source is successful',
      () async {
        // arrange
        final tModel = GetWeatherModel(
          lat: tParams.lat,
          lon: tParams.lon,
          units: tParams.units,
        );
        when(
          mockDataSource.getCurrentWeather(tModel),
        ).thenAnswer((_) async => tWeatherEntity);

        // act
        final result = await repository.getCurrentWeather(tParams);

        // assert
        expect(result, const Right<Failure, WeatherEntity>(tWeatherEntity));
        verify(mockDataSource.getCurrentWeather(tModel));
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      '''should return TooManyRequestsFailure when data source throws TooManyRequestsException''',
      () async {
        // arrange
        final tModel = GetWeatherModel(
          lat: tParams.lat,
          lon: tParams.lon,
          units: tParams.units,
        );
        when(
          mockDataSource.getCurrentWeather(tModel),
        ).thenThrow(TooManyRequestsException('Too many requests'));

        // act
        final result = await repository.getCurrentWeather(tParams);

        // assert
        expect(result, Left<Failure, WeatherEntity>(TooManyRequestsFailure()));
        verify(mockDataSource.getCurrentWeather(tModel));
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      '''should return ServerFailure when data source throws an unknown exception''',
      () async {
        // arrange
        final tModel = GetWeatherModel(
          lat: tParams.lat,
          lon: tParams.lon,
          units: tParams.units,
        );
        when(mockDataSource.getCurrentWeather(tModel)).thenThrow(Exception());

        // act
        final result = await repository.getCurrentWeather(tParams);

        // assert
        expect(
          result,
          Left<Failure, WeatherEntity>(ServerFailure(message: 'Exception')),
        );
        verify(mockDataSource.getCurrentWeather(tModel));
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });

  group('getForecastWeather', () {
    test(
      'should return ForecastEntity when the call to data source is successful',
      () async {
        // arrange
        final tModel = GetWeatherModel(
          lat: tParams.lat,
          lon: tParams.lon,
          units: tParams.units,
        );
        when(
          mockDataSource.getForecast(tModel),
        ).thenAnswer((_) async => tForecastEntity);

        // act
        final result = await repository.getForecastWeather(tParams);

        // assert
        expect(result, const Right<Failure, ForecastEntity>(tForecastEntity));
        verify(mockDataSource.getForecast(tModel));
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      '''should return TooManyRequestsFailure when data source throws TooManyRequestsException''',
      () async {
        // arrange
        final tModel = GetWeatherModel(
          lat: tParams.lat,
          lon: tParams.lon,
          units: tParams.units,
        );
        when(
          mockDataSource.getForecast(tModel),
        ).thenThrow(TooManyRequestsException('Too many requests'));

        // act
        final result = await repository.getForecastWeather(tParams);

        // assert
        expect(result, Left<Failure, ForecastEntity>(TooManyRequestsFailure()));
        verify(mockDataSource.getForecast(tModel));
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      '''should return ServerFailure when data source throws an unknown exception''',
      () async {
        // arrange
        final tModel = GetWeatherModel(
          lat: tParams.lat,
          lon: tParams.lon,
          units: tParams.units,
        );
        when(mockDataSource.getForecast(tModel)).thenThrow(Exception());

        // act
        final result = await repository.getForecastWeather(tParams);

        // assert
        expect(
          result,
          Left<Failure, ForecastEntity>(ServerFailure(message: 'Exception')),
        );
        verify(mockDataSource.getForecast(tModel));
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });
}
