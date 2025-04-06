import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

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
    ..registerLazySingleton(() => ApiHelper(getIt<Dio>()));
}
