import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersPageItem extends StatelessWidget {
  final String firstText;
  final String secondText;
  final IconData leftIcon;
  final VoidCallback onTap;
  final Color containerColor;
  final Color circleColor;
  final String secondImage;
  final String longText;
  final String orderId;

  const OrdersPageItem({
    required this.firstText,
    required this.secondText,
    this.leftIcon = Icons.info,
    required this.onTap,
    this.containerColor = Colors.white,
    this.circleColor = Colors.blue,
    required this.secondImage,
    required this.longText,
    required this.orderId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isSecondTextVisible = secondText.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
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
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: circleColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      leftIcon,
                      size: 23.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
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
            SizedBox(height: 6.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 4.h, bottom: 4.h, right: 6.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.grey.shade100,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 65.w,
                        height: 65.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(secondImage),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              longText,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '#$orderId',
                              style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
