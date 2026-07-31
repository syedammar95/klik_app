import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../global widgets/product_card.dart';
import '../../../../models/product/product_model.dart';
import '../../../ProductDetail/product_details_screen.dart';
import 'flash_sale_screen.dart';

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = _getMustBuyProducts();

    return Column(
      children: [
        _buildSectionHeader(context),
        _buildHorizontalProductList(products),
      ],
    );
  }

  /// **Section Header with 'More' Button**
  Widget _buildSectionHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Flash Sale',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FlashSaleScreen()),
              );
            },
            child: Text(
              'More',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// **Optimized Horizontal Product ListView**
  Widget _buildHorizontalProductList(List<Map<String, dynamic>> products) {
    return SizedBox(
      height: 245.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 1.79,
          // mainAxisSpacing: 6,
        ),
        itemCount: products.length,
        padding: EdgeInsets.symmetric(horizontal: 10.w), // Responsive padding
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            imageUrl: product['imageUrl'],
            productName: product['productName'],
            price: product['price'],
            discountedPercent: product['discountedPercent'],
            rating: product['rating'],
            ratingCount: product['ratingCount'],
            soldCount: product['soldCount'],
            showFreeDelivery: product['freeDelivery'] ?? false,
            showLimitedTimeOffer: product['limitedTime'] ?? false,
            onTap: () {
              _navigateToProductDetail(context, product);
            },
          );
        },
      ),
    );
  }

  /// **Must Buy Products List**
  List<Map<String, dynamic>> _getMustBuyProducts() {
    return [
      {
        'imageUrl': 'assets/images/nike_runner.png',
        'productName': 'Nike Runner',
        'price': 1749,
        'discountedPercent': 15,
        'rating': 4.5,
        'ratingCount': 500,
        'soldCount': 700,
        'freeDelivery': true,
        'limitedTime': true,
      },
      {
        'imageUrl': 'assets/images/product4.png',
        'productName': 'Leather Jacket by F&N',
        'price': 9450,
        'discountedPercent': 35,
        'rating': 4.5,
        'ratingCount': 151,
        'soldCount': 300,
        'freeDelivery': false,
        'limitedTime': true,
      },
      {
        'imageUrl': 'assets/images/beauty.png',
        'productName': 'Zara Makeup Kit',
        'price': 749,
        'discountedPercent': 6,
        'rating': 3.0,
        'ratingCount': 7,
        'soldCount': 13,
        'freeDelivery': true,
        'limitedTime': true,
      },
      {
        'imageUrl': 'assets/images/product2.png',
        'productName': 'Branded Bag',
        'price': 5500,
        'discountedPercent': 25,
        'rating': 4.8,
        'ratingCount': 123,
        'soldCount': 713,
        'freeDelivery': true,
        'limitedTime': true,
      },
      {
        'imageUrl': 'assets/images/img.png',
        'productName': 'Casual Shirt',
        'price': 635,
        'discountedPercent': 10,
        'rating': 2.9,
        'ratingCount': 43,
        'soldCount': 71,
        'freeDelivery': false,
        'limitedTime': true,
      },
    ];
  }

  /// 🔹 **Navigate to Product Detail Screen**
  void _navigateToProductDetail(
      BuildContext context, Map<String, dynamic> productData) {
    try {
      // Create a ProductModel from the product data
      final product = ProductModel(
        productId: DateTime.now().millisecondsSinceEpoch, // Generate unique ID
        productName:
            productData['productName']?.toString() ?? 'Unknown Product',
        brandName: 'Must Buy', // Default brand for must buy items
        price: productData['price'] ?? 0,
        discountPrice: productData['discountedPercent'] != null
            ? (productData['price'] *
                    (1 - productData['discountedPercent'] / 100))
                .round()
            : productData['price'] ?? 0,
        description: 'Must buy product - Highly recommended!',
        stock: 10, // Default stock for must buy items
        categories: ['Must Buy'],
        images: productData['imageUrl']?.toString().isNotEmpty == true
            ? [productData['imageUrl'].toString()]
            : [],
        variations: [],
        tags: [],
        rating: (productData['rating'] ?? 0.0).toDouble(),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailScreen(product: product),
        ),
      );
    } catch (e) {
      debugPrint('Error navigating to product detail: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error loading product details'),
          backgroundColor: AppColors.redColor,
        ),
      );
    }
  }
}
