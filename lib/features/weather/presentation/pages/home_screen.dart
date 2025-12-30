import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_project/core/locator.dart';
import 'package:simple_project/features/weather/data/weather_repo.dart';
import 'package:simple_project/features/weather/presentation/provider/weather_notifer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.searchQuery});
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final repo = getit<WeatherRepo>();
    return Scaffold(
      appBar: AppBar(title: Text('Weather')),
      body: ChangeNotifierProvider(
        create: (context) => WeatherNotifer(text: searchQuery, repo: repo),
        builder: (context, child) {
          final notifier = context.watch<WeatherNotifer>();
          switch (notifier.status) {
            case WeatherStatus.waiting:
              return Center(child: CircularProgressIndicator());
            case WeatherStatus.sucsess:
              final item = notifier.weather!;
              return ListView(
                children: [
                  ListTile(
                    title: Text(item.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.weather.description),
                        Text('${item.main.temp} °C'),
                      ],
                    ),
                  ),
                ],
              );
            case WeatherStatus.noInternet:
              return Center(child: Text('No internert connection'));

            case WeatherStatus.error:
              return Center(child: Text(notifier.error ?? 'Error'));
          }
        },
      ),
    );
  }
}
