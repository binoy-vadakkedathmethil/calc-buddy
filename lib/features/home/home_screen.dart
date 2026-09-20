import 'package:flutter/material.dart';

import '../../shared/widgets/common/app_header.dart';
import '../../shared/widgets/home/home_hero_banner.dart';
import '../../shared/widgets/home/calculator_search.dart';
import '../../shared/widgets/home/popular_calculators.dart';
import '../../shared/widgets/home/plan_better_card.dart';
import '../../shared/widgets/common/app_bottom_navigation.dart';

import '../../models/calculator_item.dart';
import 'package:calc_buddy/features/bmi_calculator/screens/bmi_calculator_screen.dart';
import 'package:calc_buddy/features/gold_loan/screens/gold_loan_calculator_screen.dart';
import 'package:calc_buddy/features/home_loan/screens/home_loan_screen.dart';
import 'package:calc_buddy/features/car_loan/screens/car_loan_screen.dart';
import 'package:calc_buddy/features/emi/screens/emi_screen.dart';
import 'package:calc_buddy/features/sip/screens/sip_screen.dart';
import 'package:calc_buddy/features/fd/screens/fd_screen.dart';
import 'package:calc_buddy/features/income_tax/screens/income_tax_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
// ------------------------------------------
// POPULAR CALCULATORS
// ------------------------------------------

class _HomeScreenState extends State<HomeScreen> {
  static const List<CalculatorItem> popularCalculators = [
    CalculatorItem(
      id: 'bmi',
      title: 'BMI',
      subtitle: 'Calculator',
      icon: 'assets/images/icons/home/bmi_icon.svg',
    ),
    CalculatorItem(
      id: 'gold_loan',
      title: 'Gold Loan',
      subtitle: 'Calculator',
      icon: 'assets/images/icons/home/gold_loan_icon.svg',
    ),
    CalculatorItem(
      id: 'home_loan',
      title: 'Home Loan',
      subtitle: 'Calculator',
      icon: 'assets/images/icons/home/home_loan_icon.svg',
    ),
    CalculatorItem(
      id: 'car_loan',
      title: 'Car Loan',
      subtitle: 'Calculator',
      icon: 'assets/images/icons/home/car_loan_icon.svg',
    ),
    CalculatorItem(
      id: 'emi',
      title: 'EMI',
      subtitle: 'Calculator',
      icon: 'assets/images/icons/home/emi_icon.svg',
    ),
    CalculatorItem(
      id: 'sip',
      title: 'SIP',
      subtitle: 'Calculator',
      icon: 'assets/images/icons/home/sip_icon.svg',
    ),
    CalculatorItem(
      id: 'fd',
      title: 'FD',
      subtitle: 'Calculator',
      icon: 'assets/images/icons/home/fd_icon.svg',
    ),
    CalculatorItem(
      id: 'income_tax',
      title: 'Income Tax',
      subtitle: 'Calculator',
      icon: 'assets/images/icons/home/income_tax_icon.svg',
    ),
  ];
  int selectedIndex = 0;

  void _openCalculator(String id) {
    final Widget? screen = switch (id) {
      'bmi' => const BmiCalculatorScreen(),
      'gold_loan' => const GoldLoanCalculatorScreen(),
      'home_loan' => const HomeLoanScreen(),
      'car_loan' => const CarLoanScreen(),
      'emi' => const EmiScreen(),
      'sip' => const SipScreen(),
      'fd' => const FdScreen(),
      'income_tax' => const IncomeTaxScreen(),
      _ => null,
    };

    if (screen != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),

      body: SafeArea(
        child: Column(
          children: [
            // ------------------------------------------
            // COMMON HEADER
            // ------------------------------------------
            const AppHeader(),

            // ------------------------------------------
            // HOME CONTENT
            // ------------------------------------------
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // Hero Banner
                  const SliverToBoxAdapter(child: HomeHeroBanner()),
                  const SliverToBoxAdapter(child: CalculatorSearch()),
                  // Popular Calculators
                  SliverToBoxAdapter(
                    child: PopularCalculators(
                      calculators: popularCalculators,

                      onSeeAllTap: () {
                        // Categories screen later
                      },

                      onCalculatorTap: (calculator) =>
                          _openCalculator(calculator.id),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: PlanBetterCard(
                      onTap: () {
                        debugPrint('Plan Better tapped');
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Navigation
            AppBottomNavigation(selectedIndex: selectedIndex),
          ],
        ),
      ),
    );
  }
}
