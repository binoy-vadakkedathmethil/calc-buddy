import 'package:flutter/material.dart';

class CarLoanResultCard extends StatelessWidget {
  final String emi;
  final String loanAmount;
  final String totalInterest;
  final String totalPayment;

  const CarLoanResultCard({
    super.key,
    required this.emi,
    required this.loanAmount,
    required this.totalInterest,
    required this.totalPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFF1F0),
            Color(0xFFFFE7E4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            'Your Monthly EMI',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF68727F),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            emi,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Color(0xFF17345C),
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Expanded(
                child: _ResultItem(
                  title: 'Loan Amount',
                  value: loanAmount,
                ),
              ),

              Expanded(
                child: _ResultItem(
                  title: 'Total Interest',
                  value: totalInterest,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            height: 1,
            color: Colors.white,
          ),

          const SizedBox(height: 16),

          _ResultItem(
            title: 'Total Payment',
            value: totalPayment,
          ),
        ],
      ),
    );
  }
}

class _ResultItem extends StatelessWidget {
  final String title;
  final String value;

  const _ResultItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF7B8491),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3E50),
          ),
        ),
      ],
    );
  }
}