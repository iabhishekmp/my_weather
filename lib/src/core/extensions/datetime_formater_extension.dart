extension DateTimeFormatterExtension on DateTime {
  String timeFormat() {
    final hours = hour.toString().padLeft(2, '0');
    final minutes = minute.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    final year = this.year.toString();

    return '$hours:$minutes $day/$month/$year';
  }
}
