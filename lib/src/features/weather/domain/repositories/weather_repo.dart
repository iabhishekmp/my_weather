import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/weather_entity.dart';
import '../usecases/usecase_params.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
    GetCurrentWeatherParams params,
  );
}
