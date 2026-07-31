import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Utils/app_colors.dart';
import '../../Screens/Auth/email section/provider/email_authProvider.dart';
import 'provider/cart_provider.dart';
import 'services/cart_screen_service.dart';
import 'services/cart_refresh_service.dart';
import 'widgets/cart_app_bar.dart';
import 'widgets/cart_loading_state.dart';
import 'widgets/cart_empty_state.dart';
import 'widgets/cart_login_required_state.dart';
import 'widgets/cart_items_list.dart';
import 'widgets/cart_bottom_navigation.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Refresh cart when app becomes active
    if (state == AppLifecycleState.resumed) {
      CartRefreshService.autoRefreshCartIfNeeded(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: const CartAppBar(),
      body: Consumer2<CartProvider, EmailAuthProvider>(
        builder: (context, cartProvider, authProvider, child) {
          // Initialize cart if not already done
          CartScreenService.initializeCartIfNeeded(context, cartProvider);

          // Auto-refresh cart if needed
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CartRefreshService.autoRefreshCartIfNeeded(context);
          });

          if (cartProvider.isLoading) {
            return const CartLoadingState();
          }

          if (!authProvider.isLoggedIn) {
            return const CartLoginRequiredState();
          }

          if (cartProvider.cartModel?.cart == null ||
              cartProvider.cartModel!.cart!.isEmpty) {
            return const CartEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () => CartRefreshService.forceRefreshCart(context),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: CartItemsList(cartProvider: cartProvider),
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer2<CartProvider, EmailAuthProvider>(
        builder: (context, cartProvider, authProvider, child) {
          if (!authProvider.isLoggedIn ||
              cartProvider.cartModel?.cart == null ||
              cartProvider.cartModel!.cart!.isEmpty) {
            return const SizedBox.shrink();
          }

          return CartBottomNavigation(
            cartProvider: cartProvider,
            onCheckoutPressed: () =>
                CartScreenService.navigateToCheckout(context),
          );
        },
      ),
    );
  }
}
