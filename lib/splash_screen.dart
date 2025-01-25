import 'package:flutter/material.dart';
import 'dart:async';

import 'main.dart'; // Import your main app file

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  // late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(
    //   duration: const Duration(seconds: 3),
    //   vsync: this,
    // )..forward();
    // _animation = CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.easeIn,
    // );

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MyApp(),
      ));
    });
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 19, 34),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/weather_icon.png', width: 100, height: 100),
            const SizedBox(height: 15),
            const Text(
              "Weather App",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            // const SizedBox(height: 10),
            // const Text(
            //   "Made By Rohit Telgote",
            //   style: TextStyle(color: Colors.white,letterSpacing: 1),
            // ),
          ],
        ),
      ),
    );
  }
}
