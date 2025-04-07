import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/api/api_urls.dart';
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
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        myLocationEnabled: true,
        tileOverlays: {
          TileOverlay(
            tileOverlayId: const TileOverlayId('tile_overlay_id'),
            tileProvider: ForecastTileProvider(mapType: 'temp_new'),
          ),
        },
      ),
    );
  }
}

class ForecastTileProvider implements TileProvider {
  final String mapType;
  int tileSize = 16;

  ForecastTileProvider({required this.mapType});

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    var tileBytes = Uint8List(0);
    try {
      final url = ApiUrls.weatherMap1Url(mapType, zoom ?? 0, x, y);
      if (TilesCache.tiles.containsKey(url)) {
        tileBytes = TilesCache.tiles[url]!;
      } else {
        final uri = Uri.parse(url);

        final imageData = await NetworkAssetBundle(uri).load('');
        tileBytes = imageData.buffer.asUint8List();
        TilesCache.tiles[url] = tileBytes;
      }
    } catch (e) {
      print(e);
    }
    return Tile(tileSize, tileSize, tileBytes);
  }
}

class TilesCache {
  static Map<String, Uint8List> tiles = {};
}
