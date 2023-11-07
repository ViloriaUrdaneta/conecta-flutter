import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api/token_manager.dart';

class AuthService {

  DateTime? lastLogin;
  final token = FCMTokenManager.instance.token;

  Future<Map<String, dynamic>> login(String username, String password) async {
    const apiUrl = 'https://api-laravel-pearl.vercel.app/login';
    

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': username,
        'password': password,
        'fcmtoken': token
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'token': data['msg'],
        'last_login': data['last_login'],
      };
    } else {
      throw Exception('Error al iniciar sesión');
    }
  }


  Future<String?> signup(String username, String password) async {
    const apiUrl = 'https://api-laravel-pearl.vercel.app/register';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': username,
        'password': password,
        'fcmtoken': token
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['token'];
    } else {
      throw Exception('Error al iniciar sesión');
    }
  }

  DateTime? getLastLogin() {
    return lastLogin;
  }

  void signOut() {
    // Eliminar el token de autenticación y realizar cualquier otra limpieza
  }
}


