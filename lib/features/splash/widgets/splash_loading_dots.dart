import 'package:flutter/material.dart';
import '../../../app/theme/app_theme.dart';

class SplashLoadingDots extends StatefulWidget {
  const SplashLoadingDots({super.key});

  @override
  State<SplashLoadingDots> createState() => _SplashLoadingDotsState();
}

class _SplashLoadingDotsState extends State<SplashLoadingDots>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Convert animation value into 0, 1, 2, or 3
        final activeIndex = (_controller.value * 4).floor() % 4;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(4, (index) {
            final isActive = index == activeIndex;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 9 : 8,
              height: isActive ? 9 : 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? AppTheme.primaryColor
                    : AppTheme.secondaryColor.withOpacity(0.25),
              ),
            );
          }),
        );
      },
    );
  }
}