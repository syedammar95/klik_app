import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Utils/app_colors.dart';

class HomeCategoryList extends StatelessWidget {
  final double containerWidth;
  final String imageUrl;
  final String text;
  final FontWeight textWeight;
  final double textSize;

  const HomeCategoryList({
    super.key,
    required this.containerWidth,
    required this.imageUrl,
    required this.text,
    required this.textWeight,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 4.w), // ✅ Reduced horizontal padding
      child: SizedBox(
        width: 70.w, // ✅ Fixed width for square appearance
        height: 90.h, // ✅ Increased height to accommodate 2-line text
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// **Category Image**
            Container(
              width: 50.w, // ✅ Fixed width for image container
              height: 50.w, // ✅ Same as width for square image
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: _buildCategoryImage(),
            ),

            /// **Category Name**
            SizedBox(height: 4.h), // ✅ Increased spacing between image and text
            Container(
              width: 70.w, // ✅ Fixed width for text container
              height: 28
                  .h, // ✅ Increased height to properly accommodate 2-line text
              child: Text(
                text,
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: textWeight,
                  height: 1.2, // ✅ Added line height for better text spacing
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// **🔹 Build Category Image with proper null handling**
  Widget _buildCategoryImage() {
    // If imageUrl is empty or null, show default icon
    if (imageUrl.isEmpty || imageUrl == 'null') {
      return _buildDefaultCategoryIcon();
    }

    // Check if it's a network URL or asset path
    if (imageUrl.startsWith('http')) {
      // Network image - Perfect Circle
      return SizedBox(
        width: 40.w, // ✅ Adjusted to fit in 50.w container with padding
        height: 40.w, // Use width for height to ensure perfect circle
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryColor.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildDefaultCategoryIcon();
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return _buildDefaultCategoryIcon();
              },
            ),
          ),
        ),
      );
    } else {
      // Asset image - Circular
      try {
        if (imageUrl.endsWith('.svg')) {
          return SizedBox(
            width: 40.w, // ✅ Adjusted to fit in 50.w container with padding
            height: 40.w, // Use width for height to ensure perfect circle
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: ClipOval(
                child: SvgPicture.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        } else {
          return SizedBox(
            width: 40.w, // ✅ Adjusted to fit in 50.w container with padding
            height: 40.w, // Use width for height to ensure perfect circle
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }
      } catch (e) {
        // If asset loading fails, show default icon
        return _buildDefaultCategoryIcon();
      }
    }
  }

  /// **🔹 Build Default Category Icon**
  Widget _buildDefaultCategoryIcon() {
    return SizedBox(
      width: 40.w, // ✅ Adjusted to fit in 50.w container with padding
      height: 40.w,
      child: Container(
        decoration: const BoxDecoration(
          // color: AppColors.lightGreenColor.withValues(alpha: 0.15),
          shape: BoxShape.circle,
          // border: Border.all(
          //   color: AppColors.primaryColor.withValues(alpha: 0.3),
          //   width: 0.5,
          // ),
        ),
        child: Icon(
          Icons.image_not_supported,
          size: 24.sp, // ✅ Reduced icon size
          color: AppColors.primaryColor.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
