import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices {
  LocationServices._();

  static Future<Position> getCurrentLocation() async {
    try {
      final isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled) {
        throw const LocationServiceDisabledException();
      }

      // Check and request location permissions
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw const PermissionDeniedException(
            'Location permission is denied.',
          );
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw const PermissionDeniedException(
          'Location permission is permanently denied. Please enable them in settings.',
        );
      }

      // Get the current position
      return await Geolocator.getCurrentPosition(
        locationSettings: _getSettings(),
      );
    } catch (e) {
      // Handle and rethrow exceptions
      throw Exception('Failed to get current location: $e');
    }
  }

  static LocationSettings _getSettings() {
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
