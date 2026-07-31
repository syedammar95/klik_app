import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Utils/app_colors.dart';
import '../constants/cart_constants.dart';

class CartLoginRequiredState extends StatelessWidget {
  const CartLoginRequiredState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.login,
            size: 80.h,
            color: AppColors.greyColor,
          ),
          SizedBox(height: 16.h),
          Text(
            CartConstants.loginRequiredTitle,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            CartConstants.loginRequiredSubtitle,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.greyColor,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              // Navigate to login screen
              // You can implement navigation to login screen here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
            ),
            child: Text(
              CartConstants.loginButtonText,
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}
