import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../configs/injector/injector_conf.dart';
import '../../../../core/extensions/int_datetime_extension.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/usecases/get_geo_direct_cities_usecase.dart';
import '../cubit/geo_city/geo_city_cubit.dart';
import '../cubit/weather/weather_cubit.dart';
import '../widgets/weather_city_desc_widget.dart';
import '../widgets/weather_details_row.dart';
import '../widgets/weather_forecast_list.dart';
import '../widgets/weather_header.dart';
import '../widgets/weather_icon_temp_section.dart';
import 'map_page.dart';
import 'search_city_page.dart';

class WeatherDataPage extends StatefulWidget {
  final Position? position;
  const WeatherDataPage({super.key, this.position});

  @override
  State<WeatherDataPage> createState() => _WeatherDataPageState();
}

class _WeatherDataPageState extends State<WeatherDataPage> {
  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  void _fetchWeatherData() {
    context.read<WeatherCubit>().fetchWeather(
      units: 'metric',
      position: widget.position,
    );
    context.read<WeatherCubit>().fetchForecast(
      units: 'metric',
      position: widget.position,
    );
  }

  void _navigateToSearch() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder:
            (context) => BlocProvider(
              create:
                  (context) => GeoCityCubit(getIt<GetGeoDirectCitiesUseCase>()),
              child: const SearchCityPage(),
            ),
      ),
    );
  }

  void _navigateToMap(WeatherEntity weather) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => MapPage(weather: weather)),
    );
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

        return Scaffold(
          appBar:
              widget.position == null
                  ? WeatherHeader(
                    time: (weather.dt ?? 0).toDateTime(),
                    onRefresh: _fetchWeatherData,
                    onSearch: _navigateToSearch,
                  )
                  : AppBar(
                    backgroundColor: Colors.black,
                    iconTheme: const IconThemeData(color: Colors.white),
                  ),
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  WeatherCity(weather: weather),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Stack(
                            children: [
                              WeatherIconTemp(weather: weather),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    _navigateToMap(weather);
                                  },
                                  backgroundColor: Colors.transparent,
                                  child: const Icon(
                                    Icons.map,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (forecast != null)
                          Expanded(
                            child: WeatherForecastList(forecast: forecast),
                          ),
                      ],
                    ),
                  ),
                  WeatherDetailsRow(
                    windSpeed: weather.wind?.speed ?? 0,
                    sunrise: (weather.sys?.sunrise ?? 0).toDateTime(),
                    sunset: (weather.sys?.sunset ?? 0).toDateTime(),
                    humidity: weather.main?.humidity ?? 0,
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
