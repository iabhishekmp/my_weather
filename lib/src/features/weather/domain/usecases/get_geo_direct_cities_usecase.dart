import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/geo_direct_city_entity.dart';
import '../repositories/weather_repo.dart';

class GetGeoDirectCitiesUseCase
    extends UseCase<List<GeoDirectCityEntity>, Params> {
  final WeatherRepository _repository;

  GetGeoDirectCitiesUseCase(this._repository);

  @override
  Future<Either<Failure, List<GeoDirectCityEntity>>> call(Params params) {
    return _repository.getCities(params);
  }
}

class Params extends Equatable {
  final String query;
  final int limit;

  const Params({required this.query, required this.limit});

  @override
  List<Object?> get props => [query, limit];
}
