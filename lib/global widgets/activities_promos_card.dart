import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Utils/app_colors.dart';

class ActivitiesPromosCard extends StatelessWidget {
  final String firstText;
  final String secondText;
  final IconData leftIcon;
  final VoidCallback onTap;
  final Color circleColor;
  final Color mainContainerColor;
  final Color categoryColor;
  final Color dealColor;
  final Color dealLineColor;
  final Color centreCircleColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final String deal;
  final String dealLine;
  final String percent;
  final String lastLongText;
  final String lastImage;
  final String category;
  final String buttonText;

  const ActivitiesPromosCard({
    required this.firstText,
    required this.secondText,
    this.leftIcon = Icons.info,
    required this.onTap,
    required this.category,
    this.buttonTextColor = Colors.white,
    this.mainContainerColor = Colors.white,
    this.categoryColor = Colors.black,
    this.centreCircleColor = Colors.black,
    this.dealColor = Colors.black,
    this.dealLineColor = Colors.black,
    this.buttonColor = Colors.black,
    this.circleColor = Colors.blue,
    required this.percent,
    required this.deal,
    required this.lastLongText,
    required this.lastImage,
    required this.dealLine,
    required this.buttonText,
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
          color: Colors.white,
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
                  child: Center(
                    child: Icon(
                      leftIcon,
                      size: 20.sp,
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
                      style: TextStyle(fontSize: 13.sp),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: mainContainerColor,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 7.h),
                            child: Container(
                                padding: EdgeInsets.only(left: 7.w, right: 3.w),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Text('MID MONTH SALE',
                                    style: TextStyle(
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor))),
                          ),
                          Padding(
                            padding: EdgeInsets.all(6.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(category,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: categoryColor)),
                                Text(deal,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: dealColor)),
                                SizedBox(height: 3.h),
                                Text(dealLine,
                                    style: TextStyle(
                                        fontSize: 11.sp, color: dealLineColor)),
                                SizedBox(height: 3.h),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.r),
                                      color: buttonColor,
                                    ),
                                    child: Text(buttonText,
                                        style: TextStyle(
                                            fontSize: 7.sp,
                                            color: buttonTextColor))),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 45.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: centreCircleColor,
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'UP TO',
                                  style: TextStyle(
                                      fontSize: 5.sp, color: Colors.white),
                                ),
                                Text(
                                  '$percent%',
                                  style: TextStyle(
                                      fontSize: 13.sp, color: Colors.white),
                                ),
                                Text(
                                  'OFF',
                                  style: TextStyle(
                                      fontSize: 5.sp, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 14.w),
                      Container(
                        width: 95.w,
                        height: 95.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(lastImage),
                            fit: BoxFit.contain,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  lastLongText,
                  style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
