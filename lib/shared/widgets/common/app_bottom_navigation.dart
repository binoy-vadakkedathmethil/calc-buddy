import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../features/home/home_screen.dart';
import '../../../features/categories/categories_screen.dart';
import '../../../features/history/history_screen.dart';

class AppBottomNavigation extends StatelessWidget {
  final int selectedIndex;

  const AppBottomNavigation({
    super.key,
    required this.selectedIndex,
  });

void _navigateToScreen(
  BuildContext context,
  int index,
) {
  // Already on this screen
  if (index == selectedIndex) {
    return;
  }

  switch (index) {
    case 0:
      Navigator.pushReplacement(
        context,
        _createRoute(
          const HomeScreen(),
        ),
      );
      break;

    case 1:
      Navigator.pushReplacement(
        context,
        _createRoute(
          const CategoriesScreen(),
        ),
      );
      break;

    case 2:
      Navigator.pushReplacement(
        context,
        _createRoute(
          const HistoryScreen(),
        ),
      );
      break;
  }
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
  top: false,
  child: Container(
    height: 60,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(19, 137, 136, 136),
          blurRadius: 4,
          spreadRadius: 0,
          offset: Offset(0, -2),
        ),
      ],
    ),
    child: Row(
      children: [
        // Home
        Expanded(
          child: _buildItem(
            context: context,
            index: 0,
            label: 'Home',
            activeIcon:
                'assets/images/icons/home/nav_home_active.svg',
            inactiveIcon:
                'assets/images/icons/home/nav_home_inactive.svg',
          ),
        ),

        // Categories
        Expanded(
          child: _buildItem(
            context: context,
            index: 1,
            label: 'Categories',
            activeIcon:
                'assets/images/icons/home/nav_categories_active.svg',
            inactiveIcon:
                'assets/images/icons/home/nav_categories_inactive.svg',
          ),
        ),

        // History
        Expanded(
          child: _buildItem(
            context: context,
            index: 2,
            label: 'History',
            activeIcon:
                'assets/images/icons/home/nav_history_active.svg',
            inactiveIcon:
                'assets/images/icons/home/nav_history_inactive.svg',
          ),
        ),
      ],
    ),
  ),
);
  }

  Widget _buildItem({
    required BuildContext context,
    required int index,
    required String label,
    required String activeIcon,
    required String inactiveIcon,
  }) {
    final bool isSelected = selectedIndex == index;

    return InkWell(
      onTap: () => _navigateToScreen(context, index),
      child: SizedBox(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: SvgPicture.asset(
                isSelected ? activeIcon : inactiveIcon,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 6),

            SizedBox(
              height: 18,
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? const Color(0xFFFF6B6B)
                      : const Color(0xFF8A94A6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  PageRoute _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,

    transitionsBuilder:
        (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.08, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeOutCubic;

      final slideAnimation = Tween<Offset>(
        begin: begin,
        end: end,
      ).chain(
        CurveTween(curve: curve),
      );

      final fadeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).chain(
        CurveTween(curve: curve),
      );

      return FadeTransition(
        opacity: fadeAnimation.animate(animation),
        child: SlideTransition(
          position: slideAnimation.animate(animation),
          child: child,
        ),
      );
    },

    transitionDuration: const Duration(
      milliseconds: 300,
    ),
  );
}
}