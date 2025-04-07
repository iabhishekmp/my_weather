import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_weather/src/core/api/api_helper.dart';
import 'package:my_weather/src/core/api/api_urls.dart';
import 'package:my_weather/src/features/weather/data/datasources/weather_datasource.dart';
import 'package:my_weather/src/features/weather/data/models/get_weather_model.dart';
import 'package:my_weather/src/features/weather/domain/entities/forecast_entity.dart';
import 'package:my_weather/src/features/weather/domain/entities/weather_entity.dart';

import 'weather_datasource_test.mocks.dart';

@GenerateMocks([ApiHelper])
void main() {
  late WeatherDatasourceImpl datasource;
  late MockApiHelper mockApiHelper;

  setUp(() {
    mockApiHelper = MockApiHelper();
    datasource = WeatherDatasourceImpl(mockApiHelper);
  });

  group('getCurrentWeather', () {
    const testModel = GetWeatherModel(lat: 12.34, lon: 56.78, units: 'metric');
    final testResponse = {'temp': 25.0, 'humidity': 80};
    final testWeatherEntity = WeatherEntity.fromJson(testResponse);

    test('should return WeatherEntity when API call is successful', () async {
      // Arrange
      when(
        mockApiHelper.execute(
          method: Method.get,
          url: ApiUrls.currentWeather,
          queryParameters: {
            'lat': testModel.lat,
            'lon': testModel.lon,
            'units': testModel.units,
          },
        ),
      ).thenAnswer((_) async => testResponse);

      // Act
      final result = await datasource.getCurrentWeather(testModel);

      // Assert
      expect(result, equals(testWeatherEntity));
      verify(
        mockApiHelper.execute(
          method: Method.get,
          url: ApiUrls.currentWeather,
          queryParameters: {
            'lat': testModel.lat,
            'lon': testModel.lon,
            'units': testModel.units,
          },
        ),
      ).called(1);
    });

    test('should throw an exception when API call fails', () async {
      // Arrange
      when(
        mockApiHelper.execute(
          method: Method.get,
          url: ApiUrls.currentWeather,
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenThrow(Exception('API error'));

      // Act & Assert
      expect(() => datasource.getCurrentWeather(testModel), throwsException);
      verify(
        mockApiHelper.execute(
          method: Method.get,
          url: ApiUrls.currentWeather,
          queryParameters: {
            'lat': testModel.lat,
            'lon': testModel.lon,
            'units': testModel.units,
          },
        ),
      ).called(1);
    });
  });

  group('getForecast', () {
    const testModel = GetWeatherModel(lat: 12.34, lon: 56.78, units: 'metric');
    final testResponse = {
      'list': [
        {'dt': 1743832800},
        {'dt': 1743843600},
      ],
    };
    final testForecastEntity = ForecastEntity.fromJson(testResponse);

    test('should return ForecastEntity when API call is successful', () async {
      // Arrange
      when(
        mockApiHelper.execute(
          method: Method.get,
          url: ApiUrls.forecast,
          queryParameters: {
            'lat': testModel.lat,
            'lon': testModel.lon,
            'units': testModel.units,
          },
        ),
      ).thenAnswer((_) async => testResponse);

      // Act
      final result = await datasource.getForecast(testModel);

      // Assert
      expect(result, equals(testForecastEntity));
      verify(
        mockApiHelper.execute(
          method: Method.get,
          url: ApiUrls.forecast,
          queryParameters: {
            'lat': testModel.lat,
            'lon': testModel.lon,
            'units': testModel.units,
          },
        ),
      ).called(1);
    });

    test('should throw an exception when API call fails', () async {
      // Arrange
      when(
        mockApiHelper.execute(
          method: Method.get,
          url: ApiUrls.forecast,
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenThrow(Exception('API error'));

      // Act & Assert
      expect(() => datasource.getForecast(testModel), throwsException);
      verify(
        mockApiHelper.execute(
          method: Method.get,
          url: ApiUrls.forecast,
          queryParameters: {
            'lat': testModel.lat,
            'lon': testModel.lon,
            'units': testModel.units,
          },
        ),
      ).called(1);
    });
  });
}
