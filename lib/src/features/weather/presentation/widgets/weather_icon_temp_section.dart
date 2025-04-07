import 'package:flutter/material.dart';

import '../../../../core/api/api_urls.dart';
import '../../domain/entities/weather_entity.dart';
import 'weather_tile.dart';

class WeatherIconTemp extends StatelessWidget {
  const WeatherIconTemp({required this.weather, super.key});

  final WeatherEntity weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          ApiUrls.iconUrl(weather.weather?.first.icon ?? '01d'),
          height: 100,
        ),
        Text(
          '${weather.main?.temp?.toInt() ?? 0}°',
          style: const TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WeatherTile(
              icon: Icons.thermostat,
              label: 'Min',
              value: '${weather.main?.tempMin?.toInt() ?? 0}°',
            ),
            const SizedBox(width: 32),
            WeatherTile(
              icon: Icons.thermostat_outlined,
              label: 'Max',
              value: '${weather.main?.tempMax?.toInt() ?? 0}°',
            ),
          ],
        ),
      ],
    );
  }
}
