import 'package:flutter/material.dart';

import '../../../services/history_service.dart';

class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});

  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  String selectedUnit = 'Metric';

  double? bmi;
  String bmiCategory = '';

  void calculateBMI() {
    // Hide keyboard
    FocusScope.of(context).unfocus();

    final double? height = double.tryParse(heightController.text);
    final double? weight = double.tryParse(weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid height and weight'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    double calculatedBMI;

    if (selectedUnit == 'Metric') {
      final double heightInMeter = height / 100;

      calculatedBMI = weight / (heightInMeter * heightInMeter);
    } else {
      calculatedBMI = (weight * 703) / (height * height);
    }

    String category;

    if (calculatedBMI < 18.5) {
      category = 'Underweight';
    } else if (calculatedBMI < 25) {
      category = 'Normal weight';
    } else if (calculatedBMI < 30) {
      category = 'Overweight';
    } else {
      category = 'Obesity';
    }

    setState(() {
      bmi = calculatedBMI;
      bmiCategory = category;
    });

    HistoryService.add(
      title: 'BMI Calculator',
      details:
          '${heightController.text} ${selectedUnit == 'Metric' ? 'cm' : 'in'} | ${weightController.text} ${selectedUnit == 'Metric' ? 'kg' : 'lbs'}',
      result: calculatedBMI.toStringAsFixed(1),
      icon: 'favorite',
      color: 0xFFFF6B6B,
    );
  }

  void clearBMI() {
    heightController.clear();
    weightController.clear();

    setState(() {
      bmi = null;
      bmiCategory = '';
    });
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'BMI Calculator',
          style: TextStyle(
            color: Color(0xFF17345C),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF17345C)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Calculate Your BMI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF17345C),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Enter your height and weight to calculate your Body Mass Index.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 24),

            // Unit selector
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(child: _unitButton('Metric')),
                  Expanded(child: _unitButton('Imperial')),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Height
            const Text(
              'Height',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF17345C),
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: heightController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                hintText: selectedUnit == 'Metric'
                    ? 'Enter height in cm'
                    : 'Enter height in inches',
                suffixText: selectedUnit == 'Metric' ? 'cm' : 'in',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Weight
            const Text(
              'Weight',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF17345C),
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                hintText: selectedUnit == 'Metric'
                    ? 'Enter weight in kg'
                    : 'Enter weight in lbs',
                suffixText: selectedUnit == 'Metric' ? 'kg' : 'lbs',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Calculate button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFD746C),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Calculate BMI',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            if (bmi != null)
              Center(
                child: TextButton(
                  onPressed: clearBMI,
                  child: const Text(
                    'Clear',
                    style: TextStyle(color: Color(0xFF17345C)),
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // Result
            if (bmi != null) _buildResult(),

            const SizedBox(height: 20),

            _buildBmiRangeInfo(),

            // Clear button
          ],
        ),
      ),
    );
  }

  Widget _unitButton(String unit) {
    final bool selected = selectedUnit == unit;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedUnit = unit;
          bmi = null;
          bmiCategory = '';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF17345C) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            unit,
            style: TextStyle(
              color: selected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResult() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            'Your BMI',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),

          const SizedBox(height: 8),

          Text(
            bmi!.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Color(0xFF17345C),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            bmiCategory,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _getBmiCategoryColor(),
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'BMI is a general screening measure and does not by itself diagnose health conditions.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildBmiRangeInfo() {
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
          const Text(
            'BMI Range Guide',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF17345C),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Understand what your BMI result means.',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),

          const SizedBox(height: 16),

          // Underweight
          _buildBmiRangeRow(
            range: 'Below 18.5',
            title: 'Underweight',
            description: 'Below the recommended range.',
            icon: Icons.arrow_downward_rounded,
            color: const Color(0xFF3498DB),
          ),

          const SizedBox(height: 10),

          // Normal
          _buildBmiRangeRow(
            range: '18.5 – 24.9',
            title: 'Normal',
            description: 'Within the recommended healthy range.',
            icon: Icons.check_circle_rounded,
            color: const Color(0xFF27AE60),
          ),

          const SizedBox(height: 10),

          // Overweight
          _buildBmiRangeRow(
            range: '25.0 – 29.9',
            title: 'Overweight',
            description: 'Above the recommended range.',
            icon: Icons.arrow_upward_rounded,
            color: const Color(0xFFF39C12),
          ),

          const SizedBox(height: 10),

          // Obesity
          _buildBmiRangeRow(
            range: '30.0 or above',
            title: 'Obesity',
            description: 'Significantly above the recommended range.',
            icon: Icons.warning_rounded,
            color: const Color(0xFFE74C3C),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBmiRangeRow({
    required String range,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 21, color: color),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: color,
                        ),
                      ),
                    ),

                    Text(
                      range,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getBmiCategoryColor() {
    switch (bmiCategory) {
      case 'Underweight':
        return const Color(0xFF3498DB); // Blue

      case 'Normal weight':
        return const Color(0xFF27AE60); // Green

      case 'Overweight':
        return const Color(0xFFF39C12); // Orange

      case 'Obesity':
        return const Color(0xFFE74C3C); // Red

      default:
        return const Color(0xFF17345C);
    }
  }
}
