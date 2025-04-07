import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/entities/weather_entity.dart';

class MapPage extends StatefulWidget {
  final WeatherEntity weather;
  const MapPage({required this.weather, super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late CameraPosition initialCameraPosition;
  late Set<Marker> markers = <Marker>{};

  @override
  void initState() {
    super.initState();
    initialCameraPosition = CameraPosition(
      target: LatLng(
        widget.weather.coord?.lat ?? 0,
        widget.weather.coord?.lon ?? 0,
      ),
      zoom: 10,
    );
    markers.add(
      Marker(
        markerId: MarkerId(widget.weather.id?.toString() ?? ''),
        position: LatLng(
          widget.weather.coord?.lat ?? 0,
          widget.weather.coord?.lon ?? 0,
        ),
        infoWindow: InfoWindow(
          title: widget.weather.name,
          snippet: 'Temperature: ${widget.weather.main?.temp}°C',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
      ),
    );
  }
}
