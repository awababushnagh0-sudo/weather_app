import 'dart:convert';
import 'dart:io';

import 'package:simple_project/features/weather/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherRepo {
  Future<WeatherApi?> fetchWeather(String city) async {
    final apiKey = 'd283d031233551bfd5ee4ed6f54cdf3d';
    final url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'q': city,
      'appid': apiKey,
      'units': 'metric',
    });

    try {
      final respond = await http.get(url);
      if (respond.statusCode == 200) {
        final data = jsonDecode(respond.body);
        return WeatherApi.fromJson(data);
      } else if (respond.statusCode == 404) {
        throw ('No city found');
      } else if (respond.statusCode == 400) {
        throw ('Bad request');
      } else {
        throw ('Error ${respond.statusCode}');
      }
    } on SocketException {
      throw ('No internert connection');
    }
  }
}
