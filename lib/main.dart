import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF5F3F0),
        primaryColor: const Color(0xFF3E2F2F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3E2F2F),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}