import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Utils/app_colors.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final int price;
  final int? discountedPercent;
  final double? rating;
  final int? ratingCount;
  final int? soldCount;
  final VoidCallback onTap;
  final bool showFreeDelivery;
  final bool showLimitedTimeOffer; // New Property

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.onTap,
    this.discountedPercent,
    this.rating,
    this.ratingCount,
    this.soldCount,
    this.showFreeDelivery = false,
    this.showLimitedTimeOffer = false, // Default is false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0.5,
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            /// **Fix: Wrap Column with Expanded to Prevent Overflow**
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Product Name
                  Text(
                    productName,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  /// Price & Discount
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Rs.${_calculateDiscountedPrice()}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.redColor,
                        ),
                      ),
                      if (discountedPercent != null) ...[
                        SizedBox(width: 5.w),
                        Text(
                          "Rs.$price",
                          style: TextStyle(
                            fontSize: 10.sp,
                            decoration: TextDecoration.lineThrough,
                            color: AppColors.greyColor,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "-$discountedPercent%",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.greenColor,
                          ),
                        ),
                      ],
                    ],
                  ),

                  /// Rating & Sold Count
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Row(
                      children: [
                        if (rating != null)
                          Row(
                            children: [
                              Icon(Icons.star,
                                  size: 12.sp, color: AppColors.yellowColor),
                              SizedBox(width: 2.w),
                              Text(
                                "$rating ($ratingCount)",
                                style: TextStyle(fontSize: 10.sp),
                              ),
                            ],
                          ),
                        if (soldCount != null) ...[
                          SizedBox(width: 8.w),
                          Text(
                            "$soldCount Sold",
                            style: TextStyle(
                                fontSize: 10.sp, color: AppColors.greyColor),
                          ),
                        ],
                      ],
                    ),
                  ),

                  /// Free Delivery or Limited Time Offer Badge
                  if (showFreeDelivery || showLimitedTimeOffer)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: showFreeDelivery
                              ? AppColors.greenColor
                              : AppColors.redColor,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          showFreeDelivery
                              ? "FREE DELIVERY"
                              : "LIMITED TIME OFFER",
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Calculate discounted price
  int _calculateDiscountedPrice() {
    return (price -
            (discountedPercent != null
                ? (price * discountedPercent! / 100)
                : 0))
        .toInt();
  }
}
