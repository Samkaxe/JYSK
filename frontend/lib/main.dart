import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const JyskSafetyApp());
}

class JyskSafetyApp extends StatelessWidget {
  const JyskSafetyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JYSK Safety',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0051A5),
          primary: const Color(0xFF0051A5),
          secondary: const Color(0xFF4A90E2),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const WelcomeScreen(),
    );
  }
}
