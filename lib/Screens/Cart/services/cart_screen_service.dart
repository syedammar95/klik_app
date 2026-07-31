import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../../../Screens/Auth/email section/provider/email_authProvider.dart';
import '../../../Utils/helpers/toast_utils.dart';
import '../../Checkout/checkout_screen.dart';

class CartScreenService {
  /// Handle quantity update for cart items
  static Future<void> handleQuantityUpdate(
    BuildContext context,
    CartProvider cartProvider,
    dynamic item,
    int newQuantity,
  ) async {
    if (newQuantity <= 0) {
      await handleDeleteItem(context, cartProvider, item);
    } else {
      try {
        cartProvider.updateQuantity(
          cartProvider.cartModel!.cart!.indexOf(item),
          newQuantity,
          item.productId!,
        );
      } catch (e) {
        ToastUtils.showError('Failed to update quantity: ${e.toString()}');
      }
    }
  }

  /// Handle item deletion from cart
  static Future<void> handleDeleteItem(
    BuildContext context,
    CartProvider cartProvider,
    dynamic item,
  ) async {
    try {
      await cartProvider.deleteCart(item.productId!);
      ToastUtils.showSuccess('${item.productName} removed from cart');
    } catch (e) {
      ToastUtils.showError('Failed to remove item: ${e.toString()}');
    }
  }

  /// Navigate to checkout screen
  static void navigateToCheckout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CheckoutScreen(),
      ),
    );
  }

  /// Navigate to login screen
  static void navigateToLogin(BuildContext context) {
    // Implement navigation to login screen
    // You can add your login navigation logic here
  }

  /// Check if user is authenticated
  static bool isUserAuthenticated(BuildContext context) {
    final authProvider = Provider.of<EmailAuthProvider>(context, listen: false);
    return authProvider.isLoggedIn;
  }

  /// Initialize cart if needed
  static void initializeCartIfNeeded(
    BuildContext context,
    CartProvider cartProvider,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!cartProvider.isInitialized) {
        cartProvider.initialize(context);
      }
    });
  }
}
