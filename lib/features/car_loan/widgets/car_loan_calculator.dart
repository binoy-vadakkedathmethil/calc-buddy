import 'dart:math';

class CarLoanCalculator {
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

    final double monthlyRate =
        annualInterestRate / 12 / 100;

    // No interest
    if (monthlyRate == 0) {
      return principal / totalMonths;
    }

    final double factor =
        pow(1 + monthlyRate, totalMonths).toDouble();

    return principal *
        monthlyRate *
        factor /
        (factor - 1);
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

  /// Calculate loan amount after down payment
  static double calculateLoanAmount({
    required double carPrice,
    required double downPayment,
  }) {
    final loanAmount = carPrice - downPayment;

    return loanAmount > 0 ? loanAmount : 0;
  }
}