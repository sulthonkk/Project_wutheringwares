import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import '../models/terminal_supply.dart';

class TerminalSupplyService {
  static Future<List<TerminalSupply>> getAllTerminalSupplies() async {
    final headers = await ApiService.getHeaders();
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/terminal-supplies'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => TerminalSupply.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data terminal supplies');
    }
  }

  static Future<Map<String, dynamic>> createTerminalSupply(Map<String, dynamic> data) async {
    final headers = await ApiService.getHeaders(withAuth: true);
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/terminal-supplies'),
      headers: headers,
      body: jsonEncode(data),
    );

    final responseData = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return {'success': true};
    } else {
      return {'success': false, 'message': responseData['message']};
    }
  }

  static Future<Map<String, dynamic>> updateTerminalSupply(int id, Map<String, dynamic> data) async {
    final headers = await ApiService.getHeaders(withAuth: true);
    final response = await http.put(
      Uri.parse('${ApiService.baseUrl}/terminal-supplies/$id'),
      headers: headers,
      body: jsonEncode(data),
    );

    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      return {'success': false, 'message': responseData['message']};
    }
  }

  static Future<Map<String, dynamic>> deleteTerminalSupply(int id) async {
    final headers = await ApiService.getHeaders(withAuth: true);
    final response = await http.delete(
      Uri.parse('${ApiService.baseUrl}/terminal-supplies/$id'),
      headers: headers,
    );

    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      return {'success': false, 'message': responseData['message']};
    }
  }
}