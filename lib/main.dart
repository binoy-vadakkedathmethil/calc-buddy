import 'package:flutter/material.dart';
import 'features/splash/presentation/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/home/home_screen.dart';



void main() {
  runApp(const CalcBuddyApp());
}

class CalcBuddyApp extends StatelessWidget {
  const CalcBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CalcBuddy',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

// '/home': (context) => const HomeScreen(),