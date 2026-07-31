import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../Utils/app_colors.dart';
import '../../../models/product/product_model.dart';
import '../../../Screens/Cart/provider/cart_provider.dart';
import '../../../Screens/Auth/email section/provider/email_authProvider.dart';
import '../../../Utils/helpers/toast_utils.dart';

/// Simple test button to verify cart functionality
class CartTestButton extends StatelessWidget {
  final ProductModel product;

  const CartTestButton({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<CartProvider, EmailAuthProvider>(
      builder: (context, cartProvider, authProvider, child) {
        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(color: AppColors.boxShadowColor, blurRadius: 2),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Test Information
              Container(
                padding: EdgeInsets.all(8.w),
                margin: EdgeInsets.only(bottom: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cart Test - Product: ${product.productName}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'ID: ${product.productId} | Price: ${product.price} | Stock: ${product.stock}',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      'Logged In: ${authProvider.isLoggedIn} | User: ${authProvider.user?.id ?? "None"}',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
              // Test Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                      ),
                      onPressed: () =>
                          _testAddToCart(context, cartProvider, authProvider),
                      child: Text(
                        'Test Add to Cart',
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.greenColor,
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                      ),
                      onPressed: () =>
                          _testGetCart(context, cartProvider, authProvider),
                      child: Text(
                        'Test Get Cart',
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.redColor,
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                      ),
                      onPressed: () => _testRemoveFromCart(
                          context, cartProvider, authProvider),
                      child: Text(
                        'Test Remove',
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.greyColor,
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                      ),
                      onPressed: () =>
                          _testClearCart(context, cartProvider, authProvider),
                      child: Text(
                        'Clear Cart',
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _testAddToCart(
    BuildContext context,
    CartProvider cartProvider,
    EmailAuthProvider authProvider,
  ) async {
    try {
      print("🧪 TEST: Starting add to cart test");

      if (!authProvider.isLoggedIn) {
        ToastUtils.showError("Please login first");
        return;
      }

      if (authProvider.user == null) {
        ToastUtils.showError("User session not available");
        return;
      }

      final price = product.discountPrice > 0
          ? product.discountPrice.toDouble()
          : product.price.toDouble();

      print("🧪 TEST: Adding product ${product.productId} with price $price");

      await cartProvider.postAddedCart(
        context,
        product.productId,
        null,
        1,
        price,
        price,
      );

      ToastUtils.showSuccess("Test: Product added to cart");
    } catch (e) {
      print("🧪 TEST: Error adding to cart: $e");
      ToastUtils.showError("Test failed: ${e.toString()}");
    }
  }

  Future<void> _testGetCart(
    BuildContext context,
    CartProvider cartProvider,
    EmailAuthProvider authProvider,
  ) async {
    try {
      print("🧪 TEST: Starting get cart test");

      if (!authProvider.isLoggedIn) {
        ToastUtils.showError("Please login first");
        return;
      }

      await cartProvider.getCart(context);

      final cartCount = cartProvider.cartModel?.cart?.length ?? 0;
      ToastUtils.showSuccess("Test: Cart has $cartCount items");
    } catch (e) {
      print("🧪 TEST: Error getting cart: $e");
      ToastUtils.showError("Test failed: ${e.toString()}");
    }
  }

  Future<void> _testRemoveFromCart(
    BuildContext context,
    CartProvider cartProvider,
    EmailAuthProvider authProvider,
  ) async {
    try {
      print("🧪 TEST: Starting remove from cart test");

      if (!authProvider.isLoggedIn) {
        ToastUtils.showError("Please login first");
        return;
      }

      await cartProvider.deleteCart(product.productId);

      ToastUtils.showSuccess("Test: Product removed from cart");
    } catch (e) {
      print("🧪 TEST: Error removing from cart: $e");
      ToastUtils.showError("Test failed: ${e.toString()}");
    }
  }

  Future<void> _testClearCart(
    BuildContext context,
    CartProvider cartProvider,
    EmailAuthProvider authProvider,
  ) async {
    try {
      print("🧪 TEST: Starting clear cart test");

      await cartProvider.clearEntireCart(context);

      ToastUtils.showSuccess("Test: Cart cleared");
    } catch (e) {
      print("🧪 TEST: Error clearing cart: $e");
      ToastUtils.showError("Test failed: ${e.toString()}");
    }
  }
}
