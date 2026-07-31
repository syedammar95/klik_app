import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Utils/app_colors.dart';
import '../constants/cart_constants.dart';
import 'dynamic_product_image.dart';
import '../../../models/cart/get_cart_model.dart';

class MyCartCard extends StatelessWidget {
  final CartModel cartItem;
  final Function onAdd;
  final Function onRemove;
  final Function onDelete;

  const MyCartCard({
    required this.cartItem,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Extract dynamic data from cart item
    final productName = cartItem.productName ?? CartConstants.unknownProduct;
    final productPrice = double.tryParse(cartItem.effectivePrice) ?? 0.0;
    final originalPrice = double.tryParse(cartItem.price ?? '0') ?? 0.0;
    final quantity = cartItem.quantity ?? 1;
    final hasDiscount = cartItem.discountPrice != null &&
        cartItem.discountPrice!.isNotEmpty &&
        cartItem.discountPrice != '0' &&
        double.tryParse(cartItem.discountPrice!) != null &&
        double.parse(cartItem.discountPrice!) > 0 &&
        double.parse(cartItem.discountPrice!) < originalPrice;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
          color: AppColors.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: false,
                    activeColor: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    onChanged: (value) {},
                  ),
                  Text(
                    CartConstants.shippedByText,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Icon(
                    Icons.info_outlined,
                    size: 16.h,
                    color: AppColors.greyColor,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        activeColor: AppColors.secondaryColor,
                        checkColor: AppColors.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        onChanged: (value) {},
                      ),
                      DynamicProductImage(
                        imageUrl: cartItem.imageUrl,
                        width: 70,
                        height: 70,
                      ),
                    ],
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (hasDiscount) ...[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: AppColors.redColor,
                                ),
                                child: Text(
                                  CartConstants.saleTagText,
                                  style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 11.sp),
                                ),
                              ),
                              SizedBox(width: 4.w),
                            ],
                            Expanded(
                              child: Text(
                                productName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Text(
                              '${CartConstants.storePrefix} ${cartItem.productId ?? 'N/A'}',
                              style: TextStyle(
                                color: AppColors.greyColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        if (cartItem.variationName != null &&
                            cartItem.variationName!.isNotEmpty) ...[
                          SizedBox(height: 4.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.blackColor),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              '${cartItem.variationName}: ${cartItem.variationValue ?? ''}',
                              style: TextStyle(
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                        ],
                        SizedBox(height: 4.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${CartConstants.currencySymbol}  ',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            if (hasDiscount) ...[
                              Text(
                                originalPrice.toStringAsFixed(0),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  decoration: TextDecoration.lineThrough,
                                  color: AppColors.greyColor,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                productPrice.toStringAsFixed(0),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.redColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ] else ...[
                              Text(
                                productPrice.toStringAsFixed(0),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${CartConstants.totalText}  ',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  (productPrice * quantity).toStringAsFixed(0),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border:
                                        Border.all(color: AppColors.greyColor),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove,
                                            color: AppColors.redColor,
                                            size: 12.h),
                                        onPressed: () => quantity > 1
                                            ? onRemove()
                                            : onDelete(),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                      Text(
                                        '$quantity',
                                        style: TextStyle(
                                          color: AppColors.blackColor,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add,
                                            color: AppColors.greenColor,
                                            size: 12.h),
                                        onPressed: () => onAdd(),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          CartConstants.freeShippingText,
                          style: TextStyle(
                            color: AppColors.greenColor,
                            fontSize: 12.sp,
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
      ],
    );
  }
}
