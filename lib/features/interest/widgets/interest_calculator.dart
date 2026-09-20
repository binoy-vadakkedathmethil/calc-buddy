import 'dart:math';

class InterestCalculator {
  static double simpleInterest({
    required double principal,
    required double annualRate,
    required int years,
  }) => principal * annualRate * years / 100;

  static double compoundInterest({
    required double principal,
    required double annualRate,
    required int years,
    required int compoundsPerYear,
  }) {
    if (principal <= 0 || years <= 0) return 0;
    final maturity =
        principal *
        pow(1 + annualRate / 100 / compoundsPerYear, compoundsPerYear * years);
    return maturity - principal;
  }
}
