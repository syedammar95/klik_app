import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utils/app_colors.dart';
import '../Dashboard/dashboard_page.dart';
import 'email section/signIn_withEmail.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                    _buildHeaderSection(isTablet, isLargeScreen),
                    _buildOfferSection(isTablet, isLargeScreen),
                    SizedBox(height: isTablet ? 60.h : 40.h),
                    _buildLoginOptions(context, isTablet, isLargeScreen),
                    SizedBox(height: isTablet ? 40.h : 20.h),
                    _buildTermsText(isTablet, isLargeScreen),
                    SizedBox(height: 20.h),
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
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      title: Text('Klik',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24.sp,
              color: AppColors.whiteColor)),
      centerTitle: true,
    );
  }

  /// **Header Section with Partners Text and Security Banner**
  Widget _buildHeaderSection(bool isTablet, bool isLargeScreen) {
    return Column(
      children: [
        SizedBox(height: isTablet ? 20.h : 16.h),
        _buildPartnersText(isTablet, isLargeScreen),
        SizedBox(height: isTablet ? 12.h : 8.h),
        _buildSecureInfoBanner(isTablet, isLargeScreen),
        SizedBox(height: isTablet ? 20.h : 16.h),
      ],
    );
  }

  Widget _buildPartnersText(bool isTablet, bool isLargeScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 40.w : 20.w),
      child: Text(
        'Official E-commerce Services Partner',
        style: TextStyle(
          color: AppColors.greyColor,
          fontSize: isTablet ? 14.sp : 12.sp,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// **Enhanced Secure Info Banner**
  Widget _buildSecureInfoBanner(bool isTablet, bool isLargeScreen) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isTablet ? 40.w : 20.w),
      decoration: BoxDecoration(
        color: AppColors.lightGreenColor,
        borderRadius: BorderRadius.circular(isTablet ? 12.r : 8.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.greenColor.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: isTablet ? 12.h : 8.h,
        horizontal: isTablet ? 20.w : 16.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.gpp_good,
            size: isTablet ? 22.sp : 18.sp,
            color: AppColors.greenColor,
          ),
          SizedBox(width: isTablet ? 12.w : 8.w),
          Text(
            'Your information is protected',
            style: TextStyle(
              fontSize: isTablet ? 14.sp : 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.greenColor,
            ),
          ),
        ],
      ),
    );
  }

  /// **Enhanced Offer Section**
  Widget _buildOfferSection(bool isTablet, bool isLargeScreen) {
    final maxWidth = isLargeScreen ? 600.w : (isTablet ? 500.w : 350.w);
    final containerHeight = isTablet ? 100.h : 90.h;

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        margin: EdgeInsets.symmetric(horizontal: isTablet ? 40.w : 20.w),
        height: containerHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isTablet ? 16.r : 12.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryColor.withValues(alpha: 0.15),
              AppColors.primaryColor.withValues(alpha: 0.08),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 24.w : 20.w,
            vertical: isTablet ? 16.h : 12.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildOfferItem(
                  Icons.percent,
                  'Welcome Deal',
                  'Upto 70% off',
                  isTablet,
                  isLargeScreen,
                ),
              ),
              Container(
                width: 1.w,
                height: containerHeight * 0.6,
                color: AppColors.primaryColor.withValues(alpha: 0.3),
              ),
              Expanded(
                child: _buildOfferItem(
                  Icons.local_shipping_outlined,
                  'Buyer Protection',
                  'Easy returns & refunds',
                  isTablet,
                  isLargeScreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Enhanced Offer Item**
  Widget _buildOfferItem(IconData icon, String title, String subtitle,
      bool isTablet, bool isLargeScreen) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(isTablet ? 8.w : 6.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(isTablet ? 8.r : 6.r),
              ),
              child: Icon(
                icon,
                size: isTablet ? 20.sp : 16.sp,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(width: isTablet ? 12.w : 8.w),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: isTablet ? 14.sp : 12.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        SizedBox(height: isTablet ? 8.h : 4.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: isTablet ? 12.sp : 10.sp,
            color: AppColors.greyColor,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// **Enhanced Login Options**
  Widget _buildLoginOptions(
      BuildContext context, bool isTablet, bool isLargeScreen) {
    final maxWidth = isLargeScreen ? 500.w : (isTablet ? 400.w : 320.w);

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        margin: EdgeInsets.symmetric(horizontal: isTablet ? 40.w : 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLoginButton(
              Icons.email,
              'Sign In with Email',
              AppColors.primaryColor,
              isTablet,
              isLargeScreen,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInWithEmail(),
                  ),
                );
              },
            ),
            SizedBox(height: isTablet ? 24.h : 20.h),
            _buildOrDivider(isTablet, isLargeScreen),
            SizedBox(height: isTablet ? 24.h : 20.h),
            _buildGuestButton(isTablet, isLargeScreen, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashboardPage()),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// **Enhanced Login Button**
  Widget _buildLoginButton(
    IconData icon,
    String text,
    Color color,
    bool isTablet,
    bool isLargeScreen,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: isTablet ? 56.h : 50.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.whiteColor,
          backgroundColor: color,
          elevation: 4,
          shadowColor: color.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isTablet ? 16.r : 12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: isTablet ? 24.sp : 20.sp,
            ),
            SizedBox(width: isTablet ? 12.w : 10.w),
            Text(
              text,
              style: TextStyle(
                fontSize: isTablet ? 16.sp : 14.sp,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// **Enhanced Guest Button**
  Widget _buildGuestButton(
      bool isTablet, bool isLargeScreen, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: isTablet ? 56.h : 50.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.blackColor,
          side: BorderSide(
            color: AppColors.greyColor.withValues(alpha: 0.5),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isTablet ? 16.r : 12.r),
          ),
        ),
        child: Text(
          'Continue as Guest',
          style: TextStyle(
            fontSize: isTablet ? 16.sp : 14.sp,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// **Enhanced Or Divider**
  Widget _buildOrDivider(bool isTablet, bool isLargeScreen) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.greyColor.withValues(alpha: 0.3),
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 16.w : 12.w),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 12.w : 8.w,
              vertical: isTablet ? 6.h : 4.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.scaffoldColor,
              borderRadius: BorderRadius.circular(isTablet ? 8.r : 6.r),
            ),
            child: Text(
              'OR',
              style: TextStyle(
                fontSize: isTablet ? 12.sp : 10.sp,
                color: AppColors.greyColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.greyColor.withValues(alpha: 0.3),
            thickness: 1,
          ),
        ),
      ],
    );
  }

  /// **Enhanced Terms Text**
  Widget _buildTermsText(bool isTablet, bool isLargeScreen) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isTablet ? 40.w : 20.w),
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 20.w : 16.w,
        vertical: isTablet ? 16.h : 12.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.greyColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(isTablet ? 12.r : 8.r),
        border: Border.all(
          color: AppColors.greyColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Text(
        'By registering for a Klik account, you agree that you have read and accepted our Klik Free Membership Agreement and Privacy Policy.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isTablet ? 12.sp : 10.sp,
          color: AppColors.greyColor,
          fontWeight: FontWeight.w500,
          height: 1.4,
        ),
      ),
    );
  }
}
