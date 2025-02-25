import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_routes.dart';

class UserRepository {
  // Registration method
  Future<Map<String, dynamic>> registerUser({
    required String registrationNumber,
    required String email,
    required String password,
  }) async {
    try {
      print('Sending Register Request to: ${ApiRoutes.registerRoute}');
      print(
          'Request Body: {"email": "$email", "registrationNumber": "$registrationNumber", "password": "***"}');

      final response = await http.post(
        Uri.parse(ApiRoutes.registerRoute),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'registrationNumber': registrationNumber,
          'email': email,
          'password': password,
        }),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': responseData['message'],
          'user': responseData['user']
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Registration failed'
        };
      }
    } catch (e) {
      print('Error in registerUser: $e');
      return {'success': false, 'message': 'Connection error: ${e.toString()}'};
    }
  }

  // Login method
  Future<Map<String, dynamic>> sendOtp({
    required String email,
    required String registrationNumber,
  }) async {
    try {
      print('Sending OTP Request to: ${ApiRoutes.loginRoute}');
      print(
          'Request Body: {"email": "$email", "registrationNumber": "$registrationNumber"}');

      final response = await http.post(
        Uri.parse(ApiRoutes.loginRoute),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'registrationNumber': registrationNumber,
        }),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'],
          'otp': responseData['otp'],
          'preview': responseData['preview']
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to send OTP'
        };
      }
    } catch (e) {
      print('Error in sendOtp: $e');
      return {'success': false, 'message': 'Connection error: ${e.toString()}'};
    }
  }

  // OTP Verification method
  Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiRoutes.verifyOtpRoute),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'otp': otp,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'OTP verification failed'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Connection error: ${e.toString()}'};
    }
  }

  // Resend OTP method
  Future<Map<String, dynamic>> resendOtp({
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiRoutes.resendOtpRoute),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to resend OTP'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Connection error: ${e.toString()}'};
    }
  }
}
