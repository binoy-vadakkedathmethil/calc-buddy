import 'package:flutter/material.dart';
import '../../../shared/widgets/common/app_bottom_navigation.dart';
import '../widgets/emi_calculator.dart';

class EmiScreen extends StatefulWidget {
  const EmiScreen({super.key});
  @override
  State<EmiScreen> createState() => _EmiScreenState();
}

class _EmiScreenState extends State<EmiScreen> {
  double principal = 1000000, rate = 9, years = 5, emi = 0;

  @override
  void initState() {
    super.initState();
    _calculate();
  }

  void _calculate() => setState(
    () => emi = EmiCalculator.calculateEmi(
      principal: principal,
      annualInterestRate: rate,
      tenureYears: years.round(),
    ),
  );
  String _money(double value) => '₹${value.round()}';

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF8F9FC),
    appBar: AppBar(
      title: const Text('EMI Calculator'),
      backgroundColor: Colors.transparent,
      foregroundColor: const Color(0xFF17345C),
      elevation: 0,
    ),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _intro(
          'Monthly EMI',
          'Plan your loan repayment with confidence',
          Icons.calculate_rounded,
          const Color(0xFF8B5CF6),
        ),
        const SizedBox(height: 18),
        _input(
          'Loan Amount',
          _money(principal),
          '₹1 Lakh',
          '₹1 Crore',
          Icons.account_balance_rounded,
          principal,
          100000,
          10000000,
          99,
          (v) => setState(() => principal = v),
        ),
        _input(
          'Interest Rate',
          '${rate.toStringAsFixed(1)}%',
          '5%',
          '20%',
          Icons.percent_rounded,
          rate,
          5,
          20,
          150,
          (v) => setState(() => rate = v),
        ),
        _input(
          'Loan Tenure',
          '${years.round()} Years',
          '1 Year',
          '30 Years',
          Icons.calendar_month_rounded,
          years,
          1,
          30,
          29,
          (v) => setState(() => years = v),
        ),
        const SizedBox(height: 6),
        _button(),
        const SizedBox(height: 18),
        _result(
          'Your Monthly EMI',
          _money(emi),
          'Principal: ${_money(principal)}',
          'Total Interest: ${_money(emi * years * 12 - principal)}',
        ),
      ],
    ),
    bottomNavigationBar: const AppBottomNavigation(selectedIndex: 0),
  );

  Widget _intro(String title, String subtitle, IconData icon, Color color) =>
      Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF17345C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      );
  Widget _input(
    String title,
    String value,
    String minLabel,
    String maxLabel,
    IconData icon,
    double current,
    double min,
    double max,
    int divisions,
    ValueChanged<double> onChanged,
  ) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFFD746C)),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF17345C),
            ),
          ),
          Slider(
            value: current,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: const Color(0xFFFD746C),
            onChanged: onChanged,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                minLabel,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              Text(
                maxLabel,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    ),
  );
  Widget _button() => SizedBox(
    height: 52,
    child: ElevatedButton(
      onPressed: _calculate,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFD746C),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: const Text(
        'Calculate EMI',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
  );
  Widget _result(String label, String value, String first, String second) =>
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE7E4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(label, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Color(0xFF17345C),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(first), Text(second)],
            ),
          ],
        ),
      );
}
