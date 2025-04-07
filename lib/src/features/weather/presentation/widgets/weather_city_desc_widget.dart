import 'package:flutter/material.dart';

import '../../domain/entities/weather_entity.dart';

class WeatherCity extends StatelessWidget {
  const WeatherCity({required this.weather, super.key});

  final WeatherEntity weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          weather.name ?? 'Unknown',
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          (weather.weather?.first.description ?? '-').toUpperCase(),
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }
}
