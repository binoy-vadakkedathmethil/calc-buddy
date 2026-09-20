import 'package:flutter/material.dart';
import '../../shared/widgets/common/app_header.dart';
import '../../shared/widgets/common/app_bottom_navigation.dart';
import './data/history_data.dart';
import '../../models/calculation_history.dart';
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
      'title': 'Income Tax Calculator',
      'details': '₹12,00,000 | Old Regime',
      'result': '₹1,08,000',
      'date': '10 Sep 2026, 09:15 AM',
      'icon': Icons.receipt_long,
      'color': const Color(0xFFFF7043),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),

      // ---------------------------------------------------------
      // EXISTING APP HEADER
      // ---------------------------------------------------------
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppHeader(),
      ),

      // ---------------------------------------------------------
      // HISTORY CONTENT
      // ---------------------------------------------------------
      body: Column(
        children: [
          _buildHistoryHeader(),

          Expanded(
            child: _buildHistoryList(),
          ),
        ],
      ),

      // ---------------------------------------------------------
      // EXISTING FIXED BOTTOM NAVIGATION
      // ---------------------------------------------------------
      bottomNavigationBar: AppBottomNavigation(
        selectedIndex: 2,
      
      ),
    );
  }

  // =============================================================
  // HISTORY HEADER
  // =============================================================

  Widget _buildHistoryHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        12,
      ),
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

          // Clear All
          GestureDetector(
            onTap: _clearAll,
            child: Row(
              children: const [
                Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: Color(0xFFFF5252),
                ),
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

  // =============================================================
  // HISTORY LIST
  // =============================================================

  Widget _buildHistoryList() {
    if (history.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        12,
        0,
        12,
        20,
      ),
      itemCount: history.length,
      itemBuilder: (context, index) {
        return _buildHistoryCard(
          history[index],
          index,
        );
      },
    );
  }

  // =============================================================
  // HISTORY CARD
  // =============================================================

  Widget _buildHistoryCard(
    Map<String, dynamic> item,
    int index,
  ) {
    final Color iconColor = item['color'];

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // -------------------------------------------------------
          // ICON
          // -------------------------------------------------------

          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item['icon'],
              size: 20,
              color: iconColor,
            ),
          ),

          const SizedBox(width: 10),

          // -------------------------------------------------------
          // TITLE + DETAILS
          // -------------------------------------------------------

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF17345C),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  item['details'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 6),

          // -------------------------------------------------------
          // RESULT + DATE
          // -------------------------------------------------------

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item['result'],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF17345C),
                ),
              ),

              const SizedBox(height: 3),

              Text(
                item['date'],
                style: const TextStyle(
                  fontSize: 8,
                  color: Color(0xFF718096),
                ),
              ),
            ],
          ),

          // -------------------------------------------------------
          // MORE MENU
          // -------------------------------------------------------

          PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            iconSize: 18,
            icon: const Icon(
              Icons.more_vert,
              color: Color(0xFF718096),
            ),
            onSelected: (value) {
              if (value == 'delete') {
                setState(() {
                  history.removeAt(index);
                });
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: Colors.red,
                      ),
                      SizedBox(width: 8),
                      Text('Delete'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }

  // =============================================================
  // EMPTY STATE
  // =============================================================

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 55,
            color: Colors.grey.shade300,
          ),

          const SizedBox(height: 12),

          const Text(
            'No calculation history',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF17345C),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            'Your recent calculations will appear here.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // BOTTOM NAVIGATION
  // =============================================================

  void _onNavigationChanged(int index) {
    // AppBottomNavigation already handles navigation
    // in your existing implementation.
  }

  // =============================================================
  // CLEAR ALL
  // =============================================================

  void _clearAll() {
    if (history.isEmpty) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Clear History?',
          ),
          content: const Text(
            'Are you sure you want to clear all calculation history?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  history.clear();
                });

                Navigator.pop(context);
              },
              child: const Text(
                'Clear All',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}