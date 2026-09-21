import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'features/splash/presentation/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/home/home_screen.dart';
import 'ads/interstitial_ad_manager.dart';


void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  InterstitialAdManager.loadAd();
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