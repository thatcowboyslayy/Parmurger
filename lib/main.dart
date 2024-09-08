import 'package:flutter/material.dart';
import 'package:my_project/screens/splash_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, scrennType) {
      return MaterialApp(
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        title: 'Pamurger',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      );
    });
  }
}

