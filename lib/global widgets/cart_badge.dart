import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Utils/app_colors.dart';
import '../Screens/Cart/provider/cart_provider.dart';

class CartBadge extends StatelessWidget {
  final Widget child;
  final double? top;
  final double? left;
  final double? badgeSize;
  final double? fontSize;
  final bool isBottomNavigation;

  const CartBadge({
    super.key,
    required this.child,
    this.top,
    this.left,
    this.badgeSize,
    this.fontSize,
    this.isBottomNavigation = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        final itemCount = cartProvider.cartItemCountImmediate;

        // Don't show badge if cart is empty
        if (itemCount <= 0) {
          return child;
        }

        return Stack(
          clipBehavior: Clip.none,
          children: [
            child,
            Positioned(
              top: top ?? (isBottomNavigation ? -6.h : -5.h),
              left: left ?? (isBottomNavigation ? 16.w : -5.w),
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: const BoxDecoration(
                  color: AppColors.redColor,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(
                  minWidth: badgeSize ?? 16.w,
                  minHeight: badgeSize ?? 16.w,
                ),
                child: Center(
                  child: Text(
                    itemCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize ?? 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
