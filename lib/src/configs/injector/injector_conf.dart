import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../core/services/location_services.dart';
import '../../features/weather/data/datasources/weather_datasource.dart';
import '../../features/weather/data/repositories/weather_repo_impl.dart';
import '../../features/weather/domain/usecases/get_current_weather_usecase.dart';
import '../../features/weather/domain/usecases/get_forecast_usecase.dart';
import '../../features/weather/presentation/cubit/weather_cubit.dart';
import 'injector.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt
    ..registerLazySingleton(ApiInterceptor.new)
    ..registerLazySingleton(
      () =>
          Dio()
            ..interceptors.addAll([
              getIt<ApiInterceptor>(),
              LogInterceptor(requestBody: true, responseBody: true),
            ]),
    )
    ..registerLazySingleton(() => ApiHelper(getIt<Dio>()))
    ..registerLazySingleton(() => WeatherDatasourceImpl(getIt<ApiHelper>()))
    ..registerLazySingleton(
      () => WeatherRepositoryImpl(getIt<WeatherDatasourceImpl>()),
    )
    ..registerLazySingleton(
      () => GetCurrentWeatherUsecase(getIt<WeatherRepositoryImpl>()),
    )
    ..registerLazySingleton(
      () => GetForecastUseCase(getIt<WeatherRepositoryImpl>()),
    )
    ..registerLazySingleton(LocationServices.new)
    ..registerLazySingleton(
      () => WeatherCubit(
        getIt<GetCurrentWeatherUsecase>(),
        getIt<GetForecastUseCase>(),
        getIt<LocationServices>(),
      ),
    );
}
