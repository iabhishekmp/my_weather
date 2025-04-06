import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class SomethingWrong extends Failure {}

class ServerFailure extends Failure {}

class TooManyRequestsFailure extends Failure {}

String mapFailureToMessage(Failure failure) {
  return switch (failure) {
    ServerFailure() => 'Server Failure',
    TooManyRequestsFailure() => 'Too Many Requests',
    SomethingWrong() => 'Something went wrong',
  };
}
