import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/calculator_item.dart';

class PopularCalculators extends StatelessWidget {
  final List<CalculatorItem> calculators;
  final VoidCallback? onSeeAllTap;
  final Function(CalculatorItem)? onCalculatorTap;

  const PopularCalculators({
    super.key,
    required this.calculators,
    this.onSeeAllTap,
    this.onCalculatorTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ------------------------------------------
        // SECTION HEADER
        // ------------------------------------------
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 4, 14, 8),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Popular Calculators',
                  style: TextStyle(
                    color: Color(0xFF17345C),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              InkWell(
                onTap: onSeeAllTap,
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xFFFD746C),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(width: 4),

                      Icon(
                        Icons.arrow_forward,
                        size: 14,
                        color: Color(0xFFFD746C),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // ------------------------------------------
        // CALCULATOR GRID
        // ------------------------------------------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: calculators.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (context, index) {
              final calculator = calculators[index];

              return _PopularCalculatorCard(
                calculator: calculator,
                onTap: () {
                  onCalculatorTap?.call(calculator);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// ======================================================
// POPULAR CALCULATOR CARD
// ======================================================

class _PopularCalculatorCard extends StatelessWidget {
  final CalculatorItem calculator;
  final VoidCallback? onTap;

  const _PopularCalculatorCard({required this.calculator, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 7),
          decoration: BoxDecoration(
            color: _getCardColor(calculator.id),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              SizedBox(
                width: 42,
                height: 42,
                child: SvgPicture.asset(calculator.icon, fit: BoxFit.contain),
              ),

              const SizedBox(height: 4),

              // Title
              Text(
                calculator.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF17345C),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
              ),

              // Subtitle
              Text(
                calculator.subtitle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF536985),
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCardColor(String id) {
    switch (id) {
      case 'bmi':
        return const Color(0xFFFFEDEF);

      case 'gold_loan':
        return const Color(0xFFFFF5D9);

      case 'home_loan':
        return const Color(0xFFE6F8EF);

      case 'car_loan':
        return const Color(0xFFEAF4FF);

      case 'emi':
        return const Color(0xFFF0E9FF);

      case 'sip':
        return const Color(0xFFFFECEB);

      case 'fd':
        return const Color(0xFFE4FAFA);

      case 'income_tax':
        return const Color(0xFFFFF0E6);

      default:
        return const Color(0xFFF0F2F6);
    }
  }
}
