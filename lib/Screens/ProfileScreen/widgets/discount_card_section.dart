import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/app_colors.dart';
import '../helpers/discount_offer_card.dart';

class DiscountCardSection extends StatelessWidget {
  const DiscountCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: DiscountOfferCard(
        imageUrl: 'assets/images/product4.png',
        row1Children: [
          _discountText('END OF SEASON', AppColors.blackColor, fontSize: 10.sp),
          _discountText(' SALE ', AppColors.redColor, fontSize: 16.sp),
          _discountText(' Starts: Jan30, ', AppColors.blackColor,
              fontSize: 10.sp),
          _discountText('00:00 PT', AppColors.blackColor, fontSize: 10.sp),
        ],
        row2Children: [
          _discountText('UpTo', AppColors.blackColor, fontSize: 10.sp),
          SizedBox(width: 4.w),
          _discountText('60%', AppColors.redColor, fontSize: 33.sp),
          SizedBox(width: 4.w),
          _discountText('OFF', AppColors.redColor, fontSize: 28.sp),
          SizedBox(width: 10.w),
          Icon(
            Icons.arrow_circle_right_outlined,
            size: 20.sp,
            color: AppColors.blackColor,
          ),
        ],
      ),
    );
  }

  Widget _discountText(String text, Color color, {double fontSize = 8}) {
    return Text(text, style: TextStyle(fontSize: fontSize, color: color));
  }
}
