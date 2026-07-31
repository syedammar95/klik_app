import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:klik_app/Screens/Auth/email%20section/provider/email_authProvider.dart';
import 'package:klik_app/Screens/Auth/email%20section/with%20otp/signup_otp_screen.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/helpers/toast_utils.dart';
import 'package:provider/provider.dart';

class SignupWithEmail extends StatefulWidget {
  const SignupWithEmail({super.key});

  @override
  SignupWithEmailState createState() => SignupWithEmailState();
}

class SignupWithEmailState extends State<SignupWithEmail> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _referralController = TextEditingController();
  String countryCode = '+92';
  bool isPhoneValid = true;

  @override
  Widget build(BuildContext context) {
    print('Building..');
    final emailAuthProvider = Provider.of<EmailAuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSecureInfoBanner(),
          _buildOfferSection(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(_nameController, 'Full Name', Icons.person),
                    _buildTextField(
                        _emailController, 'Email Address', Icons.email,
                        isEmail: true),
                    _buildPhoneField(),
                    _buildTextField(_passwordController, 'Password', Icons.lock,
                        isPassword: true),
                    _buildTextField(_confirmPasswordController,
                        'Confirm Password', Icons.lock,
                        isPassword: true),
                    _buildTextField(_referralController,
                        'Referral Code (Optional)', Icons.card_giftcard),
                    SizedBox(height: 16.h),
                    _buildSignupButton(context, emailAuthProvider),
                  ],
                ),
              ),
            ),
          )
        ],
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
      title: Text('Sign Up',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22.sp,
              color: AppColors.whiteColor)),
      centerTitle: true,
    );
  }

  Widget _buildSecureInfoBanner() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
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

  Widget _buildOfferSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Container(
        width: 330.w,
        height: 80.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.primaryColor.withValues(alpha: 0.10),
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

  Widget _buildOfferItem(IconData icon, String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14.sp, color: AppColors.primaryColor),
            SizedBox(width: 8.w),
            Text(title,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
          ],
        ),
        Text(subtitle, style: TextStyle(fontSize: 10.sp)),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: IntlPhoneField(
        cursorColor: AppColors.greyColor,
        controller: _phoneController,
        initialCountryCode: 'PK',
        decoration: InputDecoration(
          labelText: 'Phone Number',
          labelStyle: const TextStyle(color: AppColors.greyColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
                color: isPhoneValid
                    ? AppColors.greyColor
                    : AppColors.secondaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
                color: isPhoneValid
                    ? AppColors.secondaryColor
                    : AppColors.primaryColor,
                width: 1.0),
          ),
        ),
        onChanged: (phone) {
          setState(() {
            countryCode = phone.countryCode;
            isPhoneValid = phone.number.isNotEmpty;
          });
        },
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, IconData icon,
      {bool isPassword = false, bool isEmail = false}) {
    return Consumer<EmailAuthProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: TextFormField(
            cursorColor: AppColors.greyColor,
            controller: controller,
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
            obscureText: isPassword
                ? (controller == _passwordController
                    ? !provider.isPasswordVisible
                    : !provider.isConfirmPasswordVisible)
                : false,
            decoration: InputDecoration(
              labelText: hint,
              labelStyle: const TextStyle(color: AppColors.greyColor),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: AppColors.greyColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                    color: AppColors.secondaryColor, width: 1.0),
              ),
              prefixIcon: Icon(icon, color: AppColors.greyColor),
              suffixIcon: isPassword
                  ? IconButton(
                      highlightColor: Colors.transparent,
                      icon: Icon(
                        controller == _passwordController
                            ? (provider.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off)
                            : (provider.isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                        color: (controller == _passwordController
                                ? provider.isPasswordVisible
                                : provider.isConfirmPasswordVisible)
                            ? AppColors
                                .lightGreenColor // ✅ Green if visibility is on
                            : AppColors
                                .secondaryColor, // ❌ Default grey if visibility is off
                      ),
                      onPressed: () {
                        if (controller == _passwordController) {
                          provider.togglePasswordVisibility();
                        } else {
                          provider.toggleConfirmPasswordVisibility();
                        }
                      },
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSignupButton(BuildContext context, EmailAuthProvider provider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: provider.isLoading
            ? null
            : () async {
                if (!_formKey.currentState!.validate()) {
                  ToastUtils.showError('Please fill all fields correctly');
                  return;
                }

                if (_passwordController.text !=
                    _confirmPasswordController.text) {
                  ToastUtils.showError('Passwords do not match');
                  return;
                }

                // 🛠️ Call API using provider
                final response = await provider.signUpUser(
                  name: _nameController.text.trim(),
                  email: _emailController.text.trim(),
                  phone: "$countryCode${_phoneController.text.trim()}",
                  countryCode: countryCode,
                  password: _passwordController.text,
                  confirmPassword: _confirmPasswordController.text,
                  deviceId: '',
                  referralCode: _referralController.text.trim(),
                );

                // 🔹 Handle API Response
                if (response == null) {
                  ToastUtils.showError(
                      'Something went wrong. Please try again.');
                  return;
                }

                // ✅ Direct API Response Check
                print('🔍 UI Response Check - Success: ${response['success']}');
                print('🔍 UI Response Check - UserId: ${response['user_id']}');
                print('🔍 UI Response Check - OtpId: ${response['otp_id']}');

                if (response['success'] == true) {
                  print('✅ UI: Signup successful, navigating to OTP screen');
                  ToastUtils.showSignupSuccess();

                  // Navigate to OTP verification screen with user details
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupOtpScreen(
                          email: _emailController.text.trim(),
                          userId: response['user_id'] ?? '',
                          otpId: response['otp_id'] ?? '',
                        ),
                      ),
                    );
                  });
                } else {
                  print('❌ UI: Signup failed - ${response['message']}');
                  ToastUtils.showAuthError(
                      response['message'] ?? 'An error occurred');
                }
              },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: AppColors.whiteColor,
          backgroundColor:
              provider.isLoading ? AppColors.greyColor : AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h),
        ),
        child: provider.isLoading
            ? const CircularProgressIndicator(color: AppColors.secondaryColor)
            : Text(
                'Sign Up',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
