import 'package:flutter/material.dart';

class HomeLoanInputCard extends StatelessWidget {
  final String title;
  final String value;
  final String minLabel;
  final String maxLabel;

  final IconData icon;
  final Color iconColor;

  final double sliderValue;
  final double min;
  final double max;
  final int? divisions;

  final ValueChanged<double> onChanged;

  const HomeLoanInputCard({
    super.key,
    required this.title,
    required this.value,
    required this.minLabel,
    required this.maxLabel,
    required this.icon,
    required this.iconColor,
    required this.sliderValue,
    required this.min,
    required this.max,
    required this.onChanged,
    this.divisions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------------------------------------
          // TITLE
          // ---------------------------------------------

          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ---------------------------------------------
          // VALUE
          // ---------------------------------------------

          Text(
            value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: Color(0xFF17345C),
            ),
          ),

          const SizedBox(height: 5),

          // ---------------------------------------------
          // SLIDER
          // ---------------------------------------------

          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor:
                  const Color(0xFFFD746C),

              inactiveTrackColor:
                  const Color(0xFFE5E7EB),

              thumbColor:
                  const Color(0xFFFD746C),

              overlayColor:
                  const Color(0x20FD746C),

              trackHeight: 5,

              thumbShape:
                  const RoundSliderThumbShape(
                enabledThumbRadius: 9,
              ),
            ),
            child: Slider(
              value: sliderValue,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),

          // ---------------------------------------------
          // MIN / MAX
          // ---------------------------------------------

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                minLabel,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),

              Text(
                maxLabel,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}