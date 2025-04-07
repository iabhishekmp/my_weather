import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../utils/logger.dart';

class LocationServices {
  Future<Either<String, Position>> getCurrentLocation() async {
    try {
      final isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled) {
        return const Left('Location services are disabled.');
      }

      // Check and request location permissions
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return const Left('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return const Left(
          'Location permission is permanently denied. Please enable them in settings.',
        );
      }

      return Right(
        await Geolocator.getCurrentPosition(locationSettings: _getSettings()),
      );
    } on Exception catch (e, st) {
      logger.e(e, stackTrace: st);
      return Left('Failed to get current location: $e');
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
