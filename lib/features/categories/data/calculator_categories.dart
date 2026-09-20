import 'package:flutter/material.dart';

import '../../../models/calculator_category.dart';

const calculatorCategories = [
  CalculatorCategory(
    title: 'Health & Fitness',
    description: 'BMI and health related tools',
    icon: 'assets/images/icons/home/bmi_icon.svg',
    backgroundColor: Color(0xFFFFEFF1),
    iconColor: Color(0xFFFF5252),
  ),

  CalculatorCategory(
    title: 'Loans & Finance',
    description: 'Loan, EMI and interest calculators',
    icon: 'assets/images/icons/home/gold_loan_icon.svg',
    backgroundColor: Color(0xFFFFF7E6),
    iconColor: Color(0xFFFFA000),
  ),

  CalculatorCategory(
    title: 'Vehicle',
    description: 'Car loan and vehicle related tools',
    icon: 'assets/images/icons/home/car_loan_icon.svg',
    backgroundColor: Color(0xFFEAF5FF),
    iconColor: Color(0xFF2196F3),
  ),

  CalculatorCategory(
    title: 'Home & Property',
    description: 'Home loan and property tools',
    icon: 'assets/images/icons/home/home_loan_icon.svg',
    backgroundColor: Color(0xFFEAFBF5),
    iconColor: Color(0xFF20B86B),
  ),

  CalculatorCategory(
    title: 'Savings & Investment',
    description: 'SIP, FD and investment tools',
    icon: 'assets/images/icons/home/fd_icon.svg',
    backgroundColor: Color(0xFFF3EAFE),
    iconColor: Color(0xFF8E4DE8),
  ),

  // CalculatorCategory(
  //   title: 'Tax & Income',
  //   description: 'Income tax and tax planning tools',
  //   icon: 'assets/images/icons/home/income_tax_icon.svg',
  //   backgroundColor: Color(0xFFFFF0EA),
  //   iconColor: Color(0xFFFF7043),
  // ),

  CalculatorCategory(
    title: 'Miscellaneous',
    description: 'Currency converter and more',
    icon: 'assets/images/icons/home/misc_icon.svg',
    backgroundColor: Color(0xFFF1ECFF),
    iconColor: Color(0xFF7C4DFF),
  ),
];