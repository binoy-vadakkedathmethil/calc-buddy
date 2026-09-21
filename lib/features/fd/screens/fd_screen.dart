import 'package:flutter/material.dart';
import 'package:calc_buddy/ads/interstitial_ad_manager.dart';
import '../../../services/history_service.dart';
import '../../../shared/widgets/common/app_bottom_navigation.dart';
import '../widgets/fd_calculator.dart';

class FdScreen extends StatefulWidget {
  const FdScreen({super.key});
  @override
  State<FdScreen> createState() => _FdScreenState();
}

class _FdScreenState extends State<FdScreen> {
  double principal = 100000, rate = 7.5, years = 5, maturity = 0;
  @override
  void initState() {
    super.initState();
    _calculate();
  }

  void _calculate({bool save = false}) {
    setState(() {
      maturity = FdCalculator.maturityAmount(
        principal: principal,
        annualRate: rate,
        years: years.round(),
      );
    });
    if (save) {
      HistoryService.add(
        title: 'FD Calculator',
        details:
            '${money(principal)} | ${years.round()} yrs | ${rate.toStringAsFixed(1)}%',
        result: money(maturity),
        icon: 'savings',
        color: 0xFF0EA5A4,
      );
      InterstitialAdManager.recordCalculation();
    }
  }

  String money(double v) => '₹${v.round()}';
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF8F9FC),
    appBar: AppBar(
      title: const Text('FD Calculator'),
      backgroundColor: Colors.transparent,
      foregroundColor: const Color(0xFF17345C),
      elevation: 0,
    ),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        header(),
        const SizedBox(height: 18),
        input(
          'Deposit Amount',
          money(principal),
          '₹5,000',
          '₹1 Crore',
          Icons.account_balance_rounded,
          principal,
          5000,
          10000000,
          199,
          (v) => setState(() => principal = v),
        ),
        input(
          'Interest Rate',
          '${rate.toStringAsFixed(1)}%',
          '3%',
          '15%',
          Icons.percent_rounded,
          rate,
          3,
          15,
          120,
          (v) => setState(() => rate = v),
        ),
        input(
          'Deposit Tenure',
          '${years.round()} Years',
          '1 Year',
          '10 Years',
          Icons.calendar_month_rounded,
          years,
          1,
          10,
          9,
          (v) => setState(() => years = v),
        ),
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
          color: const Color(0xFF0EA5A4).withValues(alpha: .1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.lock_rounded, color: Color(0xFF0EA5A4)),
      ),
      const SizedBox(width: 14),
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fixed Deposit',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF17345C),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Estimate your guaranteed maturity value',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    ],
  );
  Widget input(
    String title,
    String value,
    String minLabel,
    String maxLabel,
    IconData icon,
    double current,
    double min,
    double max,
    int divisions,
    ValueChanged<double> changed,
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
              Icon(icon, color: const Color(0xFF0EA5A4)),
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
            activeColor: const Color(0xFF0EA5A4),
            onChanged: changed,
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
  Widget button() => SizedBox(
    height: 52,
    child: ElevatedButton(
      onPressed: () => _calculate(save: true),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0EA5A4),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: const Text(
        'Calculate Maturity',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
  );
  Widget result() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFFE4FAFA),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        const Text('Maturity Amount', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 6),
        Text(
          money(maturity),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: Color(0xFF17345C),
          ),
        ),
        const SizedBox(height: 18),
        Text('Interest earned: ${money(maturity - principal)}'),
      ],
    ),
  );
}
