import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/debouncer.dart';
import '../../../domain/entities/geo_direct_city_entity.dart';
import '../../../domain/usecases/get_geo_direct_cities_usecase.dart';
import '../../../domain/usecases/usecase_params.dart';

part 'geo_city_state.dart';

class GeoCityCubit extends Cubit<GeoCityState> {
  final GetGeoDirectCitiesUseCase _useCase;
  final Debouncer _debouncer = Debouncer();
  GeoCityCubit(this._useCase) : super(const GeoCityState(isLoading: false));

  Future<void> onCityChange(String query) async {
    _debouncer.run(() => _fetchCities(query));
  }

  Future<void> _fetchCities(String query) async {
    if (query.trim().isEmpty) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    final params = GetGeoDirectCityParams(query: query, limit: 5);
    final result = await _useCase(params);
    return result.fold(
      (error) {
        emit(
          state.copyWith(isLoading: false, error: mapFailureToMessage(error)),
        );
      },
      (cities) {
        emit(
          state.copyWith(isLoading: false, cities: cities, hasSearched: true),
        );
      },
    );
  }
}
