import 'package:flutter/material.dart';

class CalculatorCategory {
  final String title;
  final String description;
  final String icon;
  final Color backgroundColor;
  final Color iconColor;

  const CalculatorCategory({
    required this.title,
    required this.description,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });
}