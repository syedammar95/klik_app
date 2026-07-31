import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klik_app/Screens/Auth/email%20section/provider/email_authProvider.dart';
import 'package:klik_app/Screens/Auth/email%20section/signup_withEmail.dart';
import 'package:klik_app/Screens/Auth/email%20section/with%20otp/signInWith_emailOtp.dart';
import 'package:provider/provider.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/helpers/toast_utils.dart';
import '../../Dashboard/dashboard_page.dart';

class SignInWithEmail extends StatefulWidget {
  const SignInWithEmail({super.key});

  @override
  State<SignInWithEmail> createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailAuthProvider = Provider.of<EmailAuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: _buildAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          final isTablet = screenWidth > 600;
          final isLargeScreen = screenWidth > 900;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    _buildSecureInfoBanner(isTablet, isLargeScreen),
                    _buildOfferSection(isTablet, isLargeScreen),
                    SizedBox(height: isTablet ? 80.h : 100.h),
                    _buildFormSection(
                        emailAuthProvider, isTablet, isLargeScreen),
                    SizedBox(height: isTablet ? 40.h : 20.h),
                  ],
                ),
              ),
            ),
          );
        },
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
      title: Text('Sign In',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22.sp,
              color: AppColors.whiteColor)),
      centerTitle: true,
    );
  }

  Widget _buildSecureInfoBanner(bool isTablet, bool isLargeScreen) {
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

  Widget _buildOfferSection(bool isTablet, bool isLargeScreen) {
    final maxWidth = isLargeScreen ? 600.w : (isTablet ? 500.w : 330.w);
    final containerHeight = isTablet ? 90.h : 80.h;

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        margin: EdgeInsets.symmetric(horizontal: isTablet ? 40.w : 12.w),
        height: containerHeight,
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

  /// **Responsive Form Section with AutofillGroup**
  Widget _buildFormSection(
      EmailAuthProvider emailAuthProvider, bool isTablet, bool isLargeScreen) {
    final maxWidth =
        isLargeScreen ? 500.w : (isTablet ? 400.w : double.infinity);

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        margin: EdgeInsets.symmetric(horizontal: isTablet ? 40.w : 16.w),
        child: AutofillGroup(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  _emailController,
                  "Email",
                  false,
                  Icons.email,
                  isTablet,
                  isLargeScreen,
                  emailAuthProvider,
                ),
                SizedBox(height: 15.h),
                _buildTextField(
                  _passwordController,
                  "Password",
                  true,
                  Icons.lock,
                  isTablet,
                  isLargeScreen,
                  emailAuthProvider,
                ),
                SizedBox(height: 20.h),
                _buildLoginButton(emailAuthProvider, isTablet, isLargeScreen),
                SizedBox(height: 20.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLoginWithEmailOTP(isTablet, isLargeScreen),
                    SizedBox(height: 15.h),
                    _buildSignupText(isTablet, isLargeScreen),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    bool obscureText,
    IconData icon,
    bool isTablet,
    bool isLargeScreen,
    EmailAuthProvider emailAuthProvider,
  ) {
    return TextFormField(
      cursorColor: AppColors.greyColor,
      controller: controller,
      obscureText: obscureText && !emailAuthProvider.isPasswordVisible,
      autofillHints: label.toLowerCase() == 'email'
          ? [AutofillHints.email]
          : [AutofillHints.password],
      textInputAction: label.toLowerCase() == 'email'
          ? TextInputAction.next
          : TextInputAction.done,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.greyColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: AppColors.greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
              const BorderSide(color: AppColors.secondaryColor, width: 1.0),
        ),
        prefixIcon: Icon(icon, color: AppColors.greyColor),
        suffixIcon: obscureText
            ? IconButton(
                icon: Icon(
                  emailAuthProvider.isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: AppColors.greyColor,
                ),
                onPressed: () => emailAuthProvider.togglePasswordVisibility(),
              )
            : null,
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter your $label' : null,
    );
  }

  Widget _buildLoginButton(
      EmailAuthProvider emailAuthProvider, bool isTablet, bool isLargeScreen) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: emailAuthProvider.isLoading
            ? null
            : _handleLogin(emailAuthProvider),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
        child: emailAuthProvider.isLoading
            ? const CircularProgressIndicator(color: AppColors.whiteColor)
            : Text("Login",
                style: TextStyle(fontSize: 14.sp, color: AppColors.whiteColor)),
      ),
    );
  }

  VoidCallback? _handleLogin(EmailAuthProvider emailAuthProvider) {
    return () async {
      if (_formKey.currentState!.validate()) {
        final response = await emailAuthProvider.loginUser(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (response != null && response["success"] == true) {
          // Show success toast with user name
          final userName = response["user"]?["name"] ?? "User";
          ToastUtils.showLoginSuccess(userName);

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DashboardPage()));
        } else {
          ToastUtils.showAuthError(response?["message"] ?? "Login failed");
        }
      }
    };
  }

  Widget _buildSignupText(bool isTablet, bool isLargeScreen) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SignupWithEmail())),
      child: Text(
        "Sign Up",
        style: TextStyle(
          color: AppColors.blackColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLoginWithEmailOTP(bool isTablet, bool isLargeScreen) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SignInWithEmailOTP())),
      child: Text(
        "Forgot password? Tap here with OTP",
        style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
