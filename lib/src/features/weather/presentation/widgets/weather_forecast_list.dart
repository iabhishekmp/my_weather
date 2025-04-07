import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/api/api_urls.dart';
import '../../../../core/extensions/int_datetime_extension.dart';
import '../../domain/entities/forecast_entity.dart';

class WeatherForecastList extends StatelessWidget {
  final ForecastEntity forecast;

  const WeatherForecastList({required this.forecast, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: Colors.white30, thickness: 1),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: forecast.list?.length ?? 0,
            itemBuilder: (context, index) {
              final forecastItem = forecast.list?[index];
              if (forecastItem == null) {
                return const SizedBox();
              }
              final forecastTime = (forecastItem.dt ?? 0).toDateTime();
              final forecastIcon = forecastItem.weather?.first.icon ?? '01d';
              final forecastTemp = forecastItem.main?.temp?.toInt() ?? 0;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat('EEE').format(forecastTime),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      DateFormat('hh:mm a').format(forecastTime),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Image.network(ApiUrls.iconUrl(forecastIcon), height: 50),
                    const SizedBox(height: 8),
                    Text(
                      '$forecastTemp°',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const Divider(color: Colors.white30, thickness: 1),
      ],
    );
  }
}
