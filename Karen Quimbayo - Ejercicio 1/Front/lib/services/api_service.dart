import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:3000/api_v1";

  // LOGIN
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final url = Uri.parse("$baseUrl/apiUserLogin");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "api_user": email,
          "api_password": password,
        }),
      );

      if (response.statusCode == 200) {
        return {"success": true, "data": jsonDecode(response.body)};
      } else {
        final body = jsonDecode(response.body);
        return {
          "success": false,
          "message": body["error"] ?? "Credenciales incorrectas",
        };
      }
    } catch (e) {
      return {"success": false, "message": "Error de conexión: $e"};
    }
  }

  // REGISTER
  static Future<Map<String, dynamic>> register(String user, String password) async {
    try {
      final url = Uri.parse("$baseUrl/apiUser");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user": user,
          "password": password,
          "status": "Active",
          "role": "user",
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {"success": true, "data": jsonDecode(response.body)};
      } else {
        final body = jsonDecode(response.body);
        return {
          "success": false,
          "message": body["error"] ?? "Error al registrar usuario",
        };
      }
    } catch (e) {
      return {"success": false, "message": "Error de conexión: $e"};
    }
  }
}