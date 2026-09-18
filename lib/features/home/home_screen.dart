// import 'package:flutter/material.dart';


// import '../../shared/widgets/common/app_header.dart';
// import '../../models/calculator_item.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final List<CalculatorItem> calculators = [
//     const CalculatorItem(
//       title: 'BMI',
//       subtitle: 'Calculator',
//       icon: 'assets/images/icons/bmi_icon.svg',
//     ),
//     const CalculatorItem(
//       title: 'Gold Loan',
//       subtitle: 'Calculator',
//       icon: 'assets/images/icons/gold_loan_icon.svg',
//     ),
//     const CalculatorItem(
//       title: 'Home Loan',
//       subtitle: 'Calculator',
//       icon: 'assets/images/icons/home_loan_icon.svg',
//     ),
//     const CalculatorItem(
//       title: 'Car Loan',
//       subtitle: 'Calculator',
//       icon: 'assets/images/icons/car_loan_icon.svg',
//     ),
//     const CalculatorItem(
//       title: 'EMI',
//       subtitle: 'Calculator',
//       icon: 'assets/images/icons/emi_icon.svg',
//     ),
//     const CalculatorItem(
//       title: 'SIP',
//       subtitle: 'Calculator',
//       icon: 'assets/images/icons/sip_icon.svg',
//     ),
//     const CalculatorItem(
//       title: 'FD',
//       subtitle: 'Calculator',
//       icon: 'assets/images/icons/fd_icon.svg',
//     ),
//     const CalculatorItem(
//       title: 'Income Tax',
//       subtitle: 'Calculator',
//       icon: 'assets/images/icons/income_tax_icon.svg',
//     ),
//     const CalculatorItem(
//       title: 'RD',
//       subtitle: 'Calculator',
//       icon: 'assets/images/icons/rd_icon.svg',
//     ),
//     const CalculatorItem(
//       title: 'Currency',
//       subtitle: 'Converter',
//       icon: 'assets/images/icons/currency_icon.svg',
//     ),
//     const CalculatorItem(
//       title: 'Loan Eligibility',
//       subtitle: 'Calculator',
//       icon: 'assets/images/icons/loan_eligibility_icon.svg',
//     ),
//     const CalculatorItem(
//       title: 'More',
//       subtitle: 'Calculators',
//       icon: 'assets/images/icons/more_icon.svg',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FC),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: CustomScrollView(
//                 slivers: [
//                   const SliverToBoxAdapter(
//                     child: AppHeader(),
//                   ),

                  
//                 ],
//               ),
//             ),

            
//           ],
//         ),
//       ),
//     );
//   }

//   void _onNavigationChanged(int index) {
//     switch (index) {
//       case 0:
//         break;

//       case 1:
//         // Navigate to Categories
//         break;

//       case 2:
//         // Navigate to History
//         break;
//     }
//   }

//   void _openCalculator(
//     CalculatorItem calculator,
//   ) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           '${calculator.title} Calculator',
//         ),
//       ),
//     );
//   }
// }