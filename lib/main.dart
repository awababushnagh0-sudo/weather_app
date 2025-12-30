import 'package:flutter/material.dart';
import 'package:simple_project/core/locator.dart';
import 'package:simple_project/features/weather/presentation/pages/search_screen.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: SearchScreen()));
  }
}
