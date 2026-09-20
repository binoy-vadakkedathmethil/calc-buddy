import 'package:flutter/material.dart';
import 'onboarding_data.dart';
import '../../app/theme/app_theme.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final int pageIndex;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final VoidCallback onBack;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.pageIndex,
    required this.totalPages,
    required this.onNext,
    required this.onBack,
    required this.onSkip,
  });

  static const Color primaryColor = AppTheme.primaryColor;
  static const Color textColor = AppTheme.textPrimary;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        // Background
        Positioned.fill(
          child: Image.asset(
            data.background,
            fit: BoxFit.cover,
          ),
        ),

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                // Skip
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: onSkip,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Main illustration
                Container(
                  width: size.width * .68,
                  height: size.width * .68,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.35),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    data.icon,
                    size: size.width * .30,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 40),

                // Title
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${data.title}\n',
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: data.highlightedTitle,
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // Description
                Text(
                  data.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF52627A),
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),

                const Spacer(),

                // Page indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    totalPages,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: index == pageIndex ? 28 : 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: index == pageIndex
                            ? primaryColor
                            : primaryColor.withOpacity(.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Bottom buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (pageIndex > 0)
                      TextButton(
                       onPressed: onBack,
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            color: Color(0xFF52627A),
                            fontSize: 16,
                          ),
                        ),
                      )
                    else
                      const SizedBox(width: 70),

                    GestureDetector(
                      onTap: onNext,
                      child: Container(
                        width: pageIndex == totalPages - 1 ? 190 : 62,
                        height: 62,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(.25),
                              blurRadius: 15,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (pageIndex == totalPages - 1)
                              const Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}