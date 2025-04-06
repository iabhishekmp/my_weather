sealed class ApiException implements Exception {
  ApiException([this.message = '', this.prefix = '']);
  final String message;
  final String prefix;

  @override
  String toString() {
    return '$prefix: $message';
  }
}

class FetchDataException extends ApiException {
  FetchDataException(String message)
    : super(message, 'Error During Communication');
}

class BadRequestException extends ApiException {
  BadRequestException(String message) : super(message, 'Invalid Request');
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message, 'Unauthorized');
}

class ForbiddenException extends ApiException {
  ForbiddenException(String message) : super(message, 'Forbidden');
}

class NotFoundException extends ApiException {
  NotFoundException(String message) : super(message, 'Not Found');
}

class TooManyRequestsException extends ApiException {
  TooManyRequestsException(String message)
    : super(message, 'Too Many Requests');
}

class InternalServerException extends ApiException {
  InternalServerException(String message) : super(message, 'Internal Server: ');
}
