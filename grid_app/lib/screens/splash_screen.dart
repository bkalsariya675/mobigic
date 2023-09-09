import 'dart:async';

import 'package:flutter/material.dart';

import 'grid_setup_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Delay for 2 seconds and then navigate to the next screen
    Timer(
      const Duration(seconds: 2),
      () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const GridSetupScreen(),
      )),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Search Game'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Word Search Game',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
