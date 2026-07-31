import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../Utils/app_colors.dart';
import '../../../models/product/product_model.dart';
import '../provider/product_detail_provider.dart';

/// ProductInfoSection Widget
/// Displays product details, specifications, and description
class ProductInfoSection extends StatelessWidget {
  final ProductModel product;

  const ProductInfoSection({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.whiteColor,
            AppColors.whiteColor.withValues(alpha: 0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.blackColor.withValues(alpha: 0.1),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductName(),
          SizedBox(height: 16.h),
          if (product.brandName.isNotEmpty) ...[
            _buildBrandName(),
            SizedBox(height: 16.h),
          ],
          _buildPriceSection(),
          SizedBox(height: 20.h),
          if (product.rating > 0) ...[
            _buildRatingSection(),
            SizedBox(height: 20.h),
          ],
          _buildStockStatus(),
          SizedBox(height: 20.h),
          _buildDescriptionSection(),
        ],
      ),
    );
  }

  Widget _buildProductName() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.primaryColor.withValues(alpha: 0.15),
            AppColors.primaryColor.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.3),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        product.productName,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildBrandName() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.scaffoldColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.boxShadowColor.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Brand :  ',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: product.brandName,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.greyColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSection() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryColor.withValues(alpha: 0.1),
            AppColors.primaryColor.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.5),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          if (product.discountPrice > 0 &&
              product.discountPrice < product.price) ...[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rs.${product.discountPrice}',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        'Rs.${product.price}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.greyColor,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      _buildDiscountBadge(),
                    ],
                  ),
                ],
              ),
            ),
          ] else ...[
            Text(
              'Rs.${product.price}',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDiscountBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.greenColor,
            AppColors.greenColor.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        '${product.discountPercentage.toStringAsFixed(0)}% OFF',
        style: TextStyle(
          fontSize: 12.sp,
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRatingSection() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.yellowColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.yellowColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: AppColors.yellowColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.star_rounded,
              color: AppColors.yellowColor,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            product.rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            'Rating',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockStatus() {
    return Row(
      children: [
        Icon(
          product.stock > 0 ? Icons.check_circle_rounded : Icons.cancel_rounded,
          color: product.stock > 0 ? AppColors.greenColor : AppColors.redColor,
          size: 18.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          product.stock > 0
              ? 'In Stock (${product.stock} available)'
              : 'Out of Stock',
          style: TextStyle(
            fontSize: 12.sp,
            color:
                product.stock > 0 ? AppColors.greenColor : AppColors.redColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColors.blackColor.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          _buildDescriptionHeader(),
          _buildExpandableDescription(),
        ],
      ),
    );
  }

  Widget _buildDescriptionHeader() {
    return Consumer<ProductDetailProvider>(
      builder: (context, productDetailProvider, child) {
        return InkWell(
          onTap: () {
            productDetailProvider.toggleDescriptionExpansion();
          },
          borderRadius: BorderRadius.circular(12.r),
          splashColor: AppColors.primaryColor.withValues(alpha: 0.1),
          highlightColor: AppColors.primaryColor.withValues(alpha: 0.05),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: productDetailProvider.isDescriptionExpanded
                  ? null
                  : Border(
                      bottom: BorderSide(
                        color: AppColors.boxShadowColor.withValues(alpha: 0.0),
                        width: 0.5,
                      ),
                    ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Description',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Tap to ${productDetailProvider.isDescriptionExpanded ? 'hide' : 'see'} details',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.greyColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: AnimatedRotation(
                    turns:
                        productDetailProvider.isDescriptionExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.primaryColor,
                      size: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExpandableDescription() {
    return Consumer<ProductDetailProvider>(
      builder: (context, productDetailProvider, child) {
        // Debug: Log products without descriptions for monitoring
        if (product.description.isEmpty) {
          debugPrint(
              'Product ${product.productId} (${product.productName}) has no description');
        }

        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: productDetailProvider.isDescriptionExpanded
              ? Container(
                  padding: EdgeInsets.fromLTRB(6.w, 0.h, 8.w, 6.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color:
                                AppColors.primaryColor.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        child: product.description.isNotEmpty
                            ? _buildDescriptionContent()
                            : _buildNoDescriptionPlaceholder(),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildDescriptionContent() {
    return Text(
      product.description
          .replaceAll('\r\n', '\n')
          .replaceAll('\r', '\n')
          .replaceAll('\n', '\n'),
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 13.sp,
        color: AppColors.blackColor,
        height: 1.6,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildNoDescriptionPlaceholder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.info_outline_rounded,
              color: AppColors.primaryColor,
              size: 16.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'No Description Available',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'This product doesn\'t have a detailed description yet. For more information about this product, please contact our customer support team.',
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.greyColor,
            height: 1.5,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(
              color: AppColors.primaryColor.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.phone_rounded,
                color: AppColors.primaryColor,
                size: 14.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Contact Support: +92-XXX-XXXXXXX',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
