import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileOrderCard extends StatelessWidget {
  final String iconPath;
  final String text;
  final double textSize;
  final VoidCallback onTap;

  const ProfileOrderCard({
    super.key,
    required this.iconPath,
    required this.text,
    required this.textSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        constraints: BoxConstraints(
          maxWidth: 60.w,
          minHeight: 10.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 18.w,
              height: 18.h,
            ),
            SizedBox(height: 2.h),
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: textSize),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
