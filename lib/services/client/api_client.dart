// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../Utils/helpers/network_connectivity.dart';

/// 🔹 **Centralized API Client**
class ApiClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://ehomes.pk/API',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  ApiClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Set Content-Type based on data type
        if (options.data is FormData) {
          options.headers['Content-Type'] = 'multipart/form-data';
        } else {
          options.headers['Content-Type'] = 'application/json';
        }
        print("📤 Request: ${options.method} ${options.uri}");
        print("📝 Headers: ${options.headers}");
        print("📨 Body: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print("✅ Response [${response.statusCode}]: ${response.data}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print("❌ Dio Error: ${e.message}");
        if (e.response != null) {
          print("🔴 Error Response: ${e.response?.data}");
          print("⚠️ Status Code: ${e.response?.statusCode}");
        }
        return handler.next(e);
      },
    ));
  }

  /// GET Request
  Future<Map<String, dynamic>?> get(String path,
      {Map<String, dynamic>? queryParams}) async {
    try {
      // Check internet connectivity before making the request
      try {
        final hasConnection = await NetworkConnectivity.hasInternetConnection();
        if (!hasConnection) {
          return {
            "success": false,
            "message":
                "No internet connection. Please check your network settings and try again.",
            "isNetworkError": true
          };
        }
      } catch (connectivityError) {
        debugPrint(
            "⚠️ Connectivity check failed, proceeding with API call: $connectivityError");
        // Continue with API call if connectivity check fails
      }

      Response response = await _dio.get(path, queryParameters: queryParams);
      return _processResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// POST Request
  Future<Map<String, dynamic>?> post(String endpoint, dynamic data) async {
    try {
      // Check internet connectivity before making the request
      try {
        final hasConnection = await NetworkConnectivity.hasInternetConnection();
        if (!hasConnection) {
          return {
            "success": false,
            "message":
                "No internet connection. Please check your network settings and try again.",
            "isNetworkError": true
          };
        }
      } catch (connectivityError) {
        debugPrint(
            "⚠️ Connectivity check failed, proceeding with API call: $connectivityError");
        // Continue with API call if connectivity check fails
      }

      Response response;
      if (data is FormData) {
        // If data is FormData, send it directly without conversion
        response = await _dio.post(
          endpoint,
          data: data,
          options: Options(
            responseType: ResponseType.json,
          ),
        );
      } else {
        // For other data types, convert to JSON if needed
        final jsonData = data is Map ? jsonEncode(data) : data;
        response = await _dio.post(
          endpoint,
          data: jsonData,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
      }
      return _processResponse(response);
    } catch (e) {
      print("POST error: $e");
      return _handleError(e);
    }
  }

  /// 🔹 **PUT Request**
  Future<Map<String, dynamic>?> put(
      String path, Map<String, dynamic> data) async {
    try {
      // Check internet connectivity before making the request
      final hasConnection = await NetworkConnectivity.hasInternetConnection();
      if (!hasConnection) {
        return {
          "success": false,
          "message":
              "No internet connection. Please check your network settings and try again.",
          "isNetworkError": true
        };
      }

      Response response = await _dio.put(path, data: data);
      return _processResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// 🔹 **DELETE Request**
  Future<Map<String, dynamic>?> delete(String path,
      {Map<String, dynamic>? data}) async {
    try {
      // Check internet connectivity before making the request
      final hasConnection = await NetworkConnectivity.hasInternetConnection();
      if (!hasConnection) {
        return {
          "success": false,
          "message":
              "No internet connection. Please check your network settings and try again.",
          "isNetworkError": true
        };
      }

      Response response = await _dio.delete(
        path,
        data: data,
      );
      return _processResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// 🔹 **PATCH Request**
  Future<Map<String, dynamic>?> patch(
      String path, Map<String, dynamic> data) async {
    try {
      // Check internet connectivity before making the request
      final hasConnection = await NetworkConnectivity.hasInternetConnection();
      if (!hasConnection) {
        return {
          "success": false,
          "message":
              "No internet connection. Please check your network settings and try again.",
          "isNetworkError": true
        };
      }

      Response response = await _dio.patch(path, data: data);
      return _processResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// 🔹 **File Upload (Multipart)**
  Future<Map<String, dynamic>?> uploadFile(String path, String filePath,
      {Map<String, dynamic>? data}) async {
    try {
      // Check internet connectivity before making the request
      final hasConnection = await NetworkConnectivity.hasInternetConnection();
      if (!hasConnection) {
        return {
          "success": false,
          "message":
              "No internet connection. Please check your network settings and try again.",
          "isNetworkError": true
        };
      }

      FormData formData = FormData.fromMap({
        ...?data,
        "file": await MultipartFile.fromFile(filePath),
      });

      Response response = await _dio.post(path, data: formData);
      return _processResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// 🔹 **Test API Connectivity**
  Future<bool> testApiConnectivity() async {
    try {
      debugPrint("🔄 Testing API connectivity...");
      final response = await _dio.get('');
      debugPrint("✅ API connectivity test successful: ${response.statusCode}");
      return true;
    } catch (e) {
      debugPrint("❌ API connectivity test failed: $e");
      return false;
    }
  }

  /// 🔹 **Test SMS OTP Endpoints**
  Future<Map<String, dynamic>?> testSmsOtpEndpoints() async {
    try {
      debugPrint("🔄 Testing SMS OTP endpoints...");

      // Test request_sms_otp.php
      final testResponse = await _dio.post(
        '/request_sms_otp.php',
        data: {
          "phone": "3001234567",
          "type": "test",
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
        },
      );

      debugPrint("📥 SMS OTP endpoint test response: ${testResponse.data}");
      return {
        'success': true,
        'message': 'SMS OTP endpoints are accessible',
        'data': testResponse.data
      };
    } catch (e) {
      debugPrint("❌ SMS OTP endpoint test failed: $e");
      return {
        'success': false,
        'message': 'SMS OTP endpoints are not accessible: ${e.toString()}'
      };
    }
  }

  /// Response Handling
  Map<String, dynamic>? _processResponse(Response response) {
    dynamic responseData = response.data;
    debugPrint("Raw API Response Data: $responseData");

    if (responseData is String) {
      try {
        responseData = jsonDecode(responseData);
        debugPrint("Decoded API response: $responseData");
      } catch (e) {
        debugPrint("Error decoding API response: $e");
        return {
          "success": false,
          "message": "Error decoding the response data"
        };
      }
    }

    switch (response.statusCode) {
      case 200:
        if (responseData is Map<String, dynamic>) {
          // Ensure we have the complete response
          if (responseData.containsKey('messages') &&
              responseData['messages'] is List) {
            // For chat messages, ensure we have complete data
            final messages = responseData['messages'] as List;
            if (messages.isNotEmpty) {
              // Check if the last message is complete
              final lastMessage = messages.last;
              if (lastMessage is Map<String, dynamic> &&
                  !lastMessage.containsKey('sender_name')) {
                debugPrint(
                    "Incomplete message data detected, requesting again");
                return {"success": false, "message": "Incomplete message data"};
              }
            }
          }

          debugPrint("Returning Map response: $responseData");
          return responseData;
        } else if (responseData is List) {
          // Wrap list response in a success map
          debugPrint("Converting List response to Map: $responseData");
          return {"success": true, "data": responseData};
        }
        debugPrint("Invalid response type: ${responseData.runtimeType}");
        return {
          "success": false,
          "message":
              "Response is not a Map<String, dynamic> or List, actual type: ${responseData.runtimeType}"
        };

      case 400:
        return {
          "success": false,
          "message": "Bad request. Please check your input."
        };

      case 401:
        return {
          "success": false,
          "message": "Unauthorized. Please check your credentials."
        };

      case 404:
        return {
          "success": false,
          "message": "Resource not found. Please check the URL or endpoint."
        };

      case 500:
        return {
          "success": false,
          "message": "Server error. Please try again later."
        };

      default:
        return {
          "success": false,
          "message":
              "Unexpected error occurred. Status Code: ${response.statusCode}"
        };
    }
  }

  /// 🔹 **Error Handling**
  Map<String, dynamic>? _handleError(dynamic error) {
    // Check if it's a network connectivity error
    if (NetworkConnectivity.isNetworkError(error)) {
      return {
        "success": false,
        "message": NetworkConnectivity.getNetworkErrorMessage(error),
        "isNetworkError": true
      };
    }

    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      String message;

      switch (statusCode) {
        case 404:
          message =
              "API endpoint not found. Please check your internet connection and try again.";
          break;
        case 500:
          message = "Server error occurred. Please try again later.";
          break;
        default:
          message = error.response?.data?["message"] ?? "Server error occurred";
      }

      return {
        "success": false,
        "message": message,
        "statusCode": statusCode ?? 500
      };
    }
    return {"success": false, "message": "Unexpected error occurred"};
  }
}
