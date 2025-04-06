import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/configs/injector/injector_conf.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const App());
}
