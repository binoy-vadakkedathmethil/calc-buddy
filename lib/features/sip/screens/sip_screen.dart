import 'package:flutter/material.dart';
import 'package:calc_buddy/ads/interstitial_ad_manager.dart';
import '../../../services/history_service.dart';
import '../../../shared/widgets/common/app_bottom_navigation.dart';
import '../widgets/sip_calculator.dart';

class SipScreen extends StatefulWidget {
  const SipScreen({super.key});
  @override
  State<SipScreen> createState() => _SipScreenState();
}

class _SipScreenState extends State<SipScreen> {
  double monthly = 10000, rate = 12, years = 10, value = 0;
  @override
  void initState() {
    super.initState();
    _calculate();
  }

  void _calculate({bool save = false}) {
    setState(() {
      value = SipCalculator.futureValue(
        monthlyInvestment: monthly,
        annualReturn: rate,
        years: years.round(),
      );
    });
    if (save) {
      HistoryService.add(
        title: 'SIP Calculator',
        details:
            '${money(monthly)} | ${years.round()} yrs | ${rate.toStringAsFixed(1)}%',
        result: money(value),
        icon: 'savings',
        color: 0xFF19A86B,
      );
      InterstitialAdManager.recordCalculation();
    }
  }

  String money(double v) => '₹${v.round()}';
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF8F9FC),
    appBar: AppBar(
      title: const Text('SIP Calculator'),
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
          'Monthly Investment',
          money(monthly),
          '₹500',
          '₹1 Lakh',
          Icons.savings_rounded,
          monthly,
          500,
          100000,
          199,
          (v) => setState(() => monthly = v),
        ),
        input(
          'Expected Return',
          '${rate.toStringAsFixed(1)}%',
          '5%',
          '30%',
          Icons.trending_up_rounded,
          rate,
          5,
          30,
          250,
          (v) => setState(() => rate = v),
        ),
        input(
          'Investment Period',
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
          color: const Color(0xFF19A86B).withValues(alpha: .1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.auto_graph_rounded, color: Color(0xFF19A86B)),
      ),
      const SizedBox(width: 14),
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SIP Returns',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF17345C),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'See how your investments can grow',
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
              Icon(icon, color: const Color(0xFF19A86B)),
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
            activeColor: const Color(0xFF19A86B),
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
        backgroundColor: const Color(0xFF19A86B),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: const Text(
        'Calculate Returns',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
  );
  Widget result() {
    final invested = SipCalculator.investedAmount(monthly, years.round());
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F8EF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            'Estimated Future Value',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 6),
          Text(
            money(value),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Color(0xFF17345C),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Invested: ${money(invested)}'),
              Text('Returns: ${money(value - invested)}'),
            ],
          ),
        ],
      ),
    );
  }
}
