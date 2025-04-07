import '../../../../core/api/api_helper.dart';
import '../../../../core/api/api_urls.dart';
import '../../domain/entities/forecast_entity.dart';
import '../../domain/entities/weather_entity.dart';
import '../models/get_weather_model.dart';

sealed class WeatherDatasource {
  Future<WeatherEntity> getCurrentWeather(GetWeatherModel model);
  Future<ForecastEntity> getForecast(GetWeatherModel model);
}

class WeatherDatasourceImpl implements WeatherDatasource {
  final ApiHelper _apiHelper;

  WeatherDatasourceImpl(this._apiHelper);

  @override
  Future<WeatherEntity> getCurrentWeather(GetWeatherModel model) async {
    final res = await _apiHelper.execute(
      method: Method.get,
      url: ApiUrls.currentWeather,
      queryParameters: {
        'lat': model.lat,
        'lon': model.lon,
        'units': model.units,
      },
    );
    return WeatherEntity.fromJson(res);
  }

  @override
  Future<ForecastEntity> getForecast(GetWeatherModel model) async {
    final res = await _apiHelper.execute(
      method: Method.get,
      url: ApiUrls.forecast,
      queryParameters: {
        'lat': model.lat,
        'lon': model.lon,
        'units': model.units,
      },
    );
    return ForecastEntity.fromJson(res);
  }
}
