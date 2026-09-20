import 'package:flutter/material.dart';

import '../../shared/widgets/common/app_bottom_navigation.dart';
import '../../shared/widgets/common/app_header.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<Map<String, dynamic>> history = [
    {
      'title': 'BMI Calculator',
      'details': '70 kg, 175 cm',
      'result': '22.9',
      'date': 'Today, 10:30 AM',
      'icon': Icons.favorite,
      'color': const Color(0xFFFF6B6B),
    },
    {
      'title': 'Home Loan Calculator',
      'details': '₹50,00,000 | 20 yrs | 8.5%',
      'result': '₹43,391',
      'date': 'Today, 09:15 AM',
      'icon': Icons.home,
      'color': const Color(0xFF22B573),
    },
    {
      'title': 'Car Loan Calculator',
      'details': '₹8,00,000 | 5 yrs | 9%',
      'result': '₹16,609',
      'date': 'Yesterday, 06:20 PM',
      'icon': Icons.directions_car,
      'color': const Color(0xFF2196F3),
    },
    {
      'title': 'EMI Calculator',
      'details': '₹5,00,000 | 3 yrs | 10%',
      'result': '₹16,134',
      'date': 'Yesterday, 02:10 PM',
      'icon': Icons.percent,
      'color': const Color(0xFF9B59FF),
    },
    {
      'title': 'Gold Loan Calculator',
      'details': '₹2,00,000 | 1 yr | 9.5%',
      'result': '₹18,316',
      'date': '12 Sep 2026, 11:45 AM',
      'icon': Icons.diamond,
      'color': const Color(0xFFF5A623),
    },
    {
      'title': 'SIP Calculator',
      'details': '₹5,000 | 10 yrs | 12%',
      'result': '₹11,66,927',
      'date': '11 Sep 2026, 04:30 PM',
      'icon': Icons.savings,
      'color': const Color(0xFFFF6B6B),
    },
    {
      'title': 'Interest Calculator',
      'details': '₹1,00,000 | 5 yrs | 8%',
      'result': '₹48,989',
      'date': '10 Sep 2026, 09:15 AM',
      'icon': Icons.percent,
      'color': const Color(0xFFFF7043),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            _buildHistoryHeader(),
            Expanded(child: _buildHistoryList()),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(selectedIndex: 2),
    );
  }

  Widget _buildHistoryHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Calculation History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF17345C),
              ),
            ),
          ),
          GestureDetector(
            onTap: _clearAll,
            child: const Row(
              children: [
                Icon(Icons.delete_outline, size: 18, color: Color(0xFFFF5252)),
                SizedBox(width: 4),
                Text(
                  'Clear All',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF5252),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    if (history.isEmpty) return _buildEmptyState();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
      itemCount: history.length,
      itemBuilder: (context, index) => _buildHistoryCard(history[index]),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> item) {
    final color = item['color'] as Color;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item['icon'] as IconData, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] as String,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  item['details'] as String,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 3),
                Text(
                  item['date'] as String,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            item['result'] as String,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xFF17345C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text('No calculations yet', style: TextStyle(color: Colors.grey)),
    );
  }

  void _clearAll() {
    setState(history.clear);
  }
}
