import 'package:flutter/material.dart';

class LoanResultCard extends StatelessWidget {
  final double goldValue;
  final double loanAmount;
  final double interestAmount;
  final double emi;

  const LoanResultCard({
    super.key,
    required this.goldValue,
    required this.loanAmount,
    required this.interestAmount,
    required this.emi,
  });

  String _formatAmount(double amount) {
    return '₹${amount.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Loan Estimate',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 20),

          _buildResultRow(
            'Gold Value',
            goldValue,
          ),

          _buildResultRow(
            'Eligible Loan Amount',
            loanAmount,
          ),

          _buildResultRow(
            'Total Interest',
            interestAmount,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(),
          ),

          Text(
            'Estimated Monthly EMI',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            _formatAmount(emi),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultRow(
    String title,
    double amount,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),

          Text(
            _formatAmount(amount),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}