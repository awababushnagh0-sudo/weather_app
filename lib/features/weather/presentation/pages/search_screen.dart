import 'package:flutter/material.dart';
import 'package:simple_project/features/weather/presentation/pages/home_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _textContoller = TextEditingController();

  @override
  void dispose() {
    _textContoller.dispose();
    super.dispose();
  }

  void _validText() {
    final value = _textContoller.text.trim().isEmpty;
    if (value) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Invalid input'),
            content: Text('Please enter a valid city name'),
            actions: [
              IconButton(
                onPressed: Navigator.of(context).pop,
                icon: Icon(Icons.clear),
              ),
            ],
          );
        },
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HomeScreen(searchQuery: _textContoller.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search for temp')),
      body: Column(
        children: [
          TextField(
            controller: _textContoller,
            maxLength: 50,
            decoration: InputDecoration(label: Text('enter a city')),
          ),
          const SizedBox(height: 8),

          ElevatedButton(onPressed: _validText, child: Text('Search')),
        ],
      ),
    );
  }
}
