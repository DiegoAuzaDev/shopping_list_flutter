import 'package:flutter/material.dart';

import 'widgets/grocery_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.blue,
          brightness: Brightness.dark,
          seedColor: Colors.blue,
          surface: Colors.blue[900],
        ),
      ),
      home: const GroceryList(),
    );
  }
}
