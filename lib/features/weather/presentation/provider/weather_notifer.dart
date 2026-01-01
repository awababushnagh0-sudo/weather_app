import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simple_project/features/weather/data/weather_repo.dart';
import 'package:simple_project/features/weather/models/weather.dart';

enum Status { sucsess, waiting, error, noInternet }

enum Condidion { rain, clear, clouds, snow }

class WeatherNotifer extends ChangeNotifier {
  final WeatherRepo repo;
  WeatherNotifer({required this.text, required this.repo}) {
    featchData();
  }

  final String text;
  Status status = Status.waiting;
  WeatherApi? weather;
  String? error;
  Condidion? condidion;

  void getStatus(String? main) {
    switch (main) {
      //san francisco
      case 'Rain':
        condidion = Condidion.rain;
      case 'Clear':
        condidion = Condidion.clear;
        break;
      case 'Clouds':
        condidion = Condidion.clouds;
        break;
      case 'Snow':
        condidion = Condidion.snow;
      default:
        condidion = Condidion.clear;
    }
  }

  Future<void> featchData() async {
    try {
      weather = await repo.fetchWeather(text);
      status = Status.sucsess;
      getStatus(weather!.weather.main.toString());
      print(weather!.weather.main);
      notifyListeners();
    } on SocketException {
      status = Status.noInternet;
      error = 'No internet connection';
    } catch (e) {
      status = Status.error;
      error = '$e';
    }

    notifyListeners();
  }
}
