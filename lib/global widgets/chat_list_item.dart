import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Utils/app_colors.dart';

class ChatListItem extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String? leftImage;
  final VoidCallback onTap;
  final Color containerColor;
  final Color circleColor;

  const ChatListItem({
    required this.firstText,
    required this.secondText,
    this.leftImage,
    required this.onTap,
    this.containerColor = Colors.white,
    this.circleColor = AppColors.lite,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isSecondTextVisible = secondText.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: circleColor,
                    shape: BoxShape.circle,
                  ),
                  child: leftImage != null
                      ? ClipOval(
                    child: Image.asset(
                      leftImage!,
                      fit: BoxFit.contain,
                      width: 40.w,
                      height: 40.h,
                    ),
                  )
                      : null,
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      firstText,
                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                    ),
                    if (isSecondTextVisible)
                      Text(
                        secondText,
                        style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
