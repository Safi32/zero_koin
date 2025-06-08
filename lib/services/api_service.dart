import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ApiService {
  // Update this URL to match your backend deployment
  // For local development: 'http://localhost:5001/api'
  // For Android emulator: 'http://10.0.2.2:5001/api'
  // For iOS simulator: 'http://localhost:5001/api'
  // For production: 'https://your-backend-domain.com/api'
  static const String baseUrl = 'http://10.0.2.2:5001/api';
  
  // Sync Firebase user to MongoDB
  static Future<Map<String, dynamic>?> syncFirebaseUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('No Firebase user found');
        return null;
      }

      // Get Firebase ID token
      final idToken = await user.getIdToken();
      
      final response = await http.post(
        Uri.parse('$baseUrl/users/sync'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        print('User synced successfully: ${data['message']}');
        return data;
      } else {
        print('Failed to sync user: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error syncing user: $e');
      return null;
    }
  }

  // Get user profile from MongoDB
  static Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('No Firebase user found');
        return null;
      }

      // Get Firebase ID token
      final idToken = await user.getIdToken();
      
      final response = await http.get(
        Uri.parse('$baseUrl/users/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        print('Failed to get user profile: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error getting user profile: $e');
      return null;
    }
  }
}
