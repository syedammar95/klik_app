import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ProductDetailSection Widget
/// Wrapper widget for product detail sections with consistent styling
class ProductDetailSection extends StatelessWidget {
  final GlobalKey sectionKey;
  final String title;
  final Widget child;

  const ProductDetailSection({
    super.key,
    required this.sectionKey,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: sectionKey,
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          child,
        ],
      ),
    );
  }
}
