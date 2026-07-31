import 'client/api_client.dart';
import 'package:flutter/foundation.dart';

/// 🔹 **Authentication Service**
class AuthService {
  final ApiClient _apiClient = ApiClient();

  /// 🔹 **Sign In**
  Future<Map<String, dynamic>?> signIn(String email, String password) async {
    return _apiClient.post('/signin.php', {
      "email": email,
      "password": password,
    });
  }

  /// 🔹 **Sign Up**
  Future<Map<String, dynamic>?> signUp({
    required String name,
    required String email,
    required String phone,
    required String countryCode,
    required String password,
    required String confirmPassword,
    required String deviceId,
    String? referralCode,
  }) async {
    return _apiClient.post('/signup.php', {
      "user_name": name,
      "email": email,
      "phone": phone,
      "country_code": countryCode,
      "password": password,
      "confirm_password": confirmPassword,
      "device_id": deviceId,
      "referral_code": referralCode ?? "",
      "verification_type": "email", // Always use email verification
    });
  }

  /// 🔹 **Request Sign-in OTP**
  Future<Map<String, dynamic>?> requestSignInOtp(String email) async {
    return _apiClient.post('/signin_otp.php', {"email": email});
  }

  /// 🔹 **Verify OTP**
  Future<Map<String, dynamic>?> verifyOtp(String email, String otp) async {
    return _apiClient.post('/verify_otp.php', {"email": email, "otp": otp});
  }

  /// 🔹 **Logout**
  Future<Map<String, dynamic>?> logout(String token) async {
    return _apiClient.post('/logout.php', {"token": token});
  }

  /// 🔹 **Verify Signup OTP**
  /// Verifies the email OTP sent during user registration.
  /// Uses the new verify_otp_signup.php endpoint with user_id and otp_code.
  Future<Map<String, dynamic>?> verifySignupOtp({
    required String userId,
    required String otpCode,
  }) async {
    debugPrint("🔄 AuthService: Verifying signup OTP for userId: $userId");

    final requestBody = {
      "user_id": userId,
      "otp_code": otpCode,
    };

    final response =
        await _apiClient.post('/verify_otp_signup.php', requestBody);
    debugPrint("📥 AuthService: Signup OTP verification response: $response");
    return response;
  }
}
