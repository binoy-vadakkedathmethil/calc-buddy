import 'dart:math';

import 'package:flutter/material.dart';

import '../../../models/gold_rate.dart';
import '../../../services/gold_rate_service.dart';
import '../widgets/gold_rate_card.dart';
import '../widgets/gold_loan_result_card.dart';

class GoldLoanCalculatorScreen extends StatefulWidget {
  const GoldLoanCalculatorScreen({
    super.key,
  });

  @override
  State<GoldLoanCalculatorScreen> createState() =>
      _GoldLoanCalculatorScreenState();
}

class _GoldLoanCalculatorScreenState
    extends State<GoldLoanCalculatorScreen> {
  final _weightController = TextEditingController();

  final _interestController =
      TextEditingController(text: '10.5');

  final GoldRateService _goldRateService =
      GoldRateService();

  GoldRate? _goldRate;

  String _purity = '22K';

  double _ltv = 75;

  int _tenure = 12;

  double? _goldValue;
  double? _loanAmount;
  double? _interestAmount;
  double? _emi;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _loadGoldRate();
  }

  @override
  void dispose() {
    _weightController.dispose();
    _interestController.dispose();

    super.dispose();
  }

  // --------------------------------------------------
  // GOLD RATE
  // --------------------------------------------------

  Future<void> _loadGoldRate() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final rate =
          await _goldRateService.getGoldRate();

      if (!mounted) return;

      setState(() {
        _goldRate = rate;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to load current gold rate',
          ),
        ),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });
    }
  }

  // --------------------------------------------------
  // GET SELECTED GOLD RATE
  // --------------------------------------------------

  double _getGoldRate() {
    if (_goldRate == null) {
      return 0;
    }

    switch (_purity) {
      case '24K':
        return _goldRate!.price24k;

      case '22K':
        return _goldRate!.price22k;

      case '21K':
        return _goldRate!.price21k;

      case '18K':
        return _goldRate!.price18k;

      default:
        return _goldRate!.price22k;
    }
  }

  // --------------------------------------------------
  // CALCULATE
  // --------------------------------------------------

  void _calculateLoan() {
    FocusScope.of(context).unfocus();

    final weight =
        double.tryParse(
          _weightController.text.trim(),
        ) ??
        0;

    final interest =
        double.tryParse(
          _interestController.text.trim(),
        ) ??
        0;

    if (weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter a valid gold weight',
          ),
        ),
      );

      return;
    }

    if (_goldRate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gold rate is not available',
          ),
        ),
      );

      return;
    }

    final goldRate = _getGoldRate();

    final goldValue =
        weight * goldRate;

    final loanAmount =
        goldValue * (_ltv / 100);

    final monthlyRate =
        interest / 12 / 100;

    double emi;

    if (monthlyRate == 0) {
      emi = loanAmount / _tenure;
    } else {
      final factor =
          pow(
            1 + monthlyRate,
            _tenure,
          );

      emi =
          loanAmount *
          monthlyRate *
          factor /
          (factor - 1);
    }

    final totalPayment =
        emi * _tenure;

    final totalInterest =
        totalPayment - loanAmount;

    setState(() {
      _goldValue = goldValue;
      _loanAmount = loanAmount;
      _interestAmount = totalInterest;
      _emi = emi;
    });
  }

  // --------------------------------------------------
  // UI
  // --------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gold Loan Calculator',
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // GOLD RATE CARD
            GoldRateCard(
              purity: _purity,
              rate: _getGoldRate(),
              isLoading: _isLoading,
              onRefresh: _loadGoldRate,
            ),

            const SizedBox(height: 24),

            // INPUTS
            _buildInputs(),

            const SizedBox(height: 24),

            // CALCULATE BUTTON
            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton(
                onPressed: _calculateLoan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFD746C),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),

                child: const Text(
                  'Calculate Loan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // RESULT CARD
            if (_goldValue != null &&
                _loanAmount != null &&
                _interestAmount != null &&
                _emi != null)
              LoanResultCard(
                goldValue: _goldValue!,
                loanAmount: _loanAmount!,
                interestAmount: _interestAmount!,
                emi: _emi!,
              ),

            // Important bottom spacing
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
  Widget _buildInputs() {
  return Column(
    crossAxisAlignment:
        CrossAxisAlignment.start,
    children: [
      const Text(
        'Gold Weight',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 8),

      TextField(
        controller: _weightController,
        keyboardType:
            const TextInputType.numberWithOptions(
          decimal: true,
        ),
        decoration: InputDecoration(
          hintText: 'Enter gold weight',
          suffixText: 'grams',
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),
        ),
      ),

      const SizedBox(height: 18),

      const Text(
        'Gold Purity',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 8),

      DropdownButtonFormField<String>(
        value: _purity,

        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),
        ),

        items: const [
          DropdownMenuItem(
            value: '24K',
            child: Text('24K Gold'),
          ),
          DropdownMenuItem(
            value: '22K',
            child: Text('22K Gold'),
          ),
          DropdownMenuItem(
            value: '21K',
            child: Text('21K Gold'),
          ),
          DropdownMenuItem(
            value: '18K',
            child: Text('18K Gold'),
          ),
        ],

        onChanged: (value) {
          if (value == null) return;

          setState(() {
            _purity = value;
          });
        },
      ),

      const SizedBox(height: 18),

      Text(
        'Loan-to-Value: ${_ltv.toStringAsFixed(0)}%',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),

      Slider(
        value: _ltv,
        min: 50,
        max: 90,
        divisions: 8,
        label:
            '${_ltv.toStringAsFixed(0)}%',
        onChanged: (value) {
          setState(() {
            _ltv = value;
          });
        },
      ),

      const SizedBox(height: 8),

      const Text(
        'Interest Rate',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 8),

      TextField(
        controller: _interestController,
        keyboardType:
            const TextInputType.numberWithOptions(
          decimal: true,
        ),
        decoration: InputDecoration(
          suffixText: '% p.a.',
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),
        ),
      ),

      const SizedBox(height: 18),

      const Text(
        'Loan Tenure',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 8),

      DropdownButtonFormField<int>(
        value: _tenure,

        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),
        ),

        items: const [
          DropdownMenuItem(
            value: 6,
            child: Text('6 Months'),
          ),
          DropdownMenuItem(
            value: 12,
            child: Text('12 Months'),
          ),
          DropdownMenuItem(
            value: 18,
            child: Text('18 Months'),
          ),
          DropdownMenuItem(
            value: 24,
            child: Text('24 Months'),
          ),
          DropdownMenuItem(
            value: 36,
            child: Text('36 Months'),
          ),
        ],

        onChanged: (value) {
          if (value == null) return;

          setState(() {
            _tenure = value;
          });
        },
      ),
    ],
  );
}
}