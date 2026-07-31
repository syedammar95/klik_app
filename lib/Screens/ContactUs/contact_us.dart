import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/app_colors.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: TextStyle(fontSize: 16.sp, color: AppColors.whiteColor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.whiteColor,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/contact_us.png',
                height: 130.h,
              ),
            ),
            SizedBox(height: 30.w),
            TextField(
              cursorColor: AppColors.greyColor,
              decoration: InputDecoration(
                label: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Full Name ',
                        style: TextStyle(color: AppColors.greyColor, fontSize: 13.sp),
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(color: AppColors.greyColor, fontSize: 13.sp),
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
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.w),
                ),
                prefixIcon: Icon(
                  Icons.person,
                  color: AppColors.greyColor,
                  size: 20.h,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
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
                        text: 'Email ',
                        style: TextStyle(color: AppColors.greyColor, fontSize: 13.sp),
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(color: AppColors.greyColor, fontSize: 13.sp),
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
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.w),
                ),
                prefixIcon: Icon(Icons.email, color: AppColors.greyColor, size: 20.h,),
                contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              ),
              obscureText: true,
            ),
            SizedBox(height: 15.h),
            TextField(
              cursorColor: AppColors.greyColor,
              decoration: InputDecoration(
                label: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '+92 |   Enter Mobile Number ',
                        style: TextStyle(color: AppColors.greyColor, fontSize: 13.sp),
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(color: AppColors.greyColor, fontSize: 13.sp),
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
                  borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.5.w),
                ),
                prefixIcon: Icon(Icons.phone, color: AppColors.greyColor, size: 20.h,),
                contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              ),
              obscureText: true,
            ),
            SizedBox(height: 15.h),
            TextField(
              cursorColor: AppColors.greyColor,
              decoration: InputDecoration(
                label: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Subject ',
                        style: TextStyle(color: AppColors.greyColor, fontSize: 13.sp),
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(color: AppColors.greyColor, fontSize: 13.sp),
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
                  borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.w),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              ),
              obscureText: true,
            ),
            SizedBox(height: 15.h),
            TextField(
              cursorColor: AppColors.greyColor,
              decoration: InputDecoration(
                label: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Message ',
                        style: TextStyle(color: AppColors.greyColor, fontSize: 13.sp),
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(color: AppColors.greyColor, fontSize: 13.sp),
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
                  borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.5.w),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              ),
              obscureText: true,
            ),
            SizedBox(height: 80.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                ),
                onPressed: () {},
                child: Text(
                  'Send Request',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
