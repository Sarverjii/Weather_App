import 'package:flutter/material.dart';
import 'package:weather_app/Pages/weather_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false;
  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkTheme
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true)
              .copyWith(iconTheme: const IconThemeData(color: Colors.black54)),
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(toggleTheme: _toggleTheme),
    );
  }
}
