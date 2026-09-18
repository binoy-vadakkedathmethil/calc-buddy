import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/splash/calc_buddy_splash_bg.png',
        fit: BoxFit.cover,
      ),
    );
  }
}