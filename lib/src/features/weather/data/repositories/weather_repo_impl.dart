import 'package:dartz/dartz.dart';

import '../../../../core/api/api_exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_repo.dart';
import '../../domain/usecases/usecase_params.dart';
import '../datasources/weather_datasource.dart';
import '../models/get_weather_model.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherDatasource _datasource;

  WeatherRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
    GetCurrentWeatherParams params,
  ) async {
    try {
      final model = GetWeatherModel(
        lat: params.lat,
        lon: params.lon,
        units: params.units,
      );
      final res = await _datasource.getCurrentWeather(model);
      return Right(res);
    } on TooManyRequestsException {
      return Left(TooManyRequestsFailure());
    } on Exception catch (_) {
      return Left(ServerFailure());
    } catch (_) {
      return Left(SomethingWrong());
    }
  }
}
