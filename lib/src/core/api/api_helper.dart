import 'package:dio/dio.dart';

import 'api_exceptions.dart';

class ApiHelper {
  const ApiHelper(this._dio);
  final Dio _dio;

  Future<Map<String, dynamic>> execute({
    required String url,
    required Method method,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    Response<dynamic>? response;
    switch (method) {
      case Method.get:
        response = await _dio.get(url, queryParameters: queryParameters);
      case Method.post:
        response = await _dio.post(url, data: data);
    }
    return _returnResponse(response);
  }

  Map<String, dynamic> _returnResponse(Response<dynamic> response) {
    final code = response.statusCode;
    final data = response.data as Map<String, dynamic>;
    switch (code) {
      case 200:
        return data;
      case 400:
        throw BadRequestException(data['message'].toString());
      case 401:
        throw UnauthorizedException(data['message'].toString());
      case 403:
        throw ForbiddenException(data['message'].toString());
      case 404:
        throw NotFoundException(data['message'].toString());
      case 429:
        throw TooManyRequestsException(data['message'].toString());
      case 500:
        throw InternalServerException(data['message'].toString());
      default:
        throw FetchDataException(
          'Error while Communication with Server with StatusCode : $code',
        );
    }
  }
}

enum Method { get, post }
