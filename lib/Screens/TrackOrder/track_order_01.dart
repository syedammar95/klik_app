import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/app_colors.dart';

class TrackOrder01 extends StatelessWidget {
  const TrackOrder01({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Track Order',
          style: TextStyle(fontSize: 16.sp, color: AppColors.whiteColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.whiteColor, size: 20.h),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              cursorColor: AppColors.greyColor,
              decoration: InputDecoration(
                label: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Order ID ',
                        style: TextStyle(
                            color: AppColors.greyColor, fontSize: 13.sp),
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                            color: AppColors.greyColor, fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: AppColors.greyColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide:
                      BorderSide(color: AppColors.secondaryColor, width: 1.5.w),
                ),
                prefixIcon: Icon(
                  Icons.task_outlined,
                  color: AppColors.greyColor,
                  size: 20.h,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              ),
            ),
            SizedBox(height: 15.h),
            TextField(
              cursorColor: AppColors.greyColor,
              decoration: InputDecoration(
                label: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Phone Number ',
                        style: TextStyle(
                            color: AppColors.greyColor, fontSize: 13.sp),
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                            color: AppColors.greyColor, fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: AppColors.greyColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide:
                      BorderSide(color: AppColors.secondaryColor, width: 1.5.w),
                ),
                prefixIcon: Icon(
                  Icons.phone,
                  color: AppColors.greyColor,
                  size: 20.h,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              ),
              obscureText: true,
            ),
            SizedBox(height: 18.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 6.r),
                ),
                onPressed: () {},
                child: Text(
                  'Track',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
