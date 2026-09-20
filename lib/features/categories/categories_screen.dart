import 'package:flutter/material.dart';

import '../../shared/widgets/common/app_header.dart';
import '../../shared/widgets/common/app_bottom_navigation.dart';
import './data/calculator_categories.dart';
import '../../shared/widgets/categories/category_card.dart';
import 'package:calc_buddy/features/bmi_calculator/screens/bmi_calculator_screen.dart';
import 'package:calc_buddy/features/gold_loan/screens/gold_loan_calculator_screen.dart';
import 'package:calc_buddy/features/home_loan/screens/home_loan_screen.dart';
import 'package:calc_buddy/features/car_loan/screens/car_loan_screen.dart';
import 'package:calc_buddy/features/sip/screens/sip_screen.dart';
import 'package:calc_buddy/features/interest/screens/interest_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int selectedIndex = 1;

  void _openCategory(String title) {
    final Widget? screen = switch (title) {
      'Health & Fitness' => const BmiCalculatorScreen(),
      'Loans & Finance' => const GoldLoanCalculatorScreen(),
      'Vehicle' => const CarLoanScreen(),
      'Home & Property' => const HomeLoanScreen(),
      'Savings & Investment' => const SipScreen(),
      'Miscellaneous' => const InterestScreen(),
      _ => null,
    };

    if (screen != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
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
                      style: TextStyle(fontSize: 11, color: Color(0xFF65748B)),
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
                    onTap: () => _openCategory(category.title),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: AppBottomNavigation(selectedIndex: selectedIndex),
    );
  }
}
