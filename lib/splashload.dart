import 'package:flutter/material.dart';
import 'dart:async';  // For adding delay

class SplashViewLogo extends StatefulWidget {
  @override
  _SplashViewLogoState createState() => _SplashViewLogoState();
}

class _SplashViewLogoState extends State<SplashViewLogo> {
  @override
  void initState() {
    super.initState();
    
    // Navigate to home screen after 3 seconds
    Timer(Duration(seconds: 10), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}