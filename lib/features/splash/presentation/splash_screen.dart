import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/splash_background.dart';
import '../widgets/splash_logo.dart';
import '../widgets/splash_loading_dots.dart';
import '../../../services/onboarding_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _startSplash();
  }
 Future<void> _startSplash() async {
    // Keep splash visible for 3 seconds
    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (!mounted) return;

    await _goToNextScreen();
  }

  Future<void> _goToNextScreen() async {
    final bool onboardingCompleted =
        await OnboardingService.isCompleted();

    if (!mounted) return;

    if (onboardingCompleted) {
      // User has already completed onboarding
      Navigator.pushReplacementNamed(
        context,
        '/home',
      );
    } else {
      // First time user
      Navigator.pushReplacementNamed(
        context,
        '/onboarding',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background
            const SplashBackground(),

            // Foreground content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  const SplashLogo(),

                  const SizedBox(height: 24),

                  // Loading dots
                  const SplashLoadingDots(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}