import 'dart:math';

class EmiCalculator {
  static double calculateEmi({
    required double principal,
    required double annualInterestRate,
    required int tenureYears,
  }) {
    final months = tenureYears * 12;
    if (principal <= 0 || months <= 0) return 0;
    final monthlyRate = annualInterestRate / 1200;
    if (monthlyRate == 0) return principal / months;
    final factor = pow(1 + monthlyRate, months).toDouble();
    return principal * monthlyRate * factor / (factor - 1);
  }
}
