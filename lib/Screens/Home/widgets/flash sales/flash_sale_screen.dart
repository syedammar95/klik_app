import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../global widgets/product_card.dart';
import '../../../../models/product/product_model.dart';
import '../../../ProductDetail/product_details_screen.dart';

class FlashSaleScreen extends StatelessWidget {
  const FlashSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products = _getFlashSaleProduct();

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Flash Sale',
          style: TextStyle(
            fontSize: 18.sp,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: _buildProductGrid(products),
        ),
      ),
    );
  }

  /// Function to create product grid
  Widget _buildProductGrid(List<Map<String, dynamic>> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3.1,
      ),
      itemCount: products.length,
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
          onTap: () {
            _navigateToProductDetail(context, product);
          },
        );
      },
    );
  }

  /// Function to return Flash Sale Products List
  List<Map<String, dynamic>> _getFlashSaleProduct() {
    return [
      {
        'imageUrl': 'assets/images/img.png',
        'productName': 'Branded 5 in 1',
        'price': 150,
        'discountedPercent': 10,
        'rating': 4.5,
        'ratingCount': 10,
        'soldCount': 10,
        'freeDelivery': true,
      },
      {
        'imageUrl': 'assets/images/img.png',
        'productName': 'Branded 5 in 1',
        'price': 150,
        'discountedPercent': 20,
        'rating': 4.5,
        'ratingCount': 10,
        'soldCount': 10,
        'freeDelivery': false,
      },
      {
        'imageUrl': 'assets/images/img.png',
        'productName': 'Branded 5 in 1',
        'price': 150,
        'discountedPercent': 30,
        'rating': 4.4,
        'ratingCount': 10,
        'soldCount': 10,
        'freeDelivery': true,
      },
      {
        'imageUrl': 'assets/images/img.png',
        'productName': 'Branded 5 in 1',
        'price': 150,
        'discountedPercent': 15,
        'rating': 4.4,
        'ratingCount': 10,
        'soldCount': 10,
        'freeDelivery': true,
      },
      {
        'imageUrl': 'assets/images/img.png',
        'productName': 'Branded 5 in 1',
        'price': 150,
        'discountedPercent': 15,
        'rating': 4.4,
        'ratingCount': 10,
        'soldCount': 10,
        'freeDelivery': true,
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
        brandName: 'Flash Sale', // Default brand for flash sale items
        price: productData['price'] ?? 0,
        discountPrice: productData['discountedPercent'] != null
            ? (productData['price'] *
                    (1 - productData['discountedPercent'] / 100))
                .round()
            : productData['price'] ?? 0,
        description: 'Flash sale product - Limited time offer!',
        stock: 10, // Default stock for flash sale items
        categories: ['Flash Sale'],
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
