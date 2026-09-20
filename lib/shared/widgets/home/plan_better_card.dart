import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlanBetterCard extends StatelessWidget {
  final VoidCallback? onTap;

  const PlanBetterCard({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(
          10,
          14,
          10,
          14,
        ),
        height: 82,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFFFF7F3),
              Color(0xFFFFF0EC),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
         
         
        ),
        child: Row(
          children: [
            // ------------------------------------------------
            // LIGHTBULB
            // ------------------------------------------------

            SizedBox(
              width: 56,
              height: 56,
              child: Image.asset(
                'assets/images/home/idea_lightbulb.png',
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(width: 12),

            // ------------------------------------------------
            // TEXT
            // ------------------------------------------------

            const Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Plan Better',
                    style: TextStyle(
                      color: Color(0xFF17345C),
                      fontSize: 14,
                      height: 1.15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Text(
                    'Live Smarter',
                    style: TextStyle(
                      color: Color(0xFF17345C),
                      fontSize: 14,
                      height: 1.15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    'Small calculations,',
                    style: TextStyle(
                      color: Color(0xFF71819E),
                      fontSize: 9.5,
                      height: 1.15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  Text(
                    'big plans for your future.',
                    style: TextStyle(
                      color: Color(0xFF71819E),
                      fontSize: 9.5,
                      height: 1.15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            // ------------------------------------------------
            // ARROW BUTTON
            // ------------------------------------------------

            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Color(0xFFFFDCD7),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(9),
              child: SvgPicture.asset(
                'assets/images/home/right-arrow.svg',
                 width: 20,
                 height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}