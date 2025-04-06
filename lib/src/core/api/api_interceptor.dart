import 'package:dio/dio.dart';

import 'api_urls.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = ApiUrls.baseUrl;
    super.onRequest(options, handler);
  }
}
