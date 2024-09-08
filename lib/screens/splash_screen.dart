import 'package:flutter/material.dart';
import 'dart:async';

import 'package:my_project/screens/onboarding_screen.dart';
import 'package:my_project/utils/app_theme.dart'; // For adding delay

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // // Navigate to home screen after 3 seconds
    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(
              child: Image.asset(
                'assets/images/logo.png', // Ensure the path is correct
                width: 250, // Set the width of the logo
                height: 250, // Set the height of the logo
              ),
            ),
          ),
          // Three-dot loading indicator at the bottom
           Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(48.0),
              child: CircularProgressIndicator(
                color: AppTheme.green, // Color of the loading indicator
                strokeWidth: 3.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
