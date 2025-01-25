import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/splash_screen.dart';
import 'package:weather_app/weather_screen.dart';

void main() async {
  await dotenv.load();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CustomSplashScreen(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = true;

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: _isDarkTheme ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true),
      theme: _isDarkTheme
          ? ThemeData.dark()
          : ThemeData.light().copyWith(
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Color.fromRGBO(27, 56, 23, 1)),
                bodyMedium: TextStyle(color: Color.fromRGBO(83, 98, 80, 1)),
              ),
              cardColor: const Color.fromRGBO(186, 229, 179, 1),
              iconTheme: const IconThemeData(
                color: Color.fromARGB(255, 27, 56, 23), // Icon color
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor:
                    Color.fromRGBO(83, 98, 80, 1), // AppBar text/icon color
              ),
              scaffoldBackgroundColor: Colors.white,
            ),
      home: WeatherScreen(toggleTheme: _toggleTheme, isDarkTheme: _isDarkTheme),
    );
  }
}
