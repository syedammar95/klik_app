import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../global widgets/circular_image_container.dart';

class ProductWidget extends StatelessWidget {
  final double containerWidth;
  final String imageUrl;
  final String text;
  final FontWeight textWeight;
  final double textSize;
  final VoidCallback onTap;

  const ProductWidget({
    super.key,
    required this.containerWidth,
    required this.imageUrl,
    required this.text,
    required this.textWeight,
    required this.textSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: containerWidth,
        child: Padding(
          padding: EdgeInsets.all(4.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImage(),
              SizedBox(height: 5.h),
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: textWeight,
                    fontSize: textSize.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 **Build Circular Image with Theme-Adaptive Outline**
  Widget _buildImage() {
    return CircularImageVariants.large(
      imageUrl: imageUrl,
      onTap: onTap,
      fallbackIcon: Icons.image_not_supported,
    );
  }
}
