import 'package:flutter/material.dart';

class OnboardingData {
  final String background;
  final IconData icon;
  final String title;
  final String highlightedTitle;
  final String description;

  const OnboardingData({
    required this.background,
    required this.icon,
    required this.title,
    required this.highlightedTitle,
    required this.description,
  });
}

const onboardingPages = [
  OnboardingData(
    background: 'assets/images/onboarding/onboard_bg1.png',
    icon: Icons.calculate_rounded,
    title: 'All Calculators',
    highlightedTitle: 'in One Place',
    description:
        'From health to finance, daily life to travel — '
        'everything you need in one simple app.',
  ),

  OnboardingData(
    background: 'assets/images/onboarding/onboard_bg2.png',
    icon: Icons.insights_rounded,
    title: 'Plan Smarter',
    highlightedTitle: 'Live Better',
    description:
        'Make informed decisions with accurate and '
        'easy-to-use calculators.',
  ),

  OnboardingData(
    background: 'assets/images/onboarding/onboard_bg3.png',
    icon: Icons.track_changes_rounded,
    title: 'Your Goals',
    highlightedTitle: 'Our Support',
    description:
        'Simple tools to help you plan, calculate and '
        'achieve a brighter tomorrow.',
  ),
];