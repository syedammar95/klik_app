import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../Utils/app_colors.dart';
import '../../../models/product/product_model.dart';
import '../../../models/product/variation_model.dart';
import '../provider/category_provider.dart';
import '../../ProductDetail/product_details_screen.dart';
import 'product_widget.dart';

class ListProducts extends StatefulWidget {
  final String fieldName;
  final int subcategoryId;
  final List<String> subfields;
  final List<String> imageUrls;

  const ListProducts({
    super.key,
    required this.fieldName,
    required this.subcategoryId,
    this.subfields = const [],
    this.imageUrls = const [],
  });

  @override
  State<ListProducts> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final expandableProvider = context.watch<CategoryProvider>();
    final bool isExpanded = expandableProvider.isExpanded(widget.fieldName);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            expandableProvider.toggleExpanded(widget.fieldName);
            if (isExpanded && _products.isEmpty) {
              _loadProducts();
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isExpanded
                      ? AppColors.boxShadowColor
                      : AppColors.boxShadowColor,
                  width: 0.w,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.fieldName,
                  style: TextStyle(fontSize: 12.sp),
                ),
                Row(
                  children: [
                    Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.boxShadowColor, width: 0.w),
              ),
            ),
            child: _buildProductsGrid(),
          ),
      ],
    );
  }

  /// 🔹 **Load Products for Subcategory**
  Future<void> _loadProducts() async {
    if (_products.isNotEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      final products = await categoryProvider
          .getProductsForSubcategory(widget.subcategoryId);

      if (mounted) {
        setState(() {
          _products = products;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// 🔹 **Build Products Grid**
  Widget _buildProductsGrid() {
    if (_isLoading) {
      return SizedBox(
        height: 200.h,
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 0.5,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ),
      );
    }

    if (_products.isEmpty) {
      return SizedBox(
        height: 100.h,
        child: Center(
          child: Text(
            'No products available',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.greyColor,
            ),
          ),
        ),
      );
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2 / 2,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return ProductWidget(
          containerWidth: 50.w,
          imageUrl: product['image']?.toString() ?? '',
          text: product['name']?.toString() ?? 'Unknown Product',
          textWeight: FontWeight.w500,
          textSize: 10.sp,
          onTap: () {
            _navigateToProductDetail(product);
          },
        );
      },
    );
  }

  /// 🔹 **Navigate to Product Detail Screen**
  void _navigateToProductDetail(Map<String, dynamic> productData) {
    try {
      // Debug: Log the product data being passed
      debugPrint('=== NAVIGATION DEBUG ===');
      debugPrint('Product ID: ${productData['id']}');
      debugPrint('Product Name: ${productData['name']}');
      debugPrint('Description: "${productData['description']}"');
      debugPrint(
          'Description length: ${productData['description']?.toString().length ?? 0}');
      debugPrint('========================');

      // Create a ProductModel from the product data
      final product = ProductModel(
        productId: productData['id'] ?? 0,
        productName: productData['name']?.toString() ?? 'Unknown Product',
        brandName: productData['brand']?.toString() ?? '',
        price: productData['price'] ?? 0,
        discountPrice: productData['discountPrice'] ?? 0,
        description: productData['description']?.toString() ??
            '', // ✅ Now properly included
        stock: productData['stock'] ?? 0,
        categories: (productData['categories'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        images: (productData['images'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            (productData['image']?.toString().isNotEmpty == true
                ? [productData['image'].toString()]
                : []),
        variations: (productData['variations'] as List<dynamic>?)
                ?.map((v) => VariationModel.fromJson(v as Map<String, dynamic>))
                .toList() ??
            [],
        tags: (productData['tags'] as List<dynamic>?)
                ?.map((t) => TagModel.fromJson(t as Map<String, dynamic>))
                .toList() ??
            [],
        rating: (productData['rating'] ?? 0.0).toDouble(),
        vendorId: productData['vendorId'],
        categoryId: productData['categoryId'] ?? 0,
        brandId: productData['brandId'] ?? 0,
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
