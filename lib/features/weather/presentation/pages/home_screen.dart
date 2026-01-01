import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_project/core/locator.dart';
import 'package:simple_project/features/weather/data/weather_repo.dart';
import 'package:simple_project/features/weather/presentation/provider/weather_notifer.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.searchQuery});
  final String searchQuery;

  String getStatus(Condidion condidion) {
    switch (condidion) {
      case Condidion.rain: //san francisco
        return 'assets/animations/Rainy.json';
      case Condidion.clear:
        return 'assets/animations/Weather-sunny.json';
      case Condidion.clouds: //tripoli
        return 'assets/animations/Weather-partly cloudy.json';
      case Condidion.snow: //stockholm
        return 'assets/animations/Weather-snow.json';
    }
  }

  List<Color> getGradient(Condidion condidion) {
    switch (condidion) {
      case Condidion.clear:
        return [Color(0xFFFFD27E), Color(0xFFF39C6B)];

      case Condidion.clouds:
        return [Color(0xFF5AB2CE), Color(0xFF4A8CCF)];

      case Condidion.rain:
        return [Color(0xFF233D63), Color(0xFF1B2A49)];

      case Condidion.snow:
        return [Color(0xFFE8F1FF), Color(0xFFBFD7FF)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = getit<WeatherRepo>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,

      body: ChangeNotifierProvider(
        create: (context) => WeatherNotifer(text: searchQuery, repo: repo),
        builder: (context, child) {
          final notifier = context.watch<WeatherNotifer>();
          switch (notifier.status) {
            case Status.waiting:
              return Center(child: CircularProgressIndicator());
            case Status.sucsess:
              final item = notifier.weather!;
              return Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: getGradient(notifier.condidion!),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(getStatus(notifier.condidion!)),
                      Text(
                        item.name,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.copyWith(fontSize: 28),
                      ),
                      Text(
                        item.weather.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '${item.main.temp} °C',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(item.coord.lat.toString()),
                    ],
                  ),
                ),
              );
            case Status.noInternet:
              return Center(child: Text('No internert connection'));

            case Status.error:
              return Center(child: Text(notifier.error ?? 'Error'));
          }
        },
      ),
    );
  }
}
