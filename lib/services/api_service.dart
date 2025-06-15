import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ApiService {
  // Update this URL to match your backend deployment
  // For local development: 'http://localhost:5001/api'
  // For Android emulator: 'http://10.0.2.2:5001/api'
  // For iOS simulator: 'http://localhost:5001/api'
  // For production: 'https://your-backend-domain.com/api'
  static const String baseUrl = 'https://zerokoinapp-production.up.railway.app/api';
  
  // Sync Firebase user to MongoDB
  static Future<Map<String, dynamic>?> syncFirebaseUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('🔍 No Firebase user found for sync operation');
        return null;
      }

      // Get Firebase ID token
      final idToken = await user.getIdToken();
      
      print('🔄 Attempting to sync user ${user.uid} to MongoDB...');
      final response = await http.post(
        Uri.parse('$baseUrl/users/sync'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        print('✅ User synced successfully: ${data['message']}');
        return data;
      } else if (response.statusCode == 401) {
        print('🔒 Authentication failed for sync: ${response.statusCode} - ${response.body}');
        return null;
      } else if (response.statusCode == 404) {
        print('❌ API endpoint not found: ${baseUrl}/users/sync');
        print('💡 Check if the backend server is running and the route is configured correctly');
        return null;
      } else {
        print('❌ Failed to sync user: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('⚠️ Error syncing user: $e');
      if (e is SocketException) {
        print('🌐 Network error: Check your internet connection or if the server is running');
      } else if (e is TimeoutException) {
        print('⏱️ Request timed out: Server may be overloaded or unreachable');
      } else if (e is FormatException) {
        print('📄 Response format error: Server returned invalid JSON');
      }
      return null;
    }
  }

  // Get user profile from MongoDB
  static Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('🔍 No Firebase user found for profile request');
        return null;
      }

      // Get Firebase ID token
      final idToken = await user.getIdToken();
      
      print('📋 Fetching profile for user ${user.uid}...');
      final response = await http.get(
        Uri.parse('$baseUrl/users/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('✅ User profile fetched successfully');
        return data;
      } else if (response.statusCode == 401) {
        print('🔒 Authentication failed for profile: ${response.statusCode} - ${response.body}');
        return null;
      } else if (response.statusCode == 404) {
        print('❌ Profile endpoint not found: ${baseUrl}/users/profile');
        print('💡 Check if the endpoint is implemented in the backend or if the server is running');
        return null;
      } else {
        print('❌ Failed to get user profile: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('⚠️ Error getting user profile: $e');
      if (e is SocketException) {
        print('🌐 Network error: Check your internet connection or if the server is running');
      } else if (e is TimeoutException) {
        print('⏱️ Request timed out: Server may be overloaded or unreachable');
      } else if (e is FormatException) {
        print('📄 Response format error: Server returned invalid JSON');
      }
      return null;
    }
  }

  // Update wallet address
  static Future<Map<String, dynamic>?> updateWalletAddress(String walletType, String address) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('🔍 No Firebase user found for wallet address update');
        return null;
      }

      // Get Firebase ID token
      final idToken = await user.getIdToken();

      print('💰 Updating $walletType wallet address: $address');
      final response = await http.put(
        Uri.parse('$baseUrl/users/wallet-address'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
        body: jsonEncode({
          'walletType': walletType,
          'address': address,
        }),
      );

      print('Wallet address update response: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ Wallet address updated successfully');
        return data;
      } else {
        print('❌ Failed to update wallet address: ${response.statusCode}');
        print('Error response: ${response.body}');
        return null;
      }
    } catch (e) {
      print('❌ Error updating wallet address: $e');
      return null;
    }
  }
}