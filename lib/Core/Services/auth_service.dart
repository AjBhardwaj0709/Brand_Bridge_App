import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'authToken';

  //Login user
  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        await _saveToken(token);
        return token;
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['msg'] ??
            'Failed to login. Status code: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception(
          'Network error. Please check your internet connection: $e');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  //sign Up User
  Future<String?> signUpUser({
  required String username,
  required String name,
  required String email,
  required String password,
}) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['token'] == null) {
        throw Exception('Token is null');
      }

      final token = data['token'];
      await _saveToken(token);
      return token;
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(errorBody['msg'] ?? 
          'Failed to sign up. Status code: ${response.statusCode}');
    }
  } on http.ClientException catch (e) {
    throw Exception('Network error. Please check your internet connection: $e');
  } catch (e) {
    throw Exception('An unexpected error occurred: $e');
  }
}

  Future<void> logoutUser() async {
    try {
      // If you have a logout endpoint, you can call it here
      // final response = await http.post(
      //   Uri.parse('http://192.168.133.219:3000/api/logout'),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //     'Authorization': 'Bearer ${await getToken()}',
      //   },
      // );

      // if (response.statusCode == 200) {
      //   await _clearToken();
      // } else {
      //   throw Exception('Failed to logout. Status code: ${response.statusCode}');
      // }

      // If you don't have a logout endpoint, just clear the token
      await _clearToken();
    } catch (e) {
      throw Exception('An unexpected error occurred during logout: $e');
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
