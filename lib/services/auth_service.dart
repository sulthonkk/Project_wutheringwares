import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final headers = await ApiService.getHeaders();
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/auth/login'),
      headers: headers,
      body: jsonEncode({'email': email, 'password': password}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      await ApiService.saveToken(data['token']);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(data['user']));
      return {'success': true, 'user': User.fromJson(data['user'])};
    } else {
      return {'success': false, 'message': data['message']};
    }
  }

  static Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final headers = await ApiService.getHeaders();
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/auth/register'),
      headers: headers,
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return {'success': true};
    } else {
      return {'success': false, 'message': data['message']};
    }
  }

  static Future<void> logout() async {
    await ApiService.removeToken();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  static Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userStr = prefs.getString('user');
    if (userStr != null) {
      return User.fromJson(jsonDecode(userStr));
    }
    return null;
  }
}