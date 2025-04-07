class ApiUrls {
  static const String baseUrl = 'https://api.openweathermap.org';
  static const String localUrl = 'http://192.168.0.104:3001';

  static const String currentWeather = '/data/2.5/weather';
  static const String forecast = '/data/2.5/forecast';

  static String iconUrl(String icon) =>
      'https://openweathermap.org/img/wn/$icon@2x.png';
}
