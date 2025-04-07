import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/api/api_urls.dart';
import '../../../../core/extensions/int_datetime_extension.dart';
import '../cubit/weather_cubit.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  void _fetchWeatherData() {
    context.read<WeatherCubit>().getCurrentWeather(units: 'metric');
    context.read<WeatherCubit>().getForecastWeather(units: 'metric');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final isLoading = state.isLoading;
        final error = state.error;
        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        } else if (error != null) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Text(
                'Error: $error',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          );
        }

        final weather = state.weather;
        final forecast = state.forecast;

        if (weather == null) {
          return const Center(
            child: Text(
              'No weather data available',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        }

        final temp = weather.main?.temp?.toInt() ?? 0;
        final minTemp = weather.main?.tempMin?.toInt() ?? 0;
        final maxTemp = weather.main?.tempMax?.toInt() ?? 0;
        final description = weather.weather?.first.description ?? '-';
        final icon = weather.weather?.first.icon ?? '01d';
        final sunrise = (weather.sys?.sunrise ?? 0).toDateTime();
        final sunset = (weather.sys?.sunset ?? 0).toDateTime();
        final city = weather.name ?? 'Unknown';
        final time = (weather.dt ?? 0).toDateTime();
        final windSpeed = weather.wind?.speed ?? 0;
        final humidity = weather.main?.humidity ?? 0;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                onPressed: _fetchWeatherData,
                icon: const Icon(Icons.refresh),
              ),
              // const Spacer(),
              Expanded(
                child: Text(
                  DateFormat('EEEE, MMM d  hh:mm a').format(time),
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
          ),
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  //? city name
                  Text(
                    city,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),

                  //? description
                  Text(
                    description.toUpperCase(),
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //? icon
                              Image.network(ApiUrls.iconUrl(icon), height: 100),

                              //? temperature
                              Text(
                                '$temp°',
                                style: const TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),

                              //? min and max temperature
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _WeatherTile(
                                    icon: Icons.thermostat,
                                    label: 'Min',
                                    value: '$minTemp°',
                                  ),
                                  const SizedBox(width: 32),
                                  _WeatherTile(
                                    icon: Icons.thermostat_outlined,
                                    label: 'Max',
                                    value: '$maxTemp°',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        //? Forecast
                        if (forecast != null) ...[
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
                                final forecastTime =
                                    (forecastItem.dt ?? 0).toDateTime();
                                final forecastIcon =
                                    forecastItem.weather?.first.icon ?? '01d';
                                final forecastTemp =
                                    forecastItem.main?.temp?.toInt() ?? 0;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        DateFormat('EEE').format(forecastTime),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        DateFormat(
                                          'hh:mm a',
                                        ).format(forecastTime),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Image.network(
                                        ApiUrls.iconUrl(forecastIcon),
                                        height: 50,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '$forecastTemp°',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const Divider(color: Colors.white30, thickness: 1),
                        ],
                      ],
                    ),
                  ),

                  //? weather details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _WeatherTile(
                        icon: Icons.air,
                        label: 'Wind',
                        value: '${windSpeed.toInt()} m/s',
                      ),
                      _WeatherTile(
                        icon: Icons.wb_sunny,
                        label: 'Sunrise',
                        value: DateFormat('hh:mm a').format(sunrise),
                      ),
                      _WeatherTile(
                        icon: Icons.nightlight_round,
                        label: 'Sunset',
                        value: DateFormat('hh:mm a').format(sunset),
                      ),
                      _WeatherTile(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: '$humidity%',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _WeatherTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
