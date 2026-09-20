import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static const _storageKey = 'calculation_history';
  static const maxEntries = 10;

  static Future<List<Map<String, dynamic>>> load() async {
    final preferences = await SharedPreferences.getInstance();
    final encoded = preferences.getString(_storageKey);
    if (encoded == null) return [];

    try {
      final decoded = jsonDecode(encoded) as List<dynamic>;
      return decoded
          .whereType<Map>()
          .map((entry) => Map<String, dynamic>.from(entry))
          .toList();
    } on FormatException {
      return [];
    }
  }

  static Future<void> add({
    required String title,
    required String details,
    required String result,
    required String icon,
    required int color,
  }) async {
    final entries = await load();
    entries.insert(0, {
      'title': title,
      'details': details,
      'result': result,
      'date': _formatDate(DateTime.now()),
      'icon': icon,
      'color': color,
    });

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      _storageKey,
      jsonEncode(entries.take(maxEntries).toList()),
    );
  }

  static Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_storageKey);
  }

  static String _formatDate(DateTime date) {
    final hour = date.hour == 0 || date.hour == 12 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return 'Today, $hour:$minute $period';
  }
}
