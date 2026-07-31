import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../app_colors.dart';

class ToastUtils {
  /// Shows a success toast message
  static void showSuccess(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.greenColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows an error toast message
  static void showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.redColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows an info toast message
  static void showInfo(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a warning toast message
  static void showWarning(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.orangeColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a center toast message (for important notifications)
  static void showCenter(String message, {Color? backgroundColor}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      textColor: AppColors.whiteColor,
      fontSize: 16.sp,
    );
  }

  /// Shows a custom toast message
  static void showCustom({
    required String message,
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      textColor: textColor ?? AppColors.whiteColor,
      fontSize: fontSize ?? 14.sp,
    );
  }

  /// Shows a toast for cart operations
  static void showCartMessage(String message, {bool isSuccess = true}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isSuccess ? AppColors.primaryColor : AppColors.redColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a toast for checkout operations
  static void showCheckoutMessage(String message, {bool isSuccess = true}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isSuccess ? AppColors.primaryColor : AppColors.redColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a toast for order placement
  static void showOrderSuccess() {
    Fluttertoast.showToast(
      msg: 'Order placed successfully! 🎉',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.whiteColor,
      fontSize: 16.sp,
    );
  }

  /// Shows a toast for coupon application
  static void showCouponApplied(String couponCode) {
    Fluttertoast.showToast(
      msg: 'Coupon "$couponCode" applied successfully!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a toast for coupon removal
  static void showCouponRemoved() {
    Fluttertoast.showToast(
      msg: 'Coupon removed from order',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.greyColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a toast for invalid coupon
  static void showInvalidCoupon() {
    Fluttertoast.showToast(
      msg: 'Invalid coupon code. Please try again.',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: AppColors.redColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a toast for network errors
  static void showNetworkError() {
    Fluttertoast.showToast(
      msg: 'Network error. Please check your connection and try again.',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: AppColors.redColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a toast for loading states
  static void showLoading(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  // ==================== AUTHENTICATION SPECIFIC TOASTS ====================

  /// Shows a toast for successful login
  static void showLoginSuccess(String userName) {
    Fluttertoast.showToast(
      msg: 'Welcome back, $userName! 🎉',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.greenColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a toast for successful signup
  static void showSignupSuccess() {
    Fluttertoast.showToast(
      msg: 'Account created successfully! Please verify your email.',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a toast for OTP sent
  static void showOtpSent(String email) {
    Fluttertoast.showToast(
      msg: 'OTP sent to $email',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a toast for successful OTP verification
  static void showOtpVerified() {
    Fluttertoast.showToast(
      msg: 'Email verified successfully! 🎉',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.greenColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a toast for invalid OTP
  static void showInvalidOtp() {
    Fluttertoast.showToast(
      msg: 'Invalid OTP',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: AppColors.blackColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a toast for successful logout
  static void showLogoutSuccess() {
    Fluttertoast.showToast(
      msg: 'Logged out successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.greyColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a toast for authentication errors
  static void showAuthError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: AppColors.redColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a toast for password reset
  static void showPasswordResetSent(String email) {
    Fluttertoast.showToast(
      msg: 'Password reset link sent to $email',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }

  /// Shows a toast for account verification required
  static void showVerificationRequired() {
    Fluttertoast.showToast(
      msg: 'Please verify your email to continue',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: AppColors.orangeColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.sp,
    );
  }
}
