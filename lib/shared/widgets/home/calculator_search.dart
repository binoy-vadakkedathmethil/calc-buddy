import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalculatorSearch extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const CalculatorSearch({
    super.key,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        10,
        0,
        10,
        16,
      ),
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFE5EAF5), 
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        onTap: onTap,
        textInputAction: TextInputAction.search,
        style: const TextStyle(
          color: Color(0xFF17345C),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Search calculators...',
          hintStyle: const TextStyle(
            color: Color(0xFF71819E),
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),

          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 10,
            ),
            child: SvgPicture.asset(
              'assets/images/icons/search_icon.svg',
              width: 20,
              height: 20,
            ),
          ),

          prefixIconConstraints: const BoxConstraints(
            minWidth: 46,
            minHeight: 48,
          ),

          border: InputBorder.none,

          enabledBorder: InputBorder.none,

          focusedBorder: InputBorder.none,

          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
        ),
      ),
    );
  }
}