import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../Utils/app_colors.dart';
import '../../../../Utils/helpers/toast_utils.dart';
import '../provider/email_authProvider.dart';
import 'otp_screen.dart';

class SignInWithEmailOTP extends StatefulWidget {
  const SignInWithEmailOTP({super.key});

  @override
  State<SignInWithEmailOTP> createState() => _SignInWithEmailOTPState();
}

class _SignInWithEmailOTPState extends State<SignInWithEmailOTP> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSecureInfoBanner(),
            _buildOfferSection(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 100.h),
                  _buildEmailInputField(),
                  SizedBox(height: 20.h),
                  // ✅ Use Consumer for State Management
                  Consumer<EmailAuthProvider>(
                    builder: (context, emailAuthProvider, child) {
                      return _buildVerifyButton(emailAuthProvider);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.whiteColor,
          size: 20.sp,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text('Sign In with OTP',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22.sp,
              color: AppColors.whiteColor)),
      centerTitle: true,
    );
  }

  /// **Secure Info Banner**
  Widget _buildSecureInfoBanner() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Container(
        color: AppColors.lightGreenColor,
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.gpp_good, size: 18.sp, color: AppColors.greenColor),
            SizedBox(width: 8.w),
            Text('Your information is protected',
                style: TextStyle(fontSize: 12.sp)),
          ],
        ),
      ),
    );
  }

  /// **Offer Section**
  Widget _buildOfferSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Container(
        width: 330.w,
        height: 80.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.primaryColor.withOpacity(0.10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOfferItem(Icons.percent, 'Welcome Deal', 'Upto 70% off'),
              Container(width: 3.w, color: AppColors.whiteColor),
              _buildOfferItem(Icons.local_shipping_outlined, 'Buyer Protection',
                  'Easy returns & refunds'),
            ],
          ),
        ),
      ),
    );
  }

  /// **Offer Item**
  Widget _buildOfferItem(IconData icon, String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 14.sp, color: AppColors.primaryColor),
            SizedBox(width: 8.w),
            Text(title,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor)),
          ],
        ),
        Text(subtitle,
            style: TextStyle(fontSize: 10.sp, color: AppColors.blackColor)),
      ],
    );
  }

  /// **Email Input Field**
  Widget _buildEmailInputField() {
    return Form(
      key: _formKey,
      child: TextFormField(
        cursorColor: AppColors.greyColor,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Enter your Email",
          labelStyle: const TextStyle(color: AppColors.greyColor),
          prefixIcon: const Icon(Icons.email, color: AppColors.greyColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: AppColors.greyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide:
                const BorderSide(color: AppColors.secondaryColor, width: 1.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Email cannot be empty";
          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return "Enter a valid email";
          }
          return null;
        },
      ),
    );
  }

  /// **Verify Button**
  Widget _buildVerifyButton(EmailAuthProvider emailAuthProvider) {
    return ElevatedButton(
      onPressed: emailAuthProvider.isLoading
          ? null
          : () async {
              if (_formKey.currentState!.validate()) {
                String email = _emailController.text.trim();

                // 🔹 Call API to Request OTP
                final response =
                    await emailAuthProvider.requestSignInOtp(email);

                if (response != null &&
                    response.containsKey('success') &&
                    (response['success'] == true ||
                        response['success'] == "OTP sent to email")) {
                  ToastUtils.showOtpSent(email);
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpScreen(email),
                      ),
                    );
                  });
                } else {
                  ToastUtils.showAuthError(
                      response?['error'] ?? "OTP request failed");
                }
              }
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 50.w),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
      child: emailAuthProvider.isLoading
          ? const CircularProgressIndicator(color: AppColors.secondaryColor)
          : Text("Verify",
              style: TextStyle(fontSize: 16.sp, color: AppColors.whiteColor)),
    );
  }
}
