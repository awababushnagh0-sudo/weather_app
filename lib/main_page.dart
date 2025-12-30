import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_project/user.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  Future<List<User>> featchUsers() async {
    final url = Uri.https('jsonplaceholder.typicode.com', '/users');
    final resond = await http.get(url);

    if (resond.statusCode == 200) {
      final List users = jsonDecode(resond.body);
      return users.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception("error while getting data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API Praactice')),

      body: FutureBuilder<List<User>>(
        future: featchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Column(
                  children: [
                    Text(user.id.toString()),
                    Text(user.email),
                    Text(user.phone),
                    Text(user.address.city),
                    Text(user.address.zipcode),
                    Text(user.address.geo.lat),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
