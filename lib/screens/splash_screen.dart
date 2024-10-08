import 'package:flutter/material.dart';
import 'dart:async';

import 'package:my_project/screens/onboarding_screen.dart'; // For adding delay

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
    Timer(const Duration(seconds: 3), () {
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF014e28), Color(0xFF87dc1b)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Ensure the path is correct
                    width: 250, // Set the width of the logo
                    height: 250, // Set the height of the logo
                  ),
                  const SizedBox(
                      height: 20), // Add some spacing between logo and text
                  const Text(
                    'Parmurger',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
          // Three-dot loading indicator at the bottom
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(48.0),
              child: CircularProgressIndicator(
                color: Colors.white, // Color of the loading indicator
                strokeWidth: 3.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
