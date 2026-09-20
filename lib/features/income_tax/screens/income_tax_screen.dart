import 'package:flutter/material.dart';
import '../../../shared/widgets/common/app_bottom_navigation.dart';
import '../widgets/income_tax_calculator.dart';

class IncomeTaxScreen extends StatefulWidget {
  const IncomeTaxScreen({super.key});
  @override
  State<IncomeTaxScreen> createState() => _IncomeTaxScreenState();
}

class _IncomeTaxScreenState extends State<IncomeTaxScreen> {
  double income = 1200000, tax = 0;
  @override
  void initState() {
    super.initState();
    _calculate();
  }

  void _calculate() =>
      setState(() => tax = IncomeTaxCalculator.calculateTax(income));
  String money(double v) => '₹${v.round()}';
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF8F9FC),
    appBar: AppBar(
      title: const Text('Income Tax Calculator'),
      backgroundColor: Colors.transparent,
      foregroundColor: const Color(0xFF17345C),
      elevation: 0,
    ),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        header(),
        const SizedBox(height: 18),
        input(),
        const SizedBox(height: 6),
        button(),
        const SizedBox(height: 18),
        result(),
      ],
    ),
    bottomNavigationBar: const AppBottomNavigation(selectedIndex: 0),
  );
  Widget header() => Row(
    children: [
      Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFFF9A3D).withValues(alpha: .1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.receipt_long_rounded, color: Color(0xFFFF9A3D)),
      ),
      const SizedBox(width: 14),
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Income Tax',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF17345C),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Estimate tax under the new regime',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    ],
  );
  Widget input() => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.currency_rupee_rounded, color: Color(0xFFFF9A3D)),
            SizedBox(width: 10),
            Text(
              'Annual Income',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          money(income),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF17345C),
          ),
        ),
        Slider(
          value: income,
          min: 100000,
          max: 10000000,
          divisions: 99,
          activeColor: const Color(0xFFFF9A3D),
          onChanged: (v) => setState(() => income = v),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('₹1 Lakh', style: TextStyle(fontSize: 11, color: Colors.grey)),
            Text(
              '₹1 Crore',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ],
    ),
  );
  Widget button() => SizedBox(
    height: 52,
    child: ElevatedButton(
      onPressed: _calculate,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF9A3D),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: const Text(
        'Calculate Tax',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
  );
  Widget result() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF0E6),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        const Text(
          'Estimated Tax Payable',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 6),
        Text(
          money(tax),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: Color(0xFF17345C),
          ),
        ),
        const SizedBox(height: 18),
        Text('Post-tax income: ${money(income - tax)}'),
      ],
    ),
  );
}
