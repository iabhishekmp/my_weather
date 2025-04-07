// Mocks generated by Mockito 5.4.5 from annotations
// in my_weather/test/src/features/weather/domain/usecases/get_forecast_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:my_weather/src/core/errors/failures.dart' as _i5;
import 'package:my_weather/src/features/weather/domain/entities/forecast_entity.dart'
    as _i8;
import 'package:my_weather/src/features/weather/domain/entities/weather_entity.dart'
    as _i6;
import 'package:my_weather/src/features/weather/domain/repositories/weather_repo.dart'
    as _i3;
import 'package:my_weather/src/features/weather/domain/usecases/get_current_weather_usecase.dart'
    as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [WeatherRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRepository extends _i1.Mock implements _i3.WeatherRepository {
  MockWeatherRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.WeatherEntity>> getCurrentWeather(
    _i7.Params? params,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#getCurrentWeather, [params]),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, _i6.WeatherEntity>>.value(
                  _FakeEither_0<_i5.Failure, _i6.WeatherEntity>(
                    this,
                    Invocation.method(#getCurrentWeather, [params]),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i6.WeatherEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i8.ForecastEntity>> getForecastWeather(
    _i7.Params? params,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#getForecastWeather, [params]),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, _i8.ForecastEntity>>.value(
                  _FakeEither_0<_i5.Failure, _i8.ForecastEntity>(
                    this,
                    Invocation.method(#getForecastWeather, [params]),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i8.ForecastEntity>>);
}
