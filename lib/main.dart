import 'package:flutter/material.dart';
import 'package:currency_calculator/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Convert',
      theme: ThemeData(
        hintColor: Colors.blue[900],
        primaryColor: Colors.blue[900],
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
