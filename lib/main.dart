import 'package:flutter/material.dart';
import 'package:your_project_name/screens/splash_screen.dart';
//import 'screens/home_page.dart';

void main() {
  runApp(const TimeZoneApp());
}

class TimeZoneApp extends StatelessWidget {
  const TimeZoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Zone Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
