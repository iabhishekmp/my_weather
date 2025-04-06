import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/datetime_formater_extension.dart';
import '../../../../core/extensions/int_datetime_extenstion.dart';
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
    _loadWeather();
  }

  void _loadWeather() {
    context.read<WeatherCubit>().getCurrentWeather(units: 'metric');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            final weather = state.weather;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Text('${weather.name}', style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 8),
                  Text('Temp: ${weather.main?.temp}°C'),
                  const SizedBox(height: 4),
                  Text('Condition: ${weather.weather?.first.description}'),
                  const SizedBox(height: 4),
                  Text('Time: ${(weather.dt ?? 0).toDateTime().timeFormat()}'),
                ],
              ),
            );
          } else if (state is WeatherError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Welcome! Getting weather...'));
          }
        },
      ),
    );
  }
}
