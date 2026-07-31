import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Utils/app_colors.dart';
import '../constants/cart_constants.dart';

class CartLoadingState extends StatelessWidget {
  const CartLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
          SizedBox(height: 16.h),
          Text(
            CartConstants.loadingText,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
