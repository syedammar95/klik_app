import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/app_colors.dart';

class CheckOutCard extends StatelessWidget {
  final String shippedBy;
  final String productName;
  final String brand;
  final String colorFamily;
  final double rupees;
  final double quantityProduct;
  final double deliveryCharges;

  const CheckOutCard({
    required this.shippedBy,
    required this.productName,
    required this.brand,
    required this.colorFamily,
    required this.rupees,
    required this.quantityProduct,
    required this.deliveryCharges,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.h),
          Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.collections, size: 16.h,color: AppColors.greyColor,),
                    SizedBox(width: 6.w),
                    Text(
                      shippedBy,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(Icons.info_outlined, size: 16.h,color: AppColors.greyColor,),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Image.asset(
                        'assets/images/img.png',
                        width: 70.w,
                        height: 70.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            '$brand, Color Family: $colorFamily',
                            style: TextStyle(
                              color: AppColors.greyColor,
                              fontSize: 10.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Rs.',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    rupees.toString(),
                                    style: TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Qty:',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.blackColor
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    quantityProduct.toString(),
                                    style: TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Option',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.blackColor
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'View all options',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.blackColor,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppColors.blackColor),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.greyColor),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Standard Delivery',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Rs. ${deliveryCharges.toString()}',
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                const Icon(Icons.local_shipping, size: 14, color: AppColors.greenColor),
                                SizedBox(width: 4.w),
                                Text(
                                  'Guaranteed by 23-26 Jan',
                                  style: TextStyle(
                                    color: AppColors.greenColor,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
