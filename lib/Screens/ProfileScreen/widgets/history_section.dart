import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Utils/app_colors.dart';
import '../helpers/profile_screen_icon_text.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _orderOption('assets/svg_icons_profile/History.svg', 'History'),
          _orderOption('assets/svg_icons_profile/Wishlist.svg', 'Wishlist'),
          _orderOption('assets/svg_icons_profile/Coupons.svg', 'Coupons'),
        ],
      ),
    );
  }

  Widget _orderOption(String iconPath, String text) {
    return ProfileOrderCard(
      iconPath: iconPath,
      text: text,
      textSize: 11.sp,
      onTap: () {},
    );
  }
}
