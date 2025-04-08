import '../../configs/env.dart';

class ApiUrls {
  static const String baseUrl = 'https://api.openweathermap.org';
  static const String localUrl = 'http://192.168.0.104:3001';

  static const String currentWeather = '/data/2.5/weather';
  static const String forecast = '/data/2.5/forecast';
  static const String geoDirect = '/geo/1.0/direct';

  static String iconUrl(String icon) =>
      'https://openweathermap.org/img/wn/$icon@2x.png';

  static String weatherMap1Url(String mapType, int z, int x, int y) =>
      'https://tile.openweathermap.org/map/$mapType/$z/$x/$y.png?appid=${Env.apiKey}';

  static String weatherMap2Url(String op, int z, int x, int y) =>
      'http://maps.openweathermap.org/maps/2.0/weather/$op/$z/$x/$y?appid=${Env.apiKey}';
}
