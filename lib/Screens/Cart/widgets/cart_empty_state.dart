import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Utils/app_colors.dart';
import '../constants/cart_constants.dart';

class CartEmptyState extends StatelessWidget {
  const CartEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80.h,
            color: AppColors.greyColor,
          ),
          SizedBox(height: 16.h),
          Text(
            CartConstants.emptyCartTitle,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            CartConstants.emptyCartSubtitle,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
