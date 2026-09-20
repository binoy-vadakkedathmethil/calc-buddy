import 'package:flutter/material.dart';
import '../../../models/calculator_category.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryCard extends StatelessWidget {
  final CalculatorCategory category;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: category.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 58,
            child: Row(
              children: [
                const SizedBox(width: 14),

                // Icon
                Container(
                  width: 42,
                  height: 42,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    category.icon,
                    width: 34,
                    height: 34,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(width: 12),

                // Text
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF17345C),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        category.description,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF65748B),
                        ),
                      ),
                    ],
                  ),
                ),

                // Arrow
                Icon(
                  Icons.chevron_right,
                  size: 22,
                  color: category.iconColor,
                ),

                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}