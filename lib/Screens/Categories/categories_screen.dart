import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../Utils/app_colors.dart';
import 'provider/category_provider.dart';
import 'widgets/category_item.dart';
import 'widgets/list_products.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: _buildAppBar(),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          if (categoryProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final categories = categoryProvider.categoriesForUI;
          final selectedCategory = categoryProvider.selectedCategory;

          if (categories.isEmpty) {
            return const Center(child: Text("No categories available"));
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCategoryList(
                  categoryProvider, selectedCategory, categories),
              _buildExpandableFieldList(categories, selectedCategory),
            ],
          );
        },
      ),
    );
  }

  /// 🔹 **App Bar Widget**
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Categories',
        style: TextStyle(
          fontSize: 18.sp,
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      automaticallyImplyLeading: false,
    );
  }

  /// 🔹 **Category List (Left Side - API Integrated)**
  Widget _buildCategoryList(CategoryProvider provider, String selectedCategory,
      List<dynamic> categories) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.19,
      // padding: EdgeInsets.symmetric(horizontal: 1.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border.all(color: AppColors.whiteColor),
      ),
      child: ListView(
        children: categories.map((category) {
          final String categoryName =
              category['category_name']?.toString() ?? 'Unknown';
          final String imageUrl =
              _getFullImageUrl(category['category_icon']?.toString() ?? '');

          return CategoryItem(
            imageUrl: imageUrl,
            categoryName: categoryName,
            isSelected: selectedCategory == categoryName,
            circleFilledColor: AppColors.whiteColor,
            onTap: () => provider.selectCategory(categoryName),
          );
        }).toList(),
      ),
    );
  }

  /// 🔹 **Image URL Processing & Validation**
  String _getFullImageUrl(String imagePath) {
    // Handle null, empty, or invalid image paths
    if (imagePath.isEmpty ||
        imagePath == 'null' ||
        imagePath == 'NULL' ||
        imagePath.trim().isEmpty) {
      return ""; // Return empty string to trigger default icon
    }

    // Clean the image path
    String cleanPath = imagePath.trim();

    // Check for incomplete URLs (missing filename)
    if (cleanPath.endsWith('/') ||
        cleanPath.endsWith('/admin_panel') ||
        cleanPath.endsWith('/uploads') ||
        !cleanPath.contains('.')) {
      return ""; // Return empty string to trigger default icon
    }

    if (cleanPath.startsWith("http") || cleanPath.startsWith("https")) {
      return cleanPath; // ✅ Already a full URL
    } else if (cleanPath.startsWith("uploads/")) {
      return "https://ehomes.pk/$cleanPath"; // ✅ Use correct base URL
    } else {
      return "https://ehomes.pk/uploads/$cleanPath"; // ✅ Append base URL
    }
  }

  /// 🔹 **Expandable Subfields List (Right Side - API Integrated)**
  Widget _buildExpandableFieldList(
      List<dynamic> categories, String selectedCategory) {
    final selectedCategoryData = categories.firstWhere(
      (category) => category['category_name'] == selectedCategory,
      orElse: () => <String, dynamic>{},
    );

    if (selectedCategoryData.isEmpty ||
        selectedCategoryData['subcategories'] == null) {
      return const Expanded(
          child: Center(child: Text("No Subcategories Available")));
    }

    final List<dynamic> subcategories =
        selectedCategoryData['subcategories'] ?? [];

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 5.w),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border.all(color: AppColors.whiteColor),
          ),
          child: ListView.builder(
            itemCount: subcategories.length,
            itemBuilder: (context, index) {
              final subcategory = subcategories[index];
              return ListProducts(
                fieldName:
                    subcategory['category_name']?.toString() ?? 'Unknown',
                subcategoryId: subcategory['id'] is int
                    ? subcategory['id']
                    : int.tryParse(subcategory['id']?.toString() ?? '0') ?? 0,
                subfields: (subcategory['subfields'] as List<dynamic>?)
                        ?.map((e) => e['name']?.toString() ?? 'Unnamed')
                        .toList() ??
                    [],
                imageUrls: (subcategory['subfields'] as List<dynamic>?)
                        ?.map((e) =>
                            e['image']?.toString() ??
                            'assets/images/default.png')
                        .toList() ??
                    [],
              );
            },
          ),
        ),
      ),
    );
  }
}
