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
    context.read<WeatherCubit>().getCurrentWeather(units: 'metric');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        } else if (state is WeatherError) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          );
        } else if (state is WeatherLoaded) {
          final weather = state.weather;
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
                  onPressed: () {
                    context.read<WeatherCubit>().getCurrentWeather(
                      units: 'metric',
                    );
                  },
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
                    Text(
                      city,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description.toUpperCase(),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(ApiUrls.iconUrl(icon), height: 160),
                          Text(
                            '$temp°',
                            style: const TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
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
                    const SizedBox(height: 32),
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
        }
        return const Center(
          child: Text(
            'Fetching weather data...',
            style: TextStyle(color: Colors.white, fontSize: 18),
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
