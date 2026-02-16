import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CryptoApiService {
  static const String _baseUrl = 'https://api.coingecko.com/api/v3';

  static Future<List<Map<String, dynamic>>> fetchTopCurrencies(
      {int limit = 50}) async {
    try {
      final response = await http.get(Uri.parse(
        '$_baseUrl/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=$limit&page=1&sparkline=false',
      ));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      throw Exception('Failed to fetch data from CoinGecko');
    } catch (e) {
      debugPrint('Error fetching crypto data: $e');
      return [];
    }
  }
}
