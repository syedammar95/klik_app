import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Utils/app_colors.dart';

class HblBank01 extends StatelessWidget {
  const HblBank01({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HBL Bank Account',
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Container(
                color: Colors.blue.shade100,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info, size: 16.sp, color: Colors.blue[900]),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Please collect bank vouchers to avail bank discounts and mega deals/flash sales',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 11.sp, color: Colors.blue[900]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.ccVisa,
                          size: 22.sp, color: AppColors.primaryColor),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18.w, vertical: 8.h),
                          child: Text(
                            'Pay with your JazzCash Account. Please make sure you have enough balance in your account.',
                            style: TextStyle(fontSize: 11.sp),
                            textAlign: TextAlign.justify,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50.h,
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(8),
                                topRight: Radius.circular(8.r)),
                            color: Colors.grey.shade100,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(FontAwesomeIcons.ccVisa,
                                      size: 24.sp,
                                      color: AppColors.primaryColor),
                                  SizedBox(width: 8.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'HBL Bank Account',
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'HBL Bank Account',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(Icons.radio_button_checked,
                                  size: 20.sp, color: AppColors.primaryColor),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 10.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '1.For branchless banking: Use your 11-digit mobile number as HBL Account Number, starts with 0.',
                                style: TextStyle(fontSize: 11.sp),
                              ),
                              Text(
                                '2.For regular bank account: Use your 14-digit bank account number as HBL Account Number.',
                                style: TextStyle(fontSize: 11.sp),
                              ),
                              Text(
                                '3.Please enter your 13-digit CNIC without "-"',
                                style: TextStyle(fontSize: 11.sp),
                              ),
                              Text(
                                'Note: To use a different HBL account, please unlink existing account from Account>Payment Options.',
                                style: TextStyle(fontSize: 11.sp),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'HBL Account Number',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal),
                              border: InputBorder.none,
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primaryColor),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 6.h, horizontal: 0.w),
                            ),
                            style: TextStyle(fontSize: 13.sp),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'CNIC NO.',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal),
                              border: InputBorder.none,
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primaryColor),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 6.h, horizontal: 0.w),
                            ),
                            style: TextStyle(fontSize: 13.sp),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal', style: TextStyle(fontSize: 12.sp)),
                  Text('\$100',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Amount', style: TextStyle(fontSize: 13.sp)),
                  Text('\$100',
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor)),
                ],
              ),
              SizedBox(height: 4.h),
              Divider(color: Colors.grey.shade300),
              SizedBox(height: 4.h),
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
                    'Pay Now',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
