import 'package:dio/dio.dart';

import 'api_urls.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options
      ..baseUrl = ApiUrls.localUrl
      ..queryParameters = {
        'appid': const String.fromEnvironment('API_KEY'),
        ...options.queryParameters,
      };
    super.onRequest(options, handler);
  }
}
