import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

/// 🔹 **Network Connectivity Utility**
/// Provides methods to check internet connectivity and handle network-related errors
class NetworkConnectivity {
  static final NetworkConnectivity _instance = NetworkConnectivity._internal();
  factory NetworkConnectivity() => _instance;
  NetworkConnectivity._internal();

  /// Check if device has internet connectivity
  static Future<bool> hasInternetConnection() async {
    try {
      // Direct internet connectivity check without plugin dependency
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      final hasConnection =
          result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      debugPrint('🌐 Internet connectivity check: $hasConnection');
      return hasConnection;
    } on SocketException catch (_) {
      debugPrint('❌ Socket exception - no internet connection');
      return false;
    } on TimeoutException catch (_) {
      debugPrint('❌ Timeout - no internet connection');
      return false;
    } catch (e) {
      debugPrint('❌ Error checking internet connectivity: $e');
      // If connectivity check fails, assume we have connection and let the API call handle it
      debugPrint(
          '⚠️ Assuming connection available, letting API call handle network issues');
      return true;
    }
  }

  /// Get appropriate error message for network connectivity issues
  static String getNetworkErrorMessage(dynamic error) {
    if (error is SocketException) {
      return 'No internet connection. Please check your network settings and try again.';
    }

    if (error.toString().contains('SocketException') ||
        error.toString().contains('NetworkException') ||
        error.toString().contains('Connection refused') ||
        error.toString().contains('Failed host lookup')) {
      return 'Network connection error. Please check your internet connection and try again.';
    }

    if (error.toString().contains('timeout') ||
        error.toString().contains('Connection timeout')) {
      return 'Connection timeout. Please check your internet connection and try again.';
    }

    if (error.toString().contains('HandshakeException') ||
        error.toString().contains('CertificateException')) {
      return 'Secure connection error. Please check your network settings and try again.';
    }

    // Default network error message
    return 'Network error occurred. Please check your internet connection and try again.';
  }

  /// Check if error is network-related
  static bool isNetworkError(dynamic error) {
    final errorString = error.toString().toLowerCase();
    return errorString.contains('socket') ||
        errorString.contains('network') ||
        errorString.contains('connection') ||
        errorString.contains('timeout') ||
        errorString.contains('handshake') ||
        errorString.contains('certificate') ||
        errorString.contains('host lookup') ||
        error is SocketException;
  }

  /// Get user-friendly error message based on error type
  static String getUserFriendlyErrorMessage(dynamic error) {
    if (isNetworkError(error)) {
      return getNetworkErrorMessage(error);
    }

    // For other types of errors, return a generic message
    return 'An error occurred. Please try again.';
  }
}
