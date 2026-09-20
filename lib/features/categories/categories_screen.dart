import 'package:flutter/material.dart';

import '../../shared/widgets/common/app_header.dart';
import '../../shared/widgets/common/app_bottom_navigation.dart';
import './data/calculator_categories.dart';
import '../../shared/widgets/categories/category_card.dart';
import '../home/home_screen.dart';



class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int selectedIndex = 1;

  void _onNavigationItemSelected(int index) {
    if (index == selectedIndex) {
      return;
    }

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
        break;

      case 1:
        // Already on Categories
        break;

      case 2:
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const HistoryScreen(),
        //   ),
        // );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            // Common Header
            const AppHeader(),

            // Page title
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 18, 16, 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF17345C),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Explore calculators by category',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF65748B),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Category list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: calculatorCategories.length,
                itemBuilder: (context, index) {
                  final category = calculatorCategories[index];

                  return CategoryCard(
                    category: category,
                    onTap: () {
                      debugPrint(
                        'Selected: ${category.title}',
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: AppBottomNavigation(
        selectedIndex: selectedIndex,
      ),
    );
  }
}