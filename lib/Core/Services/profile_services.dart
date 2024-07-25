// services/profile_services.dart
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Models/user_profile_model.dart';

class ProfileService {
  final String baseUrl = 'http://localhost:3000/api'; // Update with your backend URL

  Future<UserProfile?> getUserProfile(String username) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/username/$username'), // Pass username as part of the URL
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserProfile.fromJson(data);
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> updateUserProfile(String username, UserProfile profile) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/username/$username'), // Pass username as part of the URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(profile.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update user profile');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
