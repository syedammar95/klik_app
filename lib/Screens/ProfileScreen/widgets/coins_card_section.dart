import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Utils/app_colors.dart';

class CoinsCardSection extends StatelessWidget {
  const CoinsCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        child: Column(
          children: List.generate(2, (_) => _coinsContainer()),
        ),
      ),
    );
  }

  Widget _coinsContainer() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.scaffoldColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Collect Coins',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Get up to 30% off',
                    style:
                        TextStyle(fontSize: 12.sp, color: AppColors.blackColor),
                  ),
                  SizedBox(height: 8.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    onPressed: () {},
                    child: Text('Shop Now',
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColors.whiteColor)),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                'assets/images/product4.png',
                width: 55.w,
                height: 55.h,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
