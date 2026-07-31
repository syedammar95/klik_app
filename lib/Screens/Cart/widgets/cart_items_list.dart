import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provider/cart_provider.dart';
import 'my_cart_card.dart';
import '../services/cart_screen_service.dart';

class CartItemsList extends StatelessWidget {
  final CartProvider cartProvider;

  const CartItemsList({
    super.key,
    required this.cartProvider,
  });

  @override
  Widget build(BuildContext context) {
    final cartItems = cartProvider.cartModel?.cart ?? [];

    return Column(
      children: [
        ...cartItems.map((item) {
          return Column(
            children: [
              MyCartCard(
                cartItem: item,
                onAdd: () => CartScreenService.handleQuantityUpdate(
                    context, cartProvider, item, (item.quantity ?? 1) + 1),
                onRemove: () => CartScreenService.handleQuantityUpdate(
                    context, cartProvider, item, (item.quantity ?? 1) - 1),
                onDelete: () => CartScreenService.handleDeleteItem(
                    context, cartProvider, item),
              ),
              SizedBox(height: 4.h),
            ],
          );
        }),
      ],
    );
  }
}
