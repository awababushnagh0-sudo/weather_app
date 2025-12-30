import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simple_project/features/weather/data/weather_repo.dart';
import 'package:simple_project/features/weather/models/weather.dart';

enum WeatherStatus { sucsess, waiting, error, noInternet }

class WeatherNotifer extends ChangeNotifier {
  final WeatherRepo repo;
  WeatherNotifer({required this.text, required this.repo}) {
    featchData();
  }

  final String text;
  WeatherStatus status = WeatherStatus.waiting;
  WeatherApi? weather;
  String? error;

  Future<void> featchData() async {
    try {
      weather = await repo.fetchWeather(text);
      status = WeatherStatus.sucsess;
      notifyListeners();
    } on SocketException {
      status = WeatherStatus.noInternet;
      error = 'No internet connection';
    } catch (e) {
      status = WeatherStatus.error;
      error = '$e';
    }

    notifyListeners();
  }
}
