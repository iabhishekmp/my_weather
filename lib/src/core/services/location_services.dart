import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../utils/logger.dart';

class LocationServices {
  Position? position;
  DateTime _lastFetchedTime = DateTime.now();
  Completer<Either<String, Position>>? _completer;

  Future<Either<String, Position>> getCurrentLocation() async {
    if (position != null &&
        DateTime.now().difference(_lastFetchedTime).inSeconds < 300) {
      return Right(position!);
    }

    if (_completer != null) {
      return _completer!.future;
    }
    _completer = Completer<Either<String, Position>>();

    try {
      final isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled) {
        const msg = 'Location services are disabled.';
        _completer!.complete(const Left(msg));
        return const Left(msg);
      }

      // Check and request location permissions
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          const msg = 'Location permissions are denied.';
          _completer!.complete(const Left(msg));
          return const Left(msg);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        const msg =
            '''Location permissions are permanently denied. Please enable them in settings.''';
        _completer!.complete(const Left(msg));
        return const Left(msg);
      }

      position = await Geolocator.getCurrentPosition(
        locationSettings: _getSettings(),
      );
      _lastFetchedTime = DateTime.now();
      _completer!.complete(Right(position!));
      return Right(position!);
    } on Exception catch (e, st) {
      logger.e(e, stackTrace: st);
      final msg = 'Failed to get current location: $e';
      _completer!.complete(Left(msg));
      return Left(msg);
    }
  }

  LocationSettings _getSettings() {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
      TargetPlatform.iOS => AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
      ),
      _ => const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    };
  }
}
