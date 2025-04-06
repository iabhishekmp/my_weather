import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/weather_entity.dart';
import '../repositories/weather_repo.dart';

class GetCurrentWeatherUsecase extends UseCase<WeatherEntity, Params> {
  final WeatherRepository _repository;

  GetCurrentWeatherUsecase(this._repository);

  @override
  Future<Either<Failure, WeatherEntity>> call(Params params) {
    return _repository.getCurrentWeather(params);
  }
}

class Params extends Equatable {
  final double lat;
  final double lon;
  final String units;

  const Params({required this.lat, required this.lon, required this.units});

  @override
  List<Object?> get props => [lat, lon, units];
}
