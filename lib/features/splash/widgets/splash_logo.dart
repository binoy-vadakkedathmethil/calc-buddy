import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo/calc_buddy_logo.png',
      width: 180,
      height: 180,
      fit: BoxFit.contain,
    );
  }
}