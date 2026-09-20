import 'dart:math';

class FdCalculator {
  static double maturityAmount({
    required double principal,
    required double annualRate,
    required int years,
  }) {
    if (principal <= 0 || years <= 0) return 0;
    return principal * pow(1 + annualRate / 400, 4 * years);
  }
}
