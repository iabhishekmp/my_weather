import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'configs/injector/injector_conf.dart';
import 'features/weather/presentation/cubit/weather/weather_cubit.dart';
import 'features/weather/presentation/pages/weather_data_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => getIt<WeatherCubit>(),
        child: const WeatherDataPage(),
      ),
    );
  }
}
