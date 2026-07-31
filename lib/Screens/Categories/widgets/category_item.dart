import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Utils/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final String imageUrl;
  final String categoryName;
  final VoidCallback onTap;
  final bool isSelected;
  final Color circleFilledColor;

  const CategoryItem({
    super.key,
    required this.imageUrl,
    required this.categoryName,
    required this.onTap,
    required this.isSelected,
    required this.circleFilledColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryColor : AppColors.whiteColor,
          // border: Border(
          //   left: BorderSide(
          //     color: isSelected ? AppColors.whiteColor : Colors.transparent,
          //     width: 1.w,
          //   ),
          //   right: BorderSide(
          //     color: isSelected ? AppColors.whiteColor : Colors.transparent,
          //     width: 2.w,
          //   ),
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: circleFilledColor,
              radius: 22.r,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: _buildCategoryImage(),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              categoryName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.blackColor : AppColors.greyColor,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// **🔹 Build Category Image with proper null handling**
  Widget _buildCategoryImage() {
    // If imageUrl is null, empty, or invalid, show a default icon
    if (imageUrl.isEmpty ||
        imageUrl == 'null' ||
        imageUrl.contains('default-placeholder') ||
        !imageUrl.startsWith('http') ||
        _isInvalidImageUrl(imageUrl)) {
      return _buildDefaultCategoryIcon();
    }

    // Try to load network image
    return ClipOval(
      child: Image.network(
        imageUrl,
        height: 50.h,
        width: 50.w,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return _buildDefaultCategoryIcon();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildDefaultCategoryIcon();
        },
      ),
    );
  }

  /// **🔹 Check if image URL is invalid**
  bool _isInvalidImageUrl(String url) {
    // Check for incomplete URLs (missing filename)
    if (url.endsWith('/') ||
        url.endsWith('/admin_panel') ||
        url.endsWith('/uploads') ||
        !url.contains('.')) {
      return true;
    }
    return false;
  }

  /// **🔹 Build Default Category Icon**
  Widget _buildDefaultCategoryIcon() {
    return Container(
      height: 40.h,
      width: 40.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Icon(
        Icons.image_not_supported,
        size: 22.sp,
        color: AppColors.primaryColor,
      ),
    );
  }
}
