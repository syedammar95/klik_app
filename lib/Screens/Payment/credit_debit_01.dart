import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Utils/app_colors.dart';

class CreditDebit01 extends StatelessWidget {
  const CreditDebit01({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Credit/Debit Card',
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
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
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 14.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info, size: 18.sp, color: Colors.blue[900]),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Please collect bank vouchers to avail bank discounts and mega deals/flash sales',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12.sp, color: Colors.blue[900]),
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
                color: Colors.green.shade100,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 14.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.gpp_good, size: 16.sp, color: Colors.green),
                      SizedBox(width: 8.w),
                      Text(
                        'Covered by KLIK Payment Protection',
                        style: TextStyle(fontSize: 12.sp, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w, top: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(FontAwesomeIcons.ccMastercard, size: 20.sp),
                  SizedBox(width: 10.w),
                  Icon(FontAwesomeIcons.ccVisa, size: 20.sp),
                  SizedBox(width: 10.w),
                  Icon(FontAwesomeIcons.ccApplePay, size: 20.sp),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 35.h,
                      maxHeight: 35.h,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Card number',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13.sp,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                          borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 4.h,
                          horizontal: 12.w,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 35.h,
                            maxHeight: 35.h,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Expiry (MM/YY)',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 13.sp,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0.r),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0.r),
                                borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0.r),
                                borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 4.h,
                                horizontal: 12.w,
                              ),
                              suffixIcon: Icon(Icons.help_outline, size: 20.sp, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 35.h,
                            maxHeight: 35.h,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'CVV',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 13.sp,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0.r),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0.r),
                                borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0.r),
                                borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 4.h,
                                horizontal: 12.w,
                              ),
                              suffixIcon: Icon(Icons.help_outline, size: 20.sp, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 35.h,
                      maxHeight: 35.h,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Name on card',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13.sp,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                          borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 4.h,
                          horizontal: 12.w,
                        ),
                        suffixIcon: Icon(Icons.help_outline, size: 20.sp, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
              child: Text(
                'We will save this card for your convenience. If required, you can remove the card in the "Payment Options" in the "Account" menu.',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 18.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal', style: TextStyle(fontSize: 12.sp)),
                  Text('\$100', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Amount', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  Text('\$100', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
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
