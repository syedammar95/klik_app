import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../Utils/app_colors.dart';
import '../../../models/product/product_model.dart';
import '../provider/product_detail_provider.dart';

/// OverviewSection Widget
/// Displays the product image carousel with indicators and counter
class OverviewSection extends StatelessWidget {
  final ProductModel product;
  final PageController pageController;
  final Function(int)? onPageChanged;

  const OverviewSection({
    super.key,
    required this.product,
    required this.pageController,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _buildImageCarousel();
  }

  Widget _buildImageCarousel() {
    if (product.images.isEmpty) {
      return _buildNoImagesPlaceholder();
    }

    return Container(
      height: 350.h,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Stack(
        children: [
          _buildMainImageCarousel(),
          if (product.images.length > 1) ...[
            _buildPageIndicators(),
            _buildImageCounter(),
          ],
        ],
      ),
    );
  }

  Widget _buildNoImagesPlaceholder() {
    return Container(
      height: 350.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.scaffoldColor.withValues(alpha: 0.3),
            AppColors.scaffoldColor.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.boxShadowColor.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.boxShadowColor.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 48.sp,
              color: AppColors.greyColor,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No images available',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.greyColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Product images will appear here',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.greyColor.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainImageCarousel() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.boxShadowColor.withValues(alpha: 0.1),
            blurRadius: 40,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            blurRadius: 40,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: PageView.builder(
          controller: pageController,
          onPageChanged: onPageChanged,
          itemCount: product.images.length,
          itemBuilder: (context, index) {
            return _buildImageItem(index);
          },
        ),
      ),
    );
  }

  Widget _buildImageItem(int index) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement image zoom functionality
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.whiteColor.withValues(alpha: 0.1),
              AppColors.primaryColor.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: Image.network(
          product.images[index],
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildImageErrorWidget();
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _buildImageLoadingWidget();
          },
        ),
      ),
    );
  }

  Widget _buildImageErrorWidget() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.scaffoldColor,
            AppColors.scaffoldColor.withValues(alpha: 0.8),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor.withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline_rounded,
              size: 32.sp,
              color: AppColors.redColor,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Failed to load image',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.greyColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Tap to retry',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.greyColor.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageLoadingWidget() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.scaffoldColor,
            AppColors.scaffoldColor.withValues(alpha: 0.8),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(
                strokeWidth: 0.5,
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Loading image...',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Positioned(
      bottom: 16.h,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          product.images.length,
          (index) => Consumer<ProductDetailProvider>(
            builder: (context, productDetailProvider, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                width: productDetailProvider.currentImageIndex == index
                    ? 24.w
                    : 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: productDetailProvider.currentImageIndex == index
                      ? AppColors.whiteColor
                      : AppColors.whiteColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(4.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildImageCounter() {
    return Positioned(
      top: 16.h,
      right: 16.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.blackColor.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Consumer<ProductDetailProvider>(
          builder: (context, productDetailProvider, child) {
            return Text(
              '${productDetailProvider.currentImageIndex + 1}/${product.images.length}',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            );
          },
        ),
      ),
    );
  }
}
