import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import '../models/equipment.dart';

class EquipmentService {
  static Future<List<Equipment>> getAllEquipment() async {
    final headers = await ApiService.getHeaders();
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/equipment'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      print('Response: ${response.body}');
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Equipment.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data equipment');
    }
  }

  static Future<Equipment> getEquipmentById(int id) async {
    final headers = await ApiService.getHeaders();
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/equipment/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Equipment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Equipment tidak ditemukan');
    }
  }

  static Future<Map<String, dynamic>> createEquipment(Map<String, dynamic> data) async {
    final headers = await ApiService.getHeaders(withAuth: true);
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/equipment'),
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

  static Future<Map<String, dynamic>> updateEquipment(int id, Map<String, dynamic> data) async {
    final headers = await ApiService.getHeaders(withAuth: true);
    final response = await http.put(
      Uri.parse('${ApiService.baseUrl}/equipment/$id'),
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

  static Future<Map<String, dynamic>> deleteEquipment(int id) async {
    final headers = await ApiService.getHeaders(withAuth: true);
    final response = await http.delete(
      Uri.parse('${ApiService.baseUrl}/equipment/$id'),
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