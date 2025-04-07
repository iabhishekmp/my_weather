import 'package:dartz/dartz.dart';

import '../../../../core/api/api_exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/forecast_entity.dart';
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
    } on Exception catch (e, st) {
      logger.e(e, stackTrace: st);
      return Left(ServerFailure(message: e.toString()));
    } catch (e, st) {
      logger.e(e, stackTrace: st);
      return Left(SomethingWrong(message: 'Something went wrong: $e'));
    }
  }

  @override
  Future<Either<Failure, ForecastEntity>> getForecastWeather(
    GetCurrentWeatherParams params,
  ) async {
    try {
      final model = GetWeatherModel(
        lat: params.lat,
        lon: params.lon,
        units: params.units,
      );
      final res = await _datasource.getForecast(model);
      return Right(res);
    } on TooManyRequestsException {
      return Left(TooManyRequestsFailure());
    } on Exception catch (e, st) {
      logger.e(e, stackTrace: st);
      return Left(ServerFailure(message: e.toString()));
    } catch (e, st) {
      logger.e(e, stackTrace: st);
      return Left(SomethingWrong(message: 'Something went wrong: $e'));
    }
  }
}
