import 'package:flutter/material.dart';
import 'package:calc_buddy/ads/interstitial_ad_manager.dart';
import '../../../services/history_service.dart';
import '../widgets/interest_calculator.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});
  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  double principal = 100000, rate = 8, years = 5, interest = 0;
  bool isCompound = true;

  @override
  void initState() {
    super.initState();
    _calculate();
  }

  void _calculate({bool save = false}) {
    final result = isCompound
        ? InterestCalculator.compoundInterest(
            principal: principal,
            annualRate: rate,
            years: years.round(),
            compoundsPerYear: 4,
          )
        : InterestCalculator.simpleInterest(
            principal: principal,
            annualRate: rate,
            years: years.round(),
          );
    setState(() => interest = result);
    if (save) {
      HistoryService.add(
        title: 'Interest Calculator',
        details:
            '${_money(principal)} | ${years.round()} yrs | ${rate.toStringAsFixed(1)}%',
        result: _money(principal + interest),
        icon: 'percent',
        color: 0xFFFD746C,
      );
      InterstitialAdManager.recordCalculation();
    }
  }

  String _money(double value) => '₹${value.round()}';

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF8F9FC),
    appBar: AppBar(
      title: const Text('Interest Calculator'),
      backgroundColor: Colors.transparent,
      foregroundColor: const Color(0xFF17345C),
      elevation: 0,
    ),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _header(),
        const SizedBox(height: 18),
        _modeSelector(),
        const SizedBox(height: 14),
        _input(
          'Principal Amount',
          _money(principal),
          '₹5,000',
          '₹1 Crore',
          Icons.account_balance_rounded,
          principal,
          5000,
          10000000,
          199,
          (value) => setState(() => principal = value),
        ),
        _input(
          'Interest Rate',
          '${rate.toStringAsFixed(1)}%',
          '1%',
          '30%',
          Icons.percent_rounded,
          rate,
          1,
          30,
          290,
          (value) => setState(() => rate = value),
        ),
        _input(
          'Time Period',
          '${years.round()} Years',
          '1 Year',
          '30 Years',
          Icons.calendar_month_rounded,
          years,
          1,
          30,
          29,
          (value) => setState(() => years = value),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: () => _calculate(save: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFD746C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Calculate Interest',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(height: 18),
        _result(),
      ],
    ),
  );

  Widget _header() => Row(
    children: [
      Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFFD746C).withValues(alpha: .1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.percent_rounded, color: Color(0xFFFD746C)),
      ),
      const SizedBox(width: 14),
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Simple or Compound Interest',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF17345C),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Compare interest earned over time',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _modeSelector() => SegmentedButton<bool>(
    segments: const [
      ButtonSegment(
        value: false,
        label: Text('Simple'),
        icon: Icon(Icons.show_chart),
      ),
      ButtonSegment(
        value: true,
        label: Text('Compound'),
        icon: Icon(Icons.auto_graph),
      ),
    ],
    selected: {isCompound},
    onSelectionChanged: (selection) {
      setState(() => isCompound = selection.first);
      _calculate();
    },
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

  Widget _result() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFFFFE7E4),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Text(
          '${isCompound ? 'Compound' : 'Simple'} Interest',
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 6),
        Text(
          _money(interest),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: Color(0xFF17345C),
          ),
        ),
        const SizedBox(height: 18),
        Text('Total amount: ${_money(principal + interest)}'),
      ],
    ),
  );
}
