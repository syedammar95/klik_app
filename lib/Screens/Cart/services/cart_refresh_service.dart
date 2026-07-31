import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../../Auth/email section/provider/email_authProvider.dart';

class CartRefreshService {
  static const Duration _refreshInterval = Duration(seconds: 30);
  static DateTime? _lastRefresh;

  /// Automatically refresh cart data if needed
  static Future<void> autoRefreshCartIfNeeded(BuildContext context) async {
    final now = DateTime.now();

    // Only refresh if enough time has passed since last refresh
    if (_lastRefresh != null &&
        now.difference(_lastRefresh!) < _refreshInterval) {
      return;
    }

    try {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final authProvider =
          Provider.of<EmailAuthProvider>(context, listen: false);

      // Only refresh if user is logged in and cart is initialized
      if (authProvider.isLoggedIn && cartProvider.isInitialized) {
        await cartProvider.refreshCartState(context);
        _lastRefresh = now;
        debugPrint('🔄 Cart auto-refreshed at ${now.toString()}');
      }
    } catch (e) {
      debugPrint('❌ Error auto-refreshing cart: $e');
    }
  }

  /// Force refresh cart data
  static Future<void> forceRefreshCart(BuildContext context) async {
    try {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final authProvider =
          Provider.of<EmailAuthProvider>(context, listen: false);

      if (authProvider.isLoggedIn) {
        await cartProvider.refreshCartState(context);
        _lastRefresh = DateTime.now();
        debugPrint('🔄 Cart force-refreshed');
      }
    } catch (e) {
      debugPrint('❌ Error force-refreshing cart: $e');
    }
  }

  /// Reset refresh timer (useful when cart is manually updated)
  static void resetRefreshTimer() {
    _lastRefresh = null;
    debugPrint('🔄 Cart refresh timer reset');
  }

  /// Check if cart needs refresh
  static bool needsRefresh() {
    if (_lastRefresh == null) return true;
    return DateTime.now().difference(_lastRefresh!) >= _refreshInterval;
  }
}
