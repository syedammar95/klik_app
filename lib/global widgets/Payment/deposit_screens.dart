import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/app_colors.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final bool showLeftIcon;
  final bool showRightIcon;
  final bool showFirstText;
  final bool showSecondText;
  final String firstText;
  final String secondText;
  final String amount;

  const CustomBottomSheet({
    super.key,
    required this.title,
    this.showLeftIcon = false,
    this.showRightIcon = true,
    this.showFirstText = true,
    this.showSecondText = true,
    required this.amount,
    required this.firstText,
    required this.secondText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
          child: Stack(
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              if (showRightIcon)
                Positioned(
                  right: -2.w,
                  bottom: -10.h,
                  child: IconButton(
                    icon: Icon(Icons.close, size: 22.sp),
                    onPressed: () {
                      while (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              if (showLeftIcon)
                Positioned(
                  left: -2.w,
                  bottom: -10.h,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded, size: 22.sp),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
            ],
          ),
        ),
        if (showFirstText)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Column(
              children: [
                Text(
                  firstText,
                  style: TextStyle(fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
                Text(
                  amount,
                  style: TextStyle(fontSize: 25.sp, color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        if (showSecondText)
          SizedBox(height: 6.h),
        if (showSecondText)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                secondText,
                style: TextStyle(fontSize: 13.sp),
              ),
            ),
          ),
      ],
    );
  }
}
