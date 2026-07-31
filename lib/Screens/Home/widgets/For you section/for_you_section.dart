import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klik_app/Screens/Home/widgets/For%20you%20section/provider/for_you_provider.dart';
import 'package:provider/provider.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../global widgets/product_card.dart';
import '../../../../models/product/product_model.dart';
import '../../../ProductDetail/product_details_screen.dart';

class ForYouSectionWidget extends StatefulWidget {
  const ForYouSectionWidget({super.key});

  @override
  State<ForYouSectionWidget> createState() => _ForYouSectionWidgetState();
}

class _ForYouSectionWidgetState extends State<ForYouSectionWidget> {
  final ScrollController _scrollController = ScrollController();
  late List<GlobalKey> _tabKeys;

  @override
  void initState() {
    super.initState();
    _tabKeys = [];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: Consumer<ForYouProvider>(
        builder: (context, forYouProvider, child) {
          _initializeTabKeys(forYouProvider.categories.length);
          return Column(
            children: [
              _buildTabButtons(forYouProvider),
              SizedBox(height: 10.h),
              _getProductByTag(forYouProvider.selectedCategoryProducts),
            ],
          );
        },
      ),
    );
  }

  /// Ensures `_tabKeys` is updated when the categories length changes
  void _initializeTabKeys(int length) {
    if (_tabKeys.length != length) {
      _tabKeys = List.generate(length, (index) => GlobalKey());
    }
  }

  Widget _buildTabButtons(ForYouProvider provider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SizedBox(
        height: 25.h,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: provider.categories.length,
          itemBuilder: (context, index) {
            bool isSelected = index == provider.selectedIndex;
            return GestureDetector(
              key: _tabKeys[index],
              onTap: () {
                provider.updateIndex(index);
                _scrollToIndex(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.scaffoldColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                  boxShadow: isSelected
                      ? [
                          const BoxShadow(
                              color: AppColors.boxShadowColor, blurRadius: 2)
                        ]
                      : [],
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      provider.categories[index],
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getProductByTag(List<Map<String, dynamic>> products) {
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
          showLimitedTimeOffer: product['limitedTime'] ?? false,
          onTap: () {
            _navigateToProductDetail(context, product);
          },
        );
      },
    );
  }

  /// Smoothly scrolls to the tapped index
  void _scrollToIndex(int index) {
    if (!_scrollController.hasClients) return;
    final keyContext = _tabKeys[index].currentContext;
    if (keyContext == null) return;

    Scrollable.ensureVisible(
      keyContext,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: 0.5, // Centers the selected tab
    );
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
        brandName: 'Recommended', // Default brand for recommended items
        price: productData['price'] ?? 0,
        discountPrice: productData['discountedPercent'] != null
            ? (productData['price'] *
                    (1 - productData['discountedPercent'] / 100))
                .round()
            : productData['price'] ?? 0,
        description: 'Recommended product for you!',
        stock: 10, // Default stock for recommended items
        categories: ['Recommended'],
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
        SnackBar(
          content: Text('Error loading product details'),
          backgroundColor: AppColors.redColor,
        ),
      );
    }
  }
}
