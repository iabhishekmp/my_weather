import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'weather_tile.dart';

class WeatherDetailsRow extends StatelessWidget {
  final double windSpeed;
  final DateTime sunrise;
  final DateTime sunset;
  final int humidity;

  const WeatherDetailsRow({
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.humidity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        WeatherTile(
          icon: Icons.air,
          label: 'Wind',
          value: '${windSpeed.toInt()} m/s',
        ),
        WeatherTile(
          icon: Icons.wb_sunny,
          label: 'Sunrise',
          value: DateFormat('hh:mm a').format(sunrise),
        ),
        WeatherTile(
          icon: Icons.nightlight_round,
          label: 'Sunset',
          value: DateFormat('hh:mm a').format(sunset),
        ),
        WeatherTile(
          icon: Icons.water_drop,
          label: 'Humidity',
          value: '$humidity%',
        ),
      ],
    );
  }
}
