import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/app_colors.dart';

class DiscountOfferCard extends StatelessWidget {
  final String imageUrl;
  final List<Widget> row1Children;
  final List<Widget> row2Children;

  const DiscountOfferCard({
    super.key,
    required this.imageUrl,
    required this.row1Children,
    required this.row2Children,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerHeight = constraints.maxWidth < 400 ? 90.h : 110.h;
        double imageSize = constraints.maxWidth < 400 ? 60.w : 80.w;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          height: containerHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.lightGreenColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: row1Children),
                    SizedBox(height: 8.h),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: row2Children),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    imageUrl,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
