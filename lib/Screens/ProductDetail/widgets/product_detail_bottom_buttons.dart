import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../Utils/app_colors.dart';
import '../../../models/product/product_model.dart';
import '../../../Screens/Cart/provider/cart_provider.dart';
import '../../../Utils/helpers/toast_utils.dart';

/// ProductDetailBottomButtons Widget
/// Displays the bottom action buttons for add to cart and buy now
class ProductDetailBottomButtons extends StatelessWidget {
  final ProductModel product;

  const ProductDetailBottomButtons({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final isInCart = cartProvider.inCart(product.productId);
        final isAddingToCart = cartProvider.isAddingToCart;

        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(color: AppColors.boxShadowColor, blurRadius: 2),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildCartButton(
                    context, cartProvider, isInCart, isAddingToCart),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCartButton(BuildContext context, CartProvider cartProvider,
      bool isInCart, bool isAddingToCart) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        backgroundColor: isInCart ? AppColors.redColor : AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      onPressed: product.stock > 0 && !isAddingToCart
          ? () => _handleCartAction(context, cartProvider, isInCart)
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
      BuildContext context, CartProvider cartProvider, bool isInCart) async {
    try {
      if (isInCart) {
        // Remove from cart
        await cartProvider.deleteCart(product.productId);
        ToastUtils.showSuccess("${product.productName} removed from cart");
      } else {
        // Add to cart
        await cartProvider.postAddedCart(
          context,
          product.productId,
          null, // variationId
          1, // quantity
          product.discountPrice > 0
              ? product.discountPrice.toDouble()
              : product.price.toDouble(),
          product.discountPrice > 0
              ? product.discountPrice.toDouble()
              : product.price.toDouble(),
        );
        ToastUtils.showSuccess("${product.productName} added to cart");
      }
    } catch (e) {
      ToastUtils.showError("Failed to update cart: ${e.toString()}");
    }
  }
}
