import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    dateTimeFormat: (time) {
      return DateFormat('dd-MM-yyyy hh:mm:ss a').format(time);
    },
  ),
  output: MyConsoleOutput(),
);

class MyConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (final line in event.lines) {
      log(line);
    }
  }
}
