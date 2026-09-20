import 'dart:math';

class HomeLoanCalculator {
  /// Calculate monthly EMI
  static double calculateEmi({
    required double principal,
    required double annualInterestRate,
    required int tenureYears,
  }) {
    final int totalMonths = tenureYears * 12;

    if (principal <= 0 || totalMonths <= 0) {
      return 0;
    }

    // Monthly interest rate
    final double monthlyRate =
        annualInterestRate / 12 / 100;

    // If interest rate is 0
    if (monthlyRate == 0) {
      return principal / totalMonths;
    }

    final double factor =
        pow(1 + monthlyRate, totalMonths).toDouble();

    final double emi =
        principal *
        monthlyRate *
        factor /
        (factor - 1);

    return emi;
  }

  /// Calculate total amount paid
  static double calculateTotalPayment({
    required double emi,
    required int tenureYears,
  }) {
    return emi * tenureYears * 12;
  }

  /// Calculate total interest
  static double calculateTotalInterest({
    required double totalPayment,
    required double principal,
  }) {
    return totalPayment - principal;
  }
}