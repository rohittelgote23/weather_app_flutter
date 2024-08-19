import 'package:flutter/material.dart';
import 'package:weather_app/splash_screen.dart';
import 'package:weather_app/weather_screen.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CustomSplashScreen(),
  ));
}
class MyApp extends StatefulWidget{
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
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: _isDarkTheme ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true),
      theme: _isDarkTheme ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true)
      .copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF1B3817)),
          bodyMedium: TextStyle(color: Color(0xFF536250)),
        ),
        cardColor: const Color(0xFFBAE5B3),
        iconTheme: const IconThemeData(
          color: Color(0xFF1B3817), // Icon color
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF536250), // AppBar text/icon color
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WeatherScreen(toggleTheme: _toggleTheme, isDarkTheme: _isDarkTheme),
    );
  }
}

// 87ba30a3ac37c1dc731920e21485be82

// api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=87ba30a3ac37c1dc731920e21485be82

