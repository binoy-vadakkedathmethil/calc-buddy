import 'dart:math';

import 'package:flutter/material.dart';

class CarLoanChart extends StatelessWidget {
  final double principal;
  final double interest;

  const CarLoanChart({
    super.key,
    required this.principal,
    required this.interest,
  });

  @override
  Widget build(BuildContext context) {
    final double total =
        principal + interest;

    final double principalPercentage =
        total == 0
            ? 0
            : principal / total;

    final double interestPercentage =
        total == 0
            ? 0
            : interest / total;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Breakdown',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF17345C),
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: SizedBox(
              width: 150,
              height: 150,
              child: CustomPaint(
                painter: _CarLoanChartPainter(
                  principalPercentage:
                      principalPercentage,
                  interestPercentage:
                      interestPercentage,
                ),
                child: Center(
                  child: Text(
                    '${(interestPercentage * 100).round()}%\nInterest',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight:
                          FontWeight.w700,
                      color:
                          Color(0xFF2C3E50),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _LegendItem(
                  color:
                      const Color(0xFF19A86B),
                  title: 'Principal',
                  value:
                      _formatCurrency(principal),
                ),
              ),

              Expanded(
                child: _LegendItem(
                  color:
                      const Color(0xFFFD746C),
                  title: 'Interest',
                  value:
                      _formatCurrency(interest),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double value) {
    return '₹${value.round()}';
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String title;
  final String value;

  const _LegendItem({
    required this.color,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 7),

        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),

            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight:
                    FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CarLoanChartPainter
    extends CustomPainter {
  final double principalPercentage;
  final double interestPercentage;

  _CarLoanChartPainter({
    required this.principalPercentage,
    required this.interestPercentage,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius =
        size.width / 2;

    final paint = Paint()
      ..style =
          PaintingStyle.stroke
      ..strokeWidth = 22;

    final rect =
        Rect.fromCircle(
      center: center,
      radius: radius - 12,
    );

    const startAngle = -pi / 2;

    // Principal
    paint.color =
        const Color(0xFF19A86B);

    canvas.drawArc(
      rect,
      startAngle,
      2 *
          pi *
          principalPercentage,
      false,
      paint,
    );

    // Interest
    paint.color =
        const Color(0xFFFD746C);

    canvas.drawArc(
      rect,
      startAngle +
          2 *
              pi *
              principalPercentage,
      2 *
          pi *
          interestPercentage,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(
    covariant _CarLoanChartPainter
        oldDelegate,
  ) {
    return oldDelegate
                .principalPercentage !=
            principalPercentage ||
        oldDelegate
                .interestPercentage !=
            interestPercentage;
  }
}