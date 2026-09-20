import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/gold_rate.dart';

class GoldRateService {
  static const String _apiUrl =
      'https://www.goldapi.io/api/XAU/INR';

  static const String _apiKey = 'goldapi-e09fa9f9ea06e3a5221d5827a52f5a17-io';

  Future<GoldRate> getGoldRate() async {
    final response = await http.get(
      Uri.parse(_apiUrl),
      headers: {
        'x-access-token': _apiKey,
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Unable to fetch gold rate',
      );
    }

    final data = jsonDecode(response.body);

    return GoldRate.fromJson(data);
  }
}