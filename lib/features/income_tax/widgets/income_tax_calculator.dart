class IncomeTaxCalculator {
  static double calculateTax(double annualIncome) {
    final taxableIncome = (annualIncome - 75000).clamp(0, double.infinity);
    var remaining = taxableIncome.toDouble();
    var tax = 0.0;
    const slabs = [
      (400000.0, 0.0),
      (400000.0, 0.05),
      (400000.0, 0.10),
      (400000.0, 0.15),
      (400000.0, 0.20),
      (double.infinity, 0.30),
    ];
    for (final slab in slabs) {
      if (remaining <= 0) break;
      final amount = remaining < slab.$1 ? remaining : slab.$1;
      tax += amount * slab.$2;
      remaining -= amount;
    }
    return tax * 1.04;
  }
}
