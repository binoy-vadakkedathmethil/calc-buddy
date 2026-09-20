import 'package:flutter/material.dart';

import '../../services/history_service.dart';
import '../../shared/widgets/common/app_bottom_navigation.dart';
import '../../shared/widgets/common/app_header.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> history = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final savedHistory = await HistoryService.load();
    if (!mounted) return;
    setState(() {
      history = savedHistory.map(_toDisplayEntry).toList();
      isLoading = false;
    });
  }

  Map<String, dynamic> _toDisplayEntry(Map<String, dynamic> entry) {
    return {
      ...entry,
      'icon': _iconFor(entry['icon'] as String? ?? 'percent'),
      'color': Color((entry['color'] as num?)?.toInt() ?? 0xFFFF7043),
    };
  }

  IconData _iconFor(String name) {
    return switch (name) {
      'favorite' => Icons.favorite,
      'home' => Icons.home,
      'directions_car' => Icons.directions_car,
      'diamond' => Icons.diamond,
      'savings' => Icons.savings,
      _ => Icons.percent,
    };
  }

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
            onTap: history.isEmpty ? null : _clearAll,
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
    if (isLoading) return const Center(child: CircularProgressIndicator());
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

  Future<void> _clearAll() async {
    await HistoryService.clear();
    if (!mounted) return;
    setState(() => history = []);
  }
}
