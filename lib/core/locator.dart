import 'package:get_it/get_it.dart';
import 'package:simple_project/features/weather/data/weather_repo.dart';

GetIt getit = GetIt.instance;

void setupLocator() {
  getit.registerLazySingleton<WeatherRepo>(() => WeatherRepo());
}
