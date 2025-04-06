import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/usecases/get_current_weather_usecase.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetCurrentWeatherUsecase _getCurrentWeather;

  WeatherCubit(this._getCurrentWeather) : super(WeatherInitial());

  Future<void> getCurrentWeather(double lat, double lon, String units) async {
    emit(WeatherLoading());
    final params = Params(lat: lat, lon: lon, units: units);
    final result = await _getCurrentWeather(params);
    result.fold(
      (failure) => emit(WeatherError(mapFailureToMessage(failure))),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }
}
