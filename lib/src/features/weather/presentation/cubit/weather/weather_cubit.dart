import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/location_services.dart';
import '../../../domain/entities/forecast_entity.dart';
import '../../../domain/entities/weather_entity.dart';
import '../../../domain/usecases/get_current_weather_usecase.dart';
import '../../../domain/usecases/get_forecast_usecase.dart';
import '../../../domain/usecases/usecase_params.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetCurrentWeatherUsecase _getCurrentWeather;
  final GetForecastUseCase _getForecastWeather;
  final LocationServices _locationServices;

  WeatherCubit(
    this._getCurrentWeather,
    this._getForecastWeather,
    this._locationServices,
  ) : super(const WeatherState(isLoading: false));

  Future<void> getCurrentWeather({required String units}) async {
    emit(state.copyWith(isLoading: true));
    final result = await _locationServices.getCurrentLocation();
    return result.fold(
      (error) {
        emit(state.copyWith(isLoading: false, error: error));
      },
      (location) async {
        final params = GetCurrentWeatherParams(
          lat: location.latitude,
          lon: location.longitude,
          units: units,
        );
        final result = await _getCurrentWeather(params);
        result.fold(
          (failure) => emit(
            state.copyWith(
              isLoading: false,
              error: mapFailureToMessage(failure),
            ),
          ),
          (weather) => emit(WeatherState(isLoading: false, weather: weather)),
        );
      },
    );
  }

  Future<void> getForecastWeather({required String units}) async {
    emit(state.copyWith(isLoading: true));
    final result = await _locationServices.getCurrentLocation();
    return result.fold(
      (error) {
        emit(state.copyWith(isLoading: false, error: error));
      },
      (location) async {
        final params = GetCurrentWeatherParams(
          lat: location.latitude,
          lon: location.longitude,
          units: units,
        );
        final result = await _getForecastWeather(params);
        result.fold(
          (failure) => emit(
            state.copyWith(
              isLoading: false,
              error: mapFailureToMessage(failure),
            ),
          ),
          (forecast) =>
              emit(state.copyWith(isLoading: false, forecast: forecast)),
        );
      },
    );
  }
}
