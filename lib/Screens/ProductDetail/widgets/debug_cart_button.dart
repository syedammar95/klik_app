import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../Utils/app_colors.dart';
import '../../../models/product/product_model.dart';
import '../../../Screens/Cart/provider/cart_provider.dart';
import '../../../Screens/Auth/email section/provider/email_authProvider.dart';
import '../../../Utils/helpers/toast_utils.dart';

/// Debug version of ProductDetailBottomButtons to help identify cart issues
class DebugCartButton extends StatelessWidget {
  final ProductModel product;

  const DebugCartButton({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<CartProvider, EmailAuthProvider>(
      builder: (context, cartProvider, authProvider, child) {
        final isInCart = cartProvider.inCart(product.productId);
        final isAddingToCart = cartProvider.isAddingToCart;
        final isLoggedIn = authProvider.isLoggedIn;

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
              // Debug Information
              Container(
                padding: EdgeInsets.all(8.w),
                margin: EdgeInsets.only(bottom: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.greyColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Debug Info:',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Product ID: ${product.productId}',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      'Is Logged In: $isLoggedIn',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      'Is In Cart: $isInCart',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      'Is Adding: $isAddingToCart',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      'Stock: ${product.stock}',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      'Price: ${product.price}',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      'Discount Price: ${product.discountPrice}',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
              // Cart Button
              Row(
                children: [
                  Expanded(
                    child: _buildCartButton(context, cartProvider, authProvider,
                        isInCart, isAddingToCart),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCartButton(
    BuildContext context,
    CartProvider cartProvider,
    EmailAuthProvider authProvider,
    bool isInCart,
    bool isAddingToCart,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        backgroundColor: isInCart ? AppColors.redColor : AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      onPressed: product.stock > 0 && !isAddingToCart
          ? () =>
              _handleCartAction(context, cartProvider, authProvider, isInCart)
          : null,
      child: isAddingToCart
          ? SizedBox(
              height: 20.h,
              width: 20.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
              ),
            )
          : Text(
              _getButtonText(isInCart),
              style: TextStyle(fontSize: 14.sp, color: AppColors.whiteColor),
            ),
    );
  }

  String _getButtonText(bool isInCart) {
    if (product.stock <= 0) return "Out of Stock";
    return isInCart ? "Remove from Cart" : "Add to Cart";
  }

  Future<void> _handleCartAction(
    BuildContext context,
    CartProvider cartProvider,
    EmailAuthProvider authProvider,
    bool isInCart,
  ) async {
    try {
      // Check if user is logged in
      if (!authProvider.isLoggedIn) {
        ToastUtils.showError("Please login to add items to cart");
        return;
      }

      // Check if user session is loaded
      if (authProvider.user == null) {
        ToastUtils.showError("User session not loaded. Please try again.");
        return;
      }

      print("🛒 Debug: Starting cart action for product ${product.productId}");
      print("🛒 Debug: User ID: ${authProvider.user!.id}");
      print("🛒 Debug: Product: ${product.productName}");
      print("🛒 Debug: Price: ${product.price}");
      print("🛒 Debug: Discount Price: ${product.discountPrice}");

      if (isInCart) {
        // Remove from cart
        print("🛒 Debug: Removing from cart");
        await cartProvider.deleteCart(product.productId);
        ToastUtils.showSuccess("${product.productName} removed from cart");
      } else {
        // Add to cart
        print("🛒 Debug: Adding to cart");

        // Calculate the correct price
        final price = product.discountPrice > 0
            ? product.discountPrice.toDouble()
            : product.price.toDouble();

        print("🛒 Debug: Using price: $price");

        await cartProvider.postAddedCart(
          context,
          product.productId,
          null, // variationId
          1, // quantity
          price,
          price,
        );
        ToastUtils.showSuccess("${product.productName} added to cart");
      }
    } catch (e) {
      print("🛒 Debug: Error in cart action: $e");
      ToastUtils.showError("Failed to update cart: ${e.toString()}");
    }
  }
}
