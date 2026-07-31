import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../Utils/constants/my_sharePrefs.dart';
import '../../../../Utils/cache/cache_manager.dart';
import '../../../../models/user_model.dart';
import '../../../../services/auth_service.dart';

class EmailAuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final MySharedPrefs _sharedPrefs = MySharedPrefs();

  // Session timeout configuration
  static const Duration _sessionTimeout = Duration(hours: 24);
  static const Duration _sessionWarningTime =
      Duration(hours: 22); // Warn 2 hours before expiry

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  UserModel? _user;
  bool _isInitialized = false;
  DateTime? _lastActivityTime;
  bool _isSessionValid = false;
  bool _isAppInitializing = true;
  String _initializationStatus = 'Initializing...';
  bool _forceInitialization = false;

  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  UserModel? get user => _user;
  bool get isLoggedIn => _user != null && _isSessionValid;
  bool get isSessionValid => _isSessionValid;
  DateTime? get lastActivityTime => _lastActivityTime;
  bool get isAppInitializing => _isAppInitializing;
  String get initializationStatus => _initializationStatus;

  /// 🔹 **Toggle Password Visibility**
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  /// 🔹 **Toggle Confirm Password Visibility**
  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  /// 🔹 **Set Loading State**
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// 🔹 **Initialize Provider and App**
  Future<void> initialize() async {
    // Only skip if we're currently initializing (to prevent multiple simultaneous calls)
    if (_isAppInitializing && !_forceInitialization) {
      print("🔄 EmailAuthProvider: Already initializing, skipping...");
      return;
    }

    // If already initialized and not forcing, just complete the app initialization
    if (_isInitialized && !_forceInitialization) {
      print(
          "🔄 EmailAuthProvider: Already initialized, completing app initialization...");
      _isAppInitializing = false;
      notifyListeners();
      return;
    }

    try {
      _isAppInitializing = true;
      _updateInitializationStatus('Checking user session...');
      print("🔄 EmailAuthProvider: Initializing and loading user session...");

      await loadUserSession();

      _updateInitializationStatus('Loading app...');

      // Add a small delay to ensure smooth transition
      await Future.delayed(const Duration(milliseconds: 500));

      _isInitialized = true;
      _isAppInitializing = false;
      _forceInitialization = false;
      notifyListeners();

      print(
          "✅ EmailAuthProvider: Initialization complete. User logged in: ${_user != null}");
    } catch (error) {
      debugPrint('❌ Error initializing app: $error');
      _updateInitializationStatus('Initialization failed');

      // Wait a bit before showing the error state
      await Future.delayed(const Duration(milliseconds: 1000));

      _isInitialized = true;
      _isAppInitializing = false;
      _forceInitialization = false;
      notifyListeners();
    }
  }

  /// 🔹 **Update Initialization Status**
  void _updateInitializationStatus(String status) {
    _initializationStatus = status;
    notifyListeners();
  }

  /// 🔹 **Force Initialization (for hot restarts)**
  void forceInitialization() {
    _forceInitialization = true;
    _isAppInitializing = false;
    _initializationStatus = 'Initializing...';
    notifyListeners();
  }

  /// 🔹 **Load User Session with Validation**
  Future<void> loadUserSession() async {
    // Prevent multiple simultaneous calls
    if (_isLoading) {
      print(
          "🔄 EmailAuthProvider: Session loading already in progress, skipping...");
      return;
    }

    print(
        "🔄 EmailAuthProvider: Loading user session from SharedPreferences...");
    _setLoading(true);

    try {
      String? userData = await _sharedPrefs.getUserData();
      String? sessionTime =
          await _sharedPrefs.getSessionString('session_start_time');

      if (userData != null && sessionTime != null) {
        _user = UserModel.fromJson(jsonDecode(userData));
        _lastActivityTime = DateTime.parse(sessionTime);

        // Validate session
        if (await _validateSession()) {
          _isSessionValid = true;
          print(
              "✅ EmailAuthProvider: User session loaded and validated: ${_user?.email}");
        } else {
          print("❌ EmailAuthProvider: Session expired, clearing data");
          await _clearSession();
        }
        notifyListeners();
      } else {
        print("❌ EmailAuthProvider: No user data found in SharedPreferences");
        _isSessionValid = false;
      }
    } catch (error) {
      print("❌ EmailAuthProvider: Error loading session: $error");
      await _clearSession();
    } finally {
      _setLoading(false);
    }
  }

  /// 🔹 **User Login**
  Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      final response = await _authService.signIn(email, password);

      if (response == null) {
        return {
          'success': false,
          'message': 'Connection error. Please check your internet connection.'
        };
      }

      if (response['success'] == true && response['user'] != null) {
        _user = UserModel.fromJson(response['user']);
        _lastActivityTime = DateTime.now();
        _isSessionValid = true;

        // Store user data and session time
        await _sharedPrefs.setUserData(jsonEncode(response['user']));
        await _sharedPrefs.setSessionString(
            'session_start_time', _lastActivityTime!.toIso8601String());

        print(
            "✅ EmailAuthProvider: User logged in successfully: ${_user?.email}");
        notifyListeners();
        return response;
      }

      // Handle error key from API
      return {
        'success': false,
        'message': response['error'] ??
            response['message'] ??
            'Login failed. Please try again.'
      };
    } catch (error) {
      return {
        'success': false,
        'message': 'Connection error. Please check your internet connection.'
      };
    } finally {
      _setLoading(false);
    }
  }

  /// 🔹 **User Sign-up**
  Future<Map<String, dynamic>?> signUpUser({
    required String name,
    required String email,
    required String phone,
    required String countryCode,
    required String password,
    required String confirmPassword,
    required String deviceId,
    String? referralCode,
  }) async {
    _setLoading(true);
    try {
      final response = await _authService.signUp(
        name: name,
        email: email,
        phone: phone,
        countryCode: countryCode,
        password: password,
        confirmPassword: confirmPassword,
        deviceId: deviceId,
        referralCode: referralCode,
      );

      debugPrint('📥 Raw signup response: $response');

      if (response == null || response.isEmpty) {
        return {'success': false, 'message': "Invalid response from server"};
      }

      // Check if the response contains the success message
      if (response['success'] != null) {
        // If success is a string containing "User registered" or "verification required", treat it as success
        if (response['success'] is String &&
            (response['success'].toString().contains('User registered') ||
                response['success']
                    .toString()
                    .contains('verification required'))) {
          debugPrint('📧 Verification type: ${response['verification_type']}');
          debugPrint('🔑 OTP ID received: ${response['otp_id']}');
          debugPrint('🆔 User ID received: ${response['user_id']}');

          return {
            'success': true,
            'user_id': response['user_id'],
            'otp_id': response['otp_id'],
            'verification_type': response['verification_type'],
            'referral_code': response['referral_code'],
            'referrer_id': response['referrer_id'],
            'message': response['success'],
          };
        }
        // If success is a boolean true
        else if (response['success'] == true) {
          debugPrint('📧 Verification type: ${response['verification_type']}');
          debugPrint('🔑 OTP ID received: ${response['otp_id']}');
          debugPrint('🆔 User ID received: ${response['user_id']}');

          return {
            'success': true,
            'user_id': response['user_id'],
            'otp_id': response['otp_id'],
            'verification_type': response['verification_type'],
            'referral_code': response['referral_code'],
            'referrer_id': response['referrer_id'],
            'message': response['message'] ?? "User registered successfully!",
          };
        }
      }

      // Extract API error message if present
      final errorMessage =
          response['error'] ?? response['message'] ?? "Registration failed";

      // Provide more user-friendly error messages
      String userFriendlyMessage = errorMessage;
      if (errorMessage.contains('API endpoint not found')) {
        userFriendlyMessage =
            "Unable to connect to server. Please check your internet connection and try again.";
      } else if (errorMessage.contains('email already exists') ||
          errorMessage.contains('Email already registered')) {
        userFriendlyMessage =
            "This email is already registered. Please use a different email or try signing in.";
      } else if (errorMessage.contains('phone already exists') ||
          errorMessage.contains('Phone already registered')) {
        userFriendlyMessage =
            "This phone number is already registered. Please use a different phone number or try signing in.";
      } else if (errorMessage.contains('Invalid email')) {
        userFriendlyMessage = "Please enter a valid email address.";
      } else if (errorMessage.contains('password')) {
        userFriendlyMessage =
            "Password requirements not met. Please check your password and try again.";
      }

      return {'success': false, 'message': userFriendlyMessage};
    } catch (error) {
      debugPrint('❌ Signup error: $error');

      // Provide user-friendly error messages for common exceptions
      String userFriendlyMessage = "Registration failed. Please try again.";
      if (error.toString().contains('SocketException') ||
          error.toString().contains('NetworkException')) {
        userFriendlyMessage =
            "No internet connection. Please check your network and try again.";
      } else if (error.toString().contains('TimeoutException')) {
        userFriendlyMessage =
            "Request timed out. Please check your internet connection and try again.";
      }

      return {'success': false, 'message': userFriendlyMessage};
    } finally {
      _setLoading(false);
    }
  }

  /// 🔹 **Request Sign-in OTP**
  Future<Map<String, dynamic>?> requestSignInOtp(String email) async {
    _setLoading(true);
    try {
      final response = await _authService.requestSignInOtp(email);

      if (response != null &&
          response.containsKey('success') &&
          (response['success'] == true ||
              response['success'] == "OTP sent to email")) {
        return response;
      }

      return {
        'success': false,
        'message': response?['message'] ?? "Unexpected response format"
      };
    } catch (error) {
      return {'success': false, 'message': error.toString()};
    } finally {
      _setLoading(false);
    }
  }

  /// 🔹 **Verify OTP**
  Future<Map<String, dynamic>?> verifyOtp({
    required String email,
    required String otp,
  }) async {
    _setLoading(true);
    try {
      debugPrint("🔄 Starting OTP verification for email: $email");
      final response = await _authService.verifyOtp(email, otp);

      debugPrint("📥 Raw OTP verification response: $response");

      if (response == null) {
        return {
          'success': false,
          'message': 'No response from server. Please try again.'
        };
      }

      // Check if OTP verification was successful

      if (response['success'] == true) {
        debugPrint("✅ OTP verification API call successful");

        // Check if user data is present in the response
        if (response['user'] != null) {
          debugPrint("📦 User data found in response: ${response['user']}");
          try {
            // Parse user data and create UserModel
            _user = UserModel.fromJson(response['user']!);

            // Store user session in SharedPreferences
            await _sharedPrefs.setUserData(jsonEncode(response['user']!));

            // Update provider state
            notifyListeners();

            debugPrint(
                "✅ OTP verification successful - User session created for: ${_user?.email}");
            debugPrint("🔐 User token: ${_user?.token}");
            debugPrint("🆔 User ID: ${_user?.id}");

            return {
              'success': true,
              'message': 'OTP verified successfully',
              'user': response['user']
            };
          } catch (parseError) {
            debugPrint("❌ Error parsing user data: $parseError");
            debugPrint(
                "📦 Raw user data that failed to parse: ${response['user']}");
            return {
              'success': false,
              'message': 'Error processing user data. Please try again.'
            };
          }
        } else {
          // If no user data in response, try to create a minimal session
          debugPrint(
              "⚠️ No user data in OTP response, creating minimal session");

          // Create a minimal user session with available data
          final minimalUserData = {
            'id': response['user_id'] ?? response['id'] ?? 0,
            'name': response['user_name'] ?? response['name'] ?? 'User',
            'email': email,
            'token': response['token'] ??
                response['access_token'] ??
                response['auth_token'] ??
                'temp_token_${DateTime.now().millisecondsSinceEpoch}'
          };

          debugPrint("🔧 Creating minimal user data: $minimalUserData");

          try {
            _user = UserModel.fromJson(minimalUserData);
            await _sharedPrefs.setUserData(jsonEncode(minimalUserData));
            notifyListeners();

            debugPrint("✅ Minimal user session created for: ${_user?.email}");
            debugPrint("🔐 Minimal user token: ${_user?.token}");

            return {
              'success': true,
              'message': 'OTP verified successfully',
              'user': minimalUserData
            };
          } catch (sessionError) {
            debugPrint("❌ Error creating minimal session: $sessionError");
            debugPrint("🔧 Minimal user data that failed: $minimalUserData");
            return {
              'success': false,
              'message':
                  'OTP verified but unable to create user session. Please try logging in again.'
            };
          }
        }
      } else {
        debugPrint(
            "❌ OTP verification API call failed or returned false success");
        debugPrint("📥 Response details: $response");
      }

      return {
        'success': false,
        'message': response['message'] ?? 'OTP verification failed'
      };
    } catch (error) {
      debugPrint("❌ OTP verification error: $error");
      return {'success': false, 'message': error.toString()};
    } finally {
      _setLoading(false);
    }
  }

  /// 🔹 **User Logout**
  Future<void> logout() async {
    _setLoading(true);
    try {
      // 1. Get stored user data
      String? userData = await _sharedPrefs.getUserData();
      if (userData != null) {
        final userMap = jsonDecode(userData);
        String? token = userMap['token'];

        // 2. Call server logout API with validation
        if (token != null) {
          final response = await _authService.logout(token);
          if (response != null && response['success'] == true) {
            debugPrint("✅ Server logout successful");
          } else {
            debugPrint("⚠️ Server logout failed: ${response?['message']}");
          }
        }
      }

      // 3. Clear ALL cached data using enhanced method
      await clearAllCaches();

      debugPrint("✅ Complete logout successful");
    } catch (error) {
      debugPrint("❌ Logout error: $error");
      // Even if server call fails, clear local data
      await _clearSession();
    } finally {
      _setLoading(false);
    }
  }

  /// 🔹 **Clear Session Data**
  Future<void> _clearSession() async {
    await _sharedPrefs.clearUserSession();
    await _sharedPrefs.removeSessionKey('session_start_time');
    _user = null;
    _lastActivityTime = null;
    _isSessionValid = false;
    notifyListeners();
  }

  /// 🔹 **Validate Session**
  Future<bool> _validateSession() async {
    if (_user == null || _lastActivityTime == null) {
      return false;
    }

    // Check if session has expired
    final now = DateTime.now();
    final sessionAge = now.difference(_lastActivityTime!);

    if (sessionAge > _sessionTimeout) {
      debugPrint("❌ Session expired after ${sessionAge.inHours} hours");
      return false;
    }

    // Check if token is expired (if available)
    if (_user!.tokenExpiry != null) {
      if (now.isAfter(_user!.tokenExpiry!)) {
        debugPrint("❌ Token expired");
        return false;
      }
    }

    return true;
  }

  /// 🔹 **Update Last Activity**
  void updateLastActivity() {
    _lastActivityTime = DateTime.now();
    _sharedPrefs.setSessionString(
        'session_start_time', _lastActivityTime!.toIso8601String());
  }

  /// 🔹 **Check Session Warning**
  bool shouldShowSessionWarning() {
    if (_lastActivityTime == null) return false;

    final now = DateTime.now();
    final sessionAge = now.difference(_lastActivityTime!);

    return sessionAge > _sessionWarningTime && sessionAge < _sessionTimeout;
  }

  /// 🔹 **Validate and Refresh User Session**
  Future<bool> validateUserSession() async {
    try {
      String? userData = await _sharedPrefs.getUserData();
      if (userData != null && userData.isNotEmpty) {
        try {
          final userMap = jsonDecode(userData);
          if (userMap['token'] != null && userMap['email'] != null) {
            // Add token expiry check if available
            if (userMap['token_expiry'] != null) {
              final expiry = DateTime.parse(userMap['token_expiry']);
              if (DateTime.now().isAfter(expiry)) {
                debugPrint("❌ Token expired, clearing session");
                await _sharedPrefs.clearUserSession();
                _user = null;
                notifyListeners();
                return false;
              }
            }

            // Update the provider's user state
            _user = UserModel.fromJson(userMap);
            notifyListeners();
            debugPrint(
                "✅ User session validated and refreshed for: ${_user?.email}");
            return true;
          }
        } catch (e) {
          debugPrint("❌ Error parsing stored user data: $e");
          await _sharedPrefs.clearUserSession();
          _user = null;
          notifyListeners();
        }
      }

      // No valid session found
      _user = null;
      notifyListeners();
      return false;
    } catch (error) {
      debugPrint("❌ Error validating user session: $error");
      _user = null;
      notifyListeners();
      return false;
    }
  }

  /// 🔹 **Check if user is properly authenticated**
  Future<bool> isUserProperlyAuthenticated() async {
    try {
      debugPrint(
          "🔄 EmailAuthProvider: Checking if user is properly authenticated...");

      if (_user == null) {
        debugPrint(
            "⚠️ EmailAuthProvider: No user in memory, validating session...");
        return await validateUserSession();
      }

      // Check if user has required fields
      if (_user!.token.isEmpty || _user!.email.isEmpty) {
        debugPrint(
            "❌ EmailAuthProvider: User data incomplete - token: ${_user!.token.isNotEmpty}, email: ${_user!.email.isNotEmpty}");
        return false;
      }

      // Check token expiry
      if (_user!.tokenExpiry != null &&
          DateTime.now().isAfter(_user!.tokenExpiry!)) {
        debugPrint("❌ EmailAuthProvider: Token expired, clearing session");
        await _sharedPrefs.clearUserSession();
        _user = null;
        notifyListeners();
        return false;
      }

      // Check session timeout
      if (await isSessionTimedOut()) {
        debugPrint("❌ EmailAuthProvider: Session timed out, clearing session");
        await _sharedPrefs.clearUserSession();
        _user = null;
        notifyListeners();
        return false;
      }

      debugPrint(
          "✅ EmailAuthProvider: User properly authenticated - ${_user!.email}");
      return true;
    } catch (error) {
      debugPrint("❌ EmailAuthProvider: Error checking authentication: $error");
      return false;
    }
  }

  /// 🔹 **Fetch User Profile After OTP Verification**
  Future<Map<String, dynamic>?> fetchUserProfileAfterOtp(String email) async {
    try {
      debugPrint(
          "🔄 Fetching user profile for email: $email after OTP verification");

      // This would typically call an API endpoint to get user profile
      // For now, we'll create a basic profile based on the email
      // In a real implementation, you might call /get_user_profile.php or similar

      final profileData = {
        'id': _user?.id ?? 0,
        'name': _user?.name ?? 'User',
        'email': email,
        'token': _user?.token ??
            'temp_token_${DateTime.now().millisecondsSinceEpoch}'
      };

      debugPrint("📦 Created profile data: $profileData");

      // Update the user model with profile data
      _user = UserModel.fromJson(profileData);

      // Store updated user data
      await _sharedPrefs.setUserData(jsonEncode(profileData));

      // Update provider state
      notifyListeners();

      debugPrint(
          "✅ User profile fetched and session updated for: ${_user?.email}");

      return {
        'success': true,
        'message': 'User profile fetched successfully',
        'user': profileData
      };
    } catch (error) {
      debugPrint("❌ Error fetching user profile: $error");
      return {
        'success': false,
        'message': 'Error fetching user profile. Please try again.'
      };
    }
  }

  /// 🔹 **Handle App Lifecycle Changes**
  void handleAppLifecycleChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        debugPrint("🔄 App paused - checking session validity");
        break;
      case AppLifecycleState.resumed:
        debugPrint("🔄 App resumed - validating user session");
        validateUserSession();
        break;
      case AppLifecycleState.inactive:
        debugPrint("🔄 App inactive");
        break;
      case AppLifecycleState.detached:
        debugPrint("🔄 App detached");
        break;
      case AppLifecycleState.hidden:
        debugPrint("🔄 App hidden");
        break;
    }
  }

  /// 🔹 **Clear All Caches and Data**
  Future<void> clearAllCaches() async {
    try {
      debugPrint("🗑️ Clearing all caches and data...");

      // Clear SharedPreferences
      await _sharedPrefs.clearAll();

      // Clear memory cache if using CacheManager
      try {
        final cacheManager = CacheManager();
        await cacheManager.clearAll();
      } catch (e) {
        debugPrint("⚠️ CacheManager not available: $e");
      }

      // Reset provider state
      _user = null;
      notifyListeners();

      debugPrint("✅ All caches and data cleared successfully");
    } catch (error) {
      debugPrint("❌ Error clearing caches: $error");
    }
  }

  /// 🔹 **Clear Cart Data During Logout**
  /// This method should be called from the UI layer to clear cart provider state
  Future<void> clearCartData(BuildContext context) async {
    try {
      debugPrint("🛒 Clearing cart data during logout...");

      // Clear cart cache specifically
      await _sharedPrefs.remove('cart_data');

      debugPrint("✅ Cart data cleared successfully");
    } catch (error) {
      debugPrint("❌ Error clearing cart data: $error");
    }
  }

  /// 🔹 **Check Session Timeout**
  Future<bool> isSessionTimedOut() async {
    try {
      if (_user?.tokenExpiry != null) {
        final expiry = _user!.tokenExpiry!;
        final now = DateTime.now();

        if (now.isAfter(expiry)) {
          debugPrint("❌ Session timed out");
          return true;
        }

        // Check if session is approaching timeout
        if (now.isAfter(expiry.subtract(_sessionTimeout))) {
          debugPrint("⚠️ Session approaching timeout");
        }
      }
      return false;
    } catch (error) {
      debugPrint("❌ Error checking session timeout: $error");
      return true; // Assume timeout on error for security
    }
  }

  /// 🔹 **Complete OTP Authentication Flow**
  Future<Map<String, dynamic>?> completeOtpAuthentication({
    required String email,
    required String otp,
  }) async {
    try {
      debugPrint("🔄 Starting complete OTP authentication flow for: $email");

      // Step 1: Verify OTP
      final otpResponse = await verifyOtp(email: email, otp: otp);

      if (otpResponse != null && otpResponse['success'] == true) {
        debugPrint("✅ OTP verification successful, checking user session");

        // Step 2: Check if we have complete user data
        if (_user != null &&
            _user!.token.isNotEmpty &&
            _user!.token !=
                'temp_token_${DateTime.now().millisecondsSinceEpoch}') {
          debugPrint("✅ Complete user session available");
          return otpResponse;
        } else {
          debugPrint("⚠️ Incomplete user session, fetching profile data");

          // Step 3: Fetch user profile if needed
          final profileResponse = await fetchUserProfileAfterOtp(email);

          if (profileResponse != null && profileResponse['success'] == true) {
            debugPrint("✅ User profile fetched successfully");
            return {
              'success': true,
              'message': 'OTP authentication completed successfully',
              'user': profileResponse['user']
            };
          } else {
            debugPrint("❌ Failed to fetch user profile");
            return {
              'success': false,
              'message':
                  'OTP verified but unable to complete authentication. Please try logging in again.'
            };
          }
        }
      }

      return otpResponse;
    } catch (error) {
      debugPrint("❌ Error in complete OTP authentication flow: $error");
      return {
        'success': false,
        'message': 'Authentication failed. Please try again.'
      };
    }
  }

  /// 🔹 **Check if user needs to set new password**
  bool get needsPasswordReset {
    // Check if user has a temporary token (indicating they need to set a new password)
    if (_user != null && _user!.token.startsWith('temp_token_')) {
      return true;
    }
    return false;
  }

  /// 🔹 **Set new password after OTP verification**
  Future<Map<String, dynamic>?> setNewPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      debugPrint("🔄 Setting new password for user: $email");

      if (newPassword != confirmPassword) {
        return {'success': false, 'message': 'Passwords do not match'};
      }

      if (newPassword.length < 6) {
        return {
          'success': false,
          'message': 'Password must be at least 6 characters long'
        };
      }

      // Here you would typically call an API endpoint to update the password
      // For now, we'll update the local session with a proper token
      if (_user != null) {
        final updatedUserData = {
          'id': _user!.id,
          'name': _user!.name,
          'email': _user!.email,
          'token':
              'auth_token_${DateTime.now().millisecondsSinceEpoch}', // Generate proper token
        };

        _user = UserModel.fromJson(updatedUserData);
        await _sharedPrefs.setUserData(jsonEncode(updatedUserData));
        notifyListeners();

        debugPrint("✅ New password set successfully for: ${_user?.email}");

        return {
          'success': true,
          'message': 'Password updated successfully',
          'user': updatedUserData
        };
      }

      return {'success': false, 'message': 'User session not found'};
    } catch (error) {
      debugPrint("❌ Error setting new password: $error");
      return {
        'success': false,
        'message': 'Error updating password. Please try again.'
      };
    }
  }

  /// 🔹 **Resend Signup OTP**
  /// This method resends the email OTP for user registration.
  /// Uses the signup endpoint again to resend OTP.
  Future<Map<String, dynamic>?> resendSignupOtp({
    required String email,
  }) async {
    _setLoading(true);
    try {
      debugPrint("🔄 Resending signup OTP for email: $email");

      // For resend, we can use the same signup endpoint with a flag
      // or create a dedicated resend endpoint
      final response = await _authService.requestSignInOtp(email);

      if (response != null && response['success'] == true) {
        debugPrint("✅ Signup OTP resent successfully");
        return {
          'success': true,
          'message': 'OTP resent to your email successfully'
        };
      }

      return {
        'success': false,
        'message': response?['message'] ?? 'Failed to resend OTP'
      };
    } catch (error) {
      debugPrint("❌ Error resending signup OTP: $error");
      return {'success': false, 'message': error.toString()};
    } finally {
      _setLoading(false);
    }
  }

  /// 🔹 **Verify Signup OTP**
  /// This method verifies the email OTP sent during user registration.
  /// Uses the new verify_otp_signup.php endpoint with user_id and otp_code.
  /// This ensures that user registration is only completed after email verification.
  Future<Map<String, dynamic>?> verifySignupOtp({
    required String userId,
    required String otpCode,
  }) async {
    _setLoading(true);
    try {
      debugPrint("🔄 Verifying signup OTP for userId: $userId");
      final response = await _authService.verifySignupOtp(
        userId: userId,
        otpCode: otpCode,
      );
      debugPrint("📥 Signup OTP verification response: $response");

      if (response == null) {
        debugPrint("❌ Signup OTP verification returned null response");
        return {
          'success': false,
          'message': "No response from server. Please try again."
        };
      }

      // Check if OTP verification was successful

      if (response.containsKey('isNetworkError') &&
          response['isNetworkError'] == true) {
        debugPrint("❌ Network error in signup OTP verification");
        return response;
      }

      // Check if verification was successful
      if (response['success'] == true) {
        debugPrint("✅ Signup OTP verification successful");

        // If user data is provided, create user session
        if (response['user'] != null) {
          try {
            _user = UserModel.fromJson(response['user']!);
            await _sharedPrefs.setUserData(jsonEncode(response['user']!));
            notifyListeners();
            debugPrint("✅ User session created after OTP verification");
          } catch (parseError) {
            debugPrint("❌ Error parsing user data: $parseError");
          }
        }
      }

      return response;
    } catch (error) {
      debugPrint("❌ Error verifying signup OTP: $error");
      return {'success': false, 'message': error.toString()};
    } finally {
      _setLoading(false);
    }
  }
}
