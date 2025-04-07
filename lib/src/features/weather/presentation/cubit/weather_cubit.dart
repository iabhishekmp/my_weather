import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/location_services.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/usecases/get_current_weather_usecase.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetCurrentWeatherUsecase _getCurrentWeather;
  final LocationServices _locationServices;

  WeatherCubit(this._getCurrentWeather, this._locationServices)
    : super(WeatherInitial());

  Future<void> getCurrentWeather({required String units}) async {
    emit(WeatherLoading());
    final result = await _locationServices.getCurrentLocation();
    return result.fold(
      (error) {
        emit(WeatherError(error));
      },
      (location) async {
        final params = Params(
          lat: location.latitude,
          lon: location.longitude,
          units: units,
        );
        final result = await _getCurrentWeather(params);
        result.fold(
          (failure) => emit(WeatherError(mapFailureToMessage(failure))),
          (weather) => emit(WeatherLoaded(weather)),
        );
      },
    );
  }
}
