import 'package:flutter/material.dart';
import 'onboarding_data.dart';
import 'onboarding_page.dart';
import '../../../services/onboarding_service.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  void nextPage() {
    if (currentPage < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void skipOnboarding() {
    _finishOnboarding();
  }

  void previousPage() {
  if (currentPage > 0) {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
 Future<void> _finishOnboarding() async {
    // Save onboarding completion
    await OnboardingService.complete();

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      '/home',
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: onboardingPages.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return OnboardingPage(
            data: onboardingPages[index],
            pageIndex: index,
            totalPages: onboardingPages.length,
            onNext: nextPage,
            onSkip: skipOnboarding,
            onBack: previousPage,
          );
        },
      ),
    );
  }
}