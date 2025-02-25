// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../repo/user_repo.dart';

class UserController extends GetxController {
  final UserRepository _userRepo = UserRepository();

  // Observable variables
  final Rx<bool> isLoading = false.obs;
  final Rx<String> errorMessage = ''.obs;
  final Rx<Map<String, dynamic>> userData = Rx<Map<String, dynamic>>({});
  final Rx<String> token = ''.obs;

  // Login function
  Future<bool> sendOtp(String email, String registrationNumber) async {
    try {
      print('UserController: Attempting to send OTP');
      print('Email: $email, Registration: $registrationNumber');

      isLoading.value = true;
      errorMessage.value = '';

      final response = await _userRepo.sendOtp(
        email: email,
        registrationNumber: registrationNumber,
      );

      print('UserController: Got response from sendOtp');
      print('Success: ${response['success']}');
      print('Message: ${response['message']}');

      if (response['success']) {
        userData.value = {
          'email': email,
          'registrationNumber': registrationNumber,
          'otp': response['otp'],
          'preview': response['preview']
        };
        print('UserController: OTP sent successfully');
        return true;
      } else {
        errorMessage.value = response['message'];
        print('UserController: Failed to send OTP - ${response['message']}');
        return false;
      }
    } catch (e) {
      print('UserController: Error in sendOtp - $e');
      errorMessage.value = 'Something went wrong: ${e.toString()}';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Register function
  Future<bool> register(
      {required String registrationNumber,
      required String email,
      required String password}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _userRepo.registerUser(
        registrationNumber: registrationNumber,
        email: email,
        password: password,
      );

      if (response['success']) {
        userData.value = response['user'];
        return true;
      } else {
        errorMessage.value = response['message'];
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong: ${e.toString()}';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Verify OTP function
  Future<bool> verifyOtp(String email, String otp) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _userRepo.verifyOtp(
        email: email,
        otp: otp,
      );

      if (response['success']) {
        return true;
      } else {
        errorMessage.value = response['message'];
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong: ${e.toString()}';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Resend OTP function
  Future<bool> resendOtp(String email) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _userRepo.resendOtp(
        email: email,
      );

      if (response['success']) {
        return true;
      } else {
        errorMessage.value = response['message'];
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong: ${e.toString()}';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Logout function
  void logout() {
    userData.value = {};
    token.value = '';
  }

  // Check if user is logged in
  bool get isLoggedIn => token.value.isNotEmpty;
}
