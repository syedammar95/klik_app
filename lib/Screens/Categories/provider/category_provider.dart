import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../models/category/categories_model.dart';
import '../../../models/product/product_model.dart';
import '../../../services/category_service.dart';
import '../../../Utils/constants/my_sharePrefs.dart';
import '../../../services/product_service.dart';
import '../../../providers/product_provider.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  final ProductService _productService = ProductService();
  final MySharedPrefs _prefs = MySharedPrefs();
  final ProductProvider _productProvider = ProductProvider();

  String _selectedCategory = '';
  final Map<String, bool> _expandedStates = {};
  List<CategoryModel> _categories = [];
  List<Map<String, dynamic>> _categoriesForUI = [];
  bool _isLoading = false;

  /// **📌 Getters**
  String get selectedCategory => _selectedCategory;

  List<CategoryModel> get categories => _categories;

  /// **📌 UI-Compatible Categories (Map format)**
  List<Map<String, dynamic>> get categoriesForUI => _categoriesForUI;

  bool get isLoading => _isLoading;

  /// **🔹 Select Category**
  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  /// **🔹 Toggle Expand State**
  void toggleExpanded(String subfield) {
    _expandedStates[subfield] = !(_expandedStates[subfield] ?? false);
    notifyListeners();
  }

  bool isExpanded(String subfield) {
    return _expandedStates[subfield] ?? false;
  }

  /// **📌 Fetch Categories from API with comprehensive caching**
  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      // ✅ Try to get cached data first with proper validation
      final cachedData = await _prefs.getCategoriesData();
      if (cachedData != null) {
        debugPrint("📦 Using cached categories data");
        final response = jsonDecode(cachedData);
        if (response['success'] == true) {
          _categories = (response['categories'] as List<dynamic>)
              .map((e) => CategoryModel.fromJson(e))
              .toList();

          // Convert to UI-compatible format
          _categoriesForUI = _convertToUIFormat(_categories);

          // ✅ Load products for each category with caching
          await _loadProductsForCategoriesWithCache();

          if (_categories.isNotEmpty) {
            _selectedCategory = _categories.first.name;
          }
          _isLoading = false;
          notifyListeners();
          debugPrint(
              "✅ Categories loaded from cache: ${_categories.length} categories");
          return;
        }
      }

      // If no cache or cache invalid, fetch from API
      debugPrint("🔄 Fetching categories from API...");
      final response = await _categoryService.getCategories();
      debugPrint("📥 API Response: $response");

      if (response != null && response['success'] == true) {
        _categories = (response['categories'] as List<dynamic>)
            .map((e) => CategoryModel.fromJson(e))
            .toList();

        // Convert to UI-compatible format
        _categoriesForUI = _convertToUIFormat(_categories);

        // ✅ Load products for each category with caching
        await _loadProductsForCategoriesWithCache();

        if (_categories.isNotEmpty) {
          _selectedCategory = _categories.first.name;
        }

        // ✅ Cache the response
        await _prefs.saveCategoriesData(jsonEncode(response));
        debugPrint(
            "✅ Categories loaded successfully from API: ${_categories.length} categories");
      } else {
        debugPrint("❌ API response failed or null: $response");
        _categories = [];
        _categoriesForUI = [];
      }
    } catch (e) {
      debugPrint("❌ Error fetching categories: $e");
      debugPrint("❌ Stack trace: ${StackTrace.current}");
      _categories = [];
      _categoriesForUI = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  /// ✅ Load products for each category with comprehensive caching
  Future<void> _loadProductsForCategoriesWithCache() async {
    final updatedCategories = <CategoryModel>[];

    // ✅ Try to get cached products first with proper validation
    String? cachedProductsData = await _prefs.getAllProductsData();
    List<ProductModel> allProducts = [];

    if (cachedProductsData != null) {
      try {
        debugPrint("📦 Using cached products data");
        final response = jsonDecode(cachedProductsData);
        if (response['success'] == true && response['products'] != null) {
          allProducts = (response['products'] as List<dynamic>)
              .map((e) => ProductModel.fromJson(e))
              .toList();
          debugPrint("✅ Loaded ${allProducts.length} products from cache");
        }
      } catch (e) {
        debugPrint("❌ Error parsing cached products: $e");
      }
    }

    // If no cached products, fetch from API
    if (allProducts.isEmpty) {
      debugPrint("🔄 Fetching products from API...");
      allProducts = await _productService.fetchProducts();

      // ✅ Cache the products response
      if (allProducts.isNotEmpty) {
        final productsResponse = {
          'success': true,
          'products': allProducts.map((p) => p.toJson()).toList(),
        };
        await _prefs.setString(
            'all_products_cache', jsonEncode(productsResponse));
        await _prefs.setString('all_products_cache_time',
            DateTime.now().millisecondsSinceEpoch.toString());
        debugPrint("✅ Cached ${allProducts.length} products");
      }
    }

    for (var category in _categories) {
      try {
        // Filter products for this category
        final categoryProducts = allProducts.where((product) {
          // Check if product's categoryId matches
          final matchesCategoryId = product.categoryId == category.id;

          // Check if product's categories list contains this category
          final matchesCategoriesList = product.categories.any((catId) {
            try {
              final parsedId = int.tryParse(catId);
              return parsedId == category.id;
            } catch (e) {
              debugPrint('Error parsing category ID: $catId');
              return false;
            }
          });

          final matches = matchesCategoryId || matchesCategoriesList;
          if (matches) {
            debugPrint(
                'Product ${product.productName} matches category ${category.name}');
            debugPrint('- categoryId match: $matchesCategoryId');
            debugPrint('- categories list match: $matchesCategoriesList');
          }

          return matches;
        }).toList();

        debugPrint(
            'Category ${category.name} has ${categoryProducts.length} products');
        if (categoryProducts.isNotEmpty) {
          debugPrint('First product: ${categoryProducts.first.productName}');
        }

        final updatedCategory = CategoryModel(
          id: category.id,
          name: category.name,
          icon: category.icon,
          parentId: category.parentId,
          subcategories: category.subcategories,
          products: categoryProducts,
        );
        updatedCategories.add(updatedCategory);
      } catch (e) {
        debugPrint("Error loading products for category ${category.name}: $e");
        updatedCategories.add(category);
      }
    }

    _categories = updatedCategories;
    notifyListeners();
  }

  /// ✅ Clear all categories, subcategories, and products cache
  Future<void> clearCache() async {
    await _prefs.clearCategoriesCache();
    // Also clear the all products cache
    await _prefs.remove('all_products_cache');
    await _prefs.remove('all_products_cache_time');
    debugPrint("✅ Cleared all category-related cache");
  }

  /// ✅ Clear expired cache entries
  Future<void> clearExpiredCache() async {
    await _prefs.clearExpiredCache();
    debugPrint("✅ Cleared expired cache entries");
  }

  /// **🔹 Convert CategoryModel list to UI-compatible Map format**
  List<Map<String, dynamic>> _convertToUIFormat(
      List<CategoryModel> categories) {
    return categories
        .map((category) => {
              'id': category.id,
              'category_name': category.name,
              'category_icon': category.icon,
              'parent_id': category.parentId,
              'subcategories': category.subcategories
                  .map((sub) => {
                        'id': sub.id,
                        'category_name': sub.name,
                        'category_icon': sub.icon,
                        'parent_id': sub.parentId,
                        'subfields': sub.products
                            .map((product) => {
                                  'name': product.productName,
                                  'image': product.images.isNotEmpty
                                      ? product.images.first
                                      : 'assets/images/default.png',
                                })
                            .toList(),
                      })
                  .toList(),
            })
        .toList();
  }

  /// ✅ **Get Products for Subcategory with comprehensive caching**
  Future<List<Map<String, dynamic>>> getProductsForSubcategory(
      int subcategoryId) async {
    try {
      debugPrint('🔄 Getting products for subcategory ID: $subcategoryId');

      // ✅ First, try to get cached subcategory products
      final cachedSubcategoryData =
          await _prefs.getSubcategoryProductsData(subcategoryId.toString());
      if (cachedSubcategoryData != null) {
        debugPrint(
            "📦 Using cached subcategory products for ID: $subcategoryId");
        try {
          final response = jsonDecode(cachedSubcategoryData);
          if (response['success'] == true && response['products'] != null) {
            final products = (response['products'] as List<dynamic>)
                .map((e) => ProductModel.fromJson(e))
                .toList();

            debugPrint(
                "✅ Loaded ${products.length} cached products for subcategory $subcategoryId");

            // Convert ProductModel to Map format expected by UI
            return products
                .map((product) => {
                      'id': product.productId,
                      'name': product.productName,
                      'image':
                          product.images.isNotEmpty ? product.images.first : '',
                      'price': product.price,
                      'discountPrice': product.discountPrice,
                      'brand': product.brandName,
                      'stock': product.stock,
                      'rating': product.rating,
                      'description': product.description,
                      'images': product.images,
                      'categories': product.categories,
                      'variations':
                          product.variations.map((v) => v.toJson()).toList(),
                      'tags': product.tags.map((t) => t.toJson()).toList(),
                      'vendorId': product.vendorId,
                      'categoryId': product.categoryId,
                      'brandId': product.brandId,
                    })
                .toList();
          }
        } catch (e) {
          debugPrint("❌ Error parsing cached subcategory products: $e");
        }
      }

      // ✅ If no cache, fetch all products and filter by subcategory ID
      debugPrint('🔄 Fetching all products to filter by subcategory...');

      // ✅ Try to get cached all products first with proper validation
      String? cachedProductsData = await _prefs.getAllProductsData();
      List<ProductModel> allProducts = [];

      if (cachedProductsData != null) {
        try {
          debugPrint("📦 Using cached all products data");
          final response = jsonDecode(cachedProductsData);
          if (response['success'] == true && response['products'] != null) {
            allProducts = (response['products'] as List<dynamic>)
                .map((e) => ProductModel.fromJson(e))
                .toList();
            debugPrint("✅ Loaded ${allProducts.length} products from cache");
          }
        } catch (e) {
          debugPrint("❌ Error parsing cached products: $e");
        }
      }

      // If no cached products, fetch from API
      if (allProducts.isEmpty) {
        allProducts = await _productService.fetchProducts();
        debugPrint('📦 Total products fetched from API: ${allProducts.length}');

        // Cache the products response
        if (allProducts.isNotEmpty) {
          final productsResponse = {
            'success': true,
            'products': allProducts.map((p) => p.toJson()).toList(),
          };
          await _prefs.setString(
              'all_products_cache', jsonEncode(productsResponse));
          await _prefs.setString('all_products_cache_time',
              DateTime.now().millisecondsSinceEpoch.toString());
          debugPrint("✅ Cached ${allProducts.length} products");
        }
      }

      // Filter products that belong to this subcategory
      final subcategoryProducts = allProducts.where((product) {
        // Check if product's categoryId matches the subcategory ID
        final matchesCategoryId = product.categoryId == subcategoryId;

        // Check if product's categories list contains this subcategory ID
        final matchesCategoriesList = product.categories.any((cat) {
          try {
            final parsedId = int.tryParse(cat);
            return parsedId == subcategoryId;
          } catch (e) {
            debugPrint('Error parsing category ID: $cat');
            return false;
          }
        });

        final matches = matchesCategoryId || matchesCategoriesList;
        if (matches) {
          debugPrint(
              '✅ Found matching product: ${product.productName} for subcategory $subcategoryId');
        }
        return matches;
      }).toList();

      debugPrint(
          '✅ Found ${subcategoryProducts.length} products for subcategory $subcategoryId');

      // ✅ Cache the filtered subcategory products
      if (subcategoryProducts.isNotEmpty) {
        final subcategoryResponse = {
          'success': true,
          'products': subcategoryProducts.map((p) => p.toJson()).toList(),
        };
        await _prefs.saveSubcategoryProductsData(
            subcategoryId.toString(), jsonEncode(subcategoryResponse));
        debugPrint(
            "✅ Cached ${subcategoryProducts.length} products for subcategory $subcategoryId");
      }

      // Convert ProductModel to Map format expected by UI
      return subcategoryProducts
          .map((product) => {
                'id': product.productId,
                'name': product.productName,
                'image': product.images.isNotEmpty ? product.images.first : '',
                'price': product.price,
                'discountPrice': product.discountPrice,
                'brand': product.brandName,
                'stock': product.stock,
                'rating': product.rating,
                'description': product.description,
                'images': product.images,
                'categories': product.categories,
                'variations':
                    product.variations.map((v) => v.toJson()).toList(),
                'tags': product.tags.map((t) => t.toJson()).toList(),
                'vendorId': product.vendorId,
                'categoryId': product.categoryId,
                'brandId': product.brandId,
              })
          .toList();
    } catch (e) {
      debugPrint(
          '❌ Error fetching products for subcategory $subcategoryId: $e');
      return [];
    }
  }

  /// ✅ **Get Cached Products for Subcategory (Synchronous)**
  List<Map<String, dynamic>> getCachedProductsForSubcategory(
      int subcategoryId) {
    try {
      debugPrint(
          '🔄 Getting cached products for subcategory ID: $subcategoryId');

      // ✅ Use ProductProvider cache to get products filtered by subcategory ID
      final products = _productProvider.getProducts(subcategoryId.toString());
      debugPrint(
          '📦 Found ${products.length} cached products for subcategory $subcategoryId');

      // Convert ProductModel to Map format expected by UI
      return products
          .map((product) => {
                'id': product.productId,
                'name': product.productName,
                'image': product.images.isNotEmpty ? product.images.first : '',
                'price': product.price,
                'discountPrice': product.discountPrice,
                'brand': product.brandName,
                'stock': product.stock,
                'rating': product.rating,
                'description': product.description,
                'images': product.images,
                'categories': product.categories,
                'variations':
                    product.variations.map((v) => v.toJson()).toList(),
                'tags': product.tags.map((t) => t.toJson()).toList(),
                'vendorId': product.vendorId,
                'categoryId': product.categoryId,
                'brandId': product.brandId,
              })
          .toList();
    } catch (e) {
      debugPrint(
          '❌ Error getting cached products for subcategory $subcategoryId: $e');
      return [];
    }
  }

  /// 🔹 **Check if Products are Loading for Subcategory**
  bool isProductsLoadingForSubcategory(int subcategoryId) {
    return _productProvider.isLoadingCategory(subcategoryId.toString());
  }
}
