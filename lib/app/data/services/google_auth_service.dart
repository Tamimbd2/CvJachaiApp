import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'api_service.dart';

class GoogleAuthService extends GetxService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Actual Web Client ID from Google Cloud Console
    serverClientId: '1036628247859-0o1d664qrn16suiub66j1lv5lm6lle4t.apps.googleusercontent.com',
    scopes: ['email', 'profile'],
  );

  final _storage = const FlutterSecureStorage();
  
  // Updated with the actual API endpoint from your ApiService
  final String _apiUrl = '${ApiService.baseUrl}/auth/google';

  Future<Map<String, dynamic>?> signIn() async {
    try {
      // Step 0: Sign out first to force the account picker every time
      await _googleSignIn.signOut();

      // Step 1: Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User cancelled the sign-in
      }

      // Step 2: Obtain auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception('Failed to obtain Google ID Token');
      }

      // Step 3: Send the token to your Django backend
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'token': idToken,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        // Step 4: Save the JWT access and refresh tokens to secure storage
        if (data.containsKey('access') && data.containsKey('refresh')) {
          await _storage.write(key: 'access_token', value: data['access']);
          await _storage.write(key: 'refresh_token', value: data['refresh']);
        }
        
        return data;
      } else {
        throw Exception('Backend Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _storage.delete(key: 'access_token');
      await _storage.delete(key: 'refresh_token');
    } catch (e) {
      debugPrint('Error during sign out: $e');
    }
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }
}
