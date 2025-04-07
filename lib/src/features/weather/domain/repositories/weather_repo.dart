import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/forecast_entity.dart';
import '../entities/geo_direct_city_entity.dart';
import '../entities/weather_entity.dart';
import '../usecases/usecase_params.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
    GetCurrentWeatherParams params,
  );
  Future<Either<Failure, ForecastEntity>> getForecastWeather(
    GetCurrentWeatherParams params,
  );
  Future<Either<Failure, List<GeoDirectCityEntity>>> getCities(
    GetGeoDirectCityParams params,
  );
}
