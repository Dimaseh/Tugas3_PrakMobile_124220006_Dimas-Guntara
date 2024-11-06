import 'package:http/http.dart' as http;
import 'dart:convert';

class BaseNetwork {
  static const String baseUrl = 'https://dattebayo-api.onrender.com/';
  static Future<List<dynamic>> getData(String endpoint) async {
    final response = await http.get(Uri.parse(baseUrl + endpoint));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data[endpoint] ?? [];
    } else {
      throw Exception("Failed to load data !");
    }
  }

  static Future<Map<String, dynamic>> getDetailData(
      String endpoint, int id) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint/$id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load data !");
    }
  }
}
