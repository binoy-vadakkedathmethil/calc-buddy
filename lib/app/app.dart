import 'package:flutter/material.dart';

import '../features/home/home_screen.dart';
import 'theme/app_theme.dart';

class CalcBuddyApp extends StatelessWidget {
  const CalcBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CalcBuddy',
      theme: AppTheme.lightTheme,
      // home: const HomeScreen(),
    );
  }
}
