import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class SomethingWrong extends Failure {
  final String? message;
  SomethingWrong({this.message});
  @override
  List<Object> get props => [message ?? ''];
}

class ServerFailure extends Failure {
  final String? message;

  ServerFailure({this.message});

  @override
  List<Object> get props => [message ?? ''];
}

class TooManyRequestsFailure extends Failure {}

String mapFailureToMessage(Failure failure) {
  return switch (failure) {
    ServerFailure() => 'Server Failure: ${failure.message}',
    TooManyRequestsFailure() => 'Too Many Requests',
    SomethingWrong() => 'Something went wrong: ${failure.message}',
  };
}
