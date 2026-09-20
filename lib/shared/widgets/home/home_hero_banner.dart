import 'package:flutter/material.dart';

class HomeHeroBanner extends StatelessWidget {
  const HomeHeroBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        16,
      ),
      height: 165,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF2F0),
            Color(0xFFFFDCD7),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Decorative background shape
            Positioned(
              right: -40,
              bottom: -70,
              child: Container(
                width: 220,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(
                    alpha: 0.25,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Calculator illustration
            Positioned(
              right: 12,
              top: 20,
              child: _CalculatorIllustration(),
            ),

            // Text
            const Positioned(
              left: 18,
              top: 24,
              right: 125,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Smarter',
                    style: TextStyle(
                      color: Color(0xFF17345C),
                      fontSize: 22,
                      height: 1.05,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Text(
                    'Calculations',
                    style: TextStyle(
                      color: Color(0xFF17345C),
                      fontSize: 22,
                      height: 1.05,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Text(
                    'Brighter Tomorrow',
                    style: TextStyle(
                      color: Color(0xFFFD746C),
                      fontSize: 21,
                      height: 1.15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Simple tools for your everyday needs.',
                    style: TextStyle(
                      color: Color(0xFF536985),
                      fontSize: 11.5,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _CalculatorIllustration extends StatelessWidget {
  const _CalculatorIllustration();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/home/banner_calculator.png',
      width: 125,
      height: 125,
      fit: BoxFit.contain,
    );
  }
}