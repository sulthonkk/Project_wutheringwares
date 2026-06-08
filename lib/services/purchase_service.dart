import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class PurchaseService {
  static Future<Map<String, dynamic>> createPurchase({
    int? equipmentId,
    int? terminalSupplyId,
    required int quantity,
    required String itemType,
  }) async {
    final headers = await ApiService.getHeaders(withAuth: true);
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/purchase'),
      headers: headers,
      body: jsonEncode({
        'equipment_id': equipmentId,
        'terminal_supply_id': terminalSupplyId,
        'quantity': quantity,
        'item_type': itemType,
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return {'success': true, 'total_price': data['total_price']};
    } else {
      return {'success': false, 'message': data['message']};
    }
  }

  static Future<List<dynamic>> getPurchaseHistory() async {
    final headers = await ApiService.getHeaders(withAuth: true);
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/purchase/history'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil history pembelian');
    }
  }
}