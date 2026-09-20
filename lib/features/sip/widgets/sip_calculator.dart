import 'dart:math';

class SipCalculator {
  static double futureValue({
    required double monthlyInvestment,
    required double annualReturn,
    required int years,
  }) {
    final months = years * 12;
    final monthlyRate = annualReturn / 1200;
    if (monthlyInvestment <= 0 || months <= 0) return 0;
    if (monthlyRate == 0) return monthlyInvestment * months;
    return monthlyInvestment *
        ((pow(1 + monthlyRate, months) - 1) / monthlyRate) *
        (1 + monthlyRate);
  }

  static double investedAmount(double monthlyInvestment, int years) =>
      monthlyInvestment * years * 12;
}
