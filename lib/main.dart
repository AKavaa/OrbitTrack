import 'package:flutter/material.dart';
import 'package:orbit_track/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = true;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override                          
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orbit Track',
      debugShowCheckedModeBanner: false, // remove DEBUG banner
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(toggleTheme: toggleTheme),
    );
  }                                 
}                          