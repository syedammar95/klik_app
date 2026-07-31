import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Utils/app_colors.dart';
import '../provider/cart_provider.dart';
import '../constants/cart_constants.dart';

class CartBottomNavigation extends StatelessWidget {
  final CartProvider cartProvider;
  final VoidCallback onCheckoutPressed;

  const CartBottomNavigation({
    super.key,
    required this.cartProvider,
    required this.onCheckoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        color: AppColors.boxShadowColor,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCheckboxSection(),
            _buildTotalPrice(),
            _buildCheckoutButton(),
          ],
        ),
      ),
    );
  }

  /// Builds the "All" checkbox section
  Widget _buildCheckboxSection() {
    return Row(
      children: [
        Checkbox(
          value: true,
          activeColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
          onChanged: (value) {},
        ),
        Text(
          CartConstants.allCheckboxText,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// Builds the total price display
  Widget _buildTotalPrice() {
    final totalPrice = cartProvider.totalCartPrice;

    return Row(
      children: [
        Text(
          '${CartConstants.currencySymbol} ',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          totalPrice.toStringAsFixed(0),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// Builds the Checkout button
  Widget _buildCheckoutButton() {
    final itemCount = cartProvider.cartModel?.cart?.length ?? 0;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h),
      ),
      onPressed: itemCount > 0 ? onCheckoutPressed : null,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
        child: Text(
          '${CartConstants.checkoutButtonText} ($itemCount)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
