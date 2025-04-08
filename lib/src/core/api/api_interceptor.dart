import 'dart:convert';

import 'package:dio/dio.dart';

import '../../configs/env.dart';
import '../utils/logger.dart';
import 'api_urls.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options
      ..baseUrl = ApiUrls.baseUrl
      ..queryParameters = {'appid': Env.apiKey, ...options.queryParameters};
    super.onRequest(options, handler);
  }
}

class MyLogInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('Request: ${options.method} ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    String data;
    try {
      data = jsonEncode(response.data);
    } catch (_) {
      data = response.data;
    }
    logger.i('Response: ${response.statusCode} $data');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
      '''Error ${err.response?.statusCode}: ${err.requestOptions.path} \nResponse: ${err.response}''',
    );
    super.onError(err, handler);
  }
}
