import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherHeader extends StatelessWidget implements PreferredSizeWidget {
  final DateTime time;
  final VoidCallback onRefresh;
  final VoidCallback onSearch;

  const WeatherHeader({
    required this.time,
    required this.onRefresh,
    required this.onSearch,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(onPressed: onRefresh, icon: const Icon(Icons.refresh)),
        Expanded(
          child: Text(
            DateFormat('EEEE, MMM d  hh:mm a').format(time),
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ),
        IconButton(onPressed: onSearch, icon: const Icon(Icons.search)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
