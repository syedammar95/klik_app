import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/app_colors.dart';

class Chat02 extends StatelessWidget {
  const Chat02({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 1,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Chase House",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Icon(Icons.circle, color: Colors.green[500], size: 8.sp),
                SizedBox(width: 4.w),
                Text(
                  "Online",
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.green[500],
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white, size: 20.sp),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.white, size: 20.sp),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: AppColors.scaffoldColor,
            ),
          ),
          Container(
            color: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.add_circle, color: Colors.white, size: 26.sp),
                  onPressed: () {},
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.emoji_emotions,
                            color: Colors.black, size: 20.sp),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
