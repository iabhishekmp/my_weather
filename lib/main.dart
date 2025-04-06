import 'package:flutter/material.dart';

import 'src/configs/injector/injector_conf.dart';
import 'src/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}
