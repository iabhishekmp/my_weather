import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/forecast_entity.dart';
import '../repositories/weather_repo.dart';
import 'usecase_params.dart';

class GetForecastUseCase
    extends UseCase<ForecastEntity, GetCurrentWeatherParams> {
  final WeatherRepository _repository;

  GetForecastUseCase(this._repository);

  @override
  Future<Either<Failure, ForecastEntity>> call(GetCurrentWeatherParams params) {
    return _repository.getForecastWeather(params);
  }
}
