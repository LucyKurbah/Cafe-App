import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cafe App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const Home(),
    );
  }
}
