import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/app_colors.dart';
import '../helpers/profile_screen_icon_text.dart';

class OrdersSection extends StatelessWidget {
  const OrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 9.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Orders',
                    style: TextStyle(
                        fontSize: 13.sp, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: Text('View All Orders',
                      style: TextStyle(
                          fontSize: 13.sp, color: AppColors.blackColor)),
                ),
              ],
            ),
          ),
          _buildOrderOptionsRow(),
        ],
      ),
    );
  }

  Widget _buildOrderOptionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _orderOption('assets/svg_icons_profile/To_Pay.svg', 'To Pay'),
        _orderOption('assets/svg_icons_profile/To ship icon 02.svg', 'To Ship'),
        _orderOption('assets/svg_icons_profile/Shipped.svg', 'Shipped'),
        _orderOption('assets/svg_icons_profile/To_Reviews.svg', 'To Review'),
        _orderOption(
            'assets/svg_icons_profile/Return & Cancellation.svg', 'Returns'),
      ],
    );
  }

  /// **Reusable Order Option**
  Widget _orderOption(String iconPath, String text) {
    return ProfileOrderCard(
      iconPath: iconPath,
      text: text,
      textSize: 11.sp,
      onTap: () {},
    );
  }
}
