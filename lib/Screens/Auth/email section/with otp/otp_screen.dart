import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/helpers/toast_utils.dart';
import '../../../Dashboard/dashboard_page.dart';
import '../provider/email_authProvider.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen(this.email, {super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _otpCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: _buildAppBar(),
      body: Consumer<EmailAuthProvider>(
        builder: (context, authProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildPartnersText(),
              _buildSecureInfoBanner(),
              SizedBox(height: 60.h),
              _buildHeader(),
              SizedBox(height: 24.h),
              _buildOtpFields(),
              SizedBox(height: 24.h),
              _buildResendOption(authProvider),
              const Spacer(),
              _buildSignInButton(authProvider),
              SizedBox(height: 35.h),
            ],
          );
        },
      ),
    );
  }

  /// **AppBar**
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
      title: Text('OTP Verification',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22.sp,
              color: AppColors.whiteColor)),
      centerTitle: true,
    );
  }

  /// **Header Section**
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("OTP Verification",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 4.h),
        Text("Enter the OTP you received on",
            style: TextStyle(color: AppColors.greyColor, fontSize: 14.sp)),
        SizedBox(height: 4.h),

        /// get email from constructor
        Text(widget.email,
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor)),
      ],
    );
  }

  /// **Official Partner Text**
  Widget _buildPartnersText() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Text(
        'Official E-commerce Services Partner',
        style: TextStyle(color: AppColors.greyColor, fontSize: 12.sp),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// **Security Info Banner**
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

  /// **OTP Field**
  Widget _buildOtpFields() {
    return OtpTextField(
      numberOfFields: 6,
      cursorColor: AppColors.greyColor,
      focusedBorderColor: AppColors.secondaryColor,
      enabledBorderColor: AppColors.greyColor,
      fieldWidth: 40.sp,
      showFieldAsBox: true,
      textStyle: TextStyle(fontSize: 18.sp),
      borderRadius: BorderRadius.circular(10.r),
      onSubmit: (code) => setState(() => _otpCode = code),
    );
  }

  /// **Resend OTP Option**
  Widget _buildResendOption(EmailAuthProvider authProvider) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Didn't receive code?",
              style: TextStyle(color: AppColors.greyColor, fontSize: 12.sp)),
          GestureDetector(
            onTap: authProvider.isLoading
                ? null
                : () => authProvider.requestSignInOtp(widget.email),
            child: Text(
              " Resend Code",
              style: TextStyle(
                  color: AppColors.greenColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  /// **Verify OTP Button**
  Widget _buildSignInButton(EmailAuthProvider authProvider) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        fixedSize: Size(220.w, 35.h),
      ),
      onPressed: authProvider.isLoading ? null : _verifyOtp(authProvider),
      child: authProvider.isLoading
          ? const CircularProgressIndicator(color: AppColors.secondaryColor)
          : Text('Verify OTP',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteColor)),
    );
  }

  /// **OTP Verification Logic**
  VoidCallback _verifyOtp(EmailAuthProvider authProvider) {
    return () async {
      if (_otpCode.isNotEmpty) {
        final response =
            await authProvider.verifyOtp(email: widget.email, otp: _otpCode);
        if (response?['success'] == true) {
          ToastUtils.showOtpVerified();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DashboardPage()));
        } else {
          ToastUtils.showInvalidOtp();
        }
      } else {
        ToastUtils.showError("Please enter OTP");
      }
    };
  }
}
