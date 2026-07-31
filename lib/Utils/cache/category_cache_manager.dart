import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../constants/my_sharePrefs.dart';
import '../../models/category/categories_model.dart';
import '../../models/product/product_model.dart';
import '../../services/category_service.dart';
import '../../services/product_service.dart';

/// ✅ **Category Cache Manager**
/// Centralized cache management for categories, subcategories, and products
class CategoryCacheManager {
  static final CategoryCacheManager _instance =
      CategoryCacheManager._internal();
  factory CategoryCacheManager() => _instance;
  CategoryCacheManager._internal();

  final MySharedPrefs _prefs = MySharedPrefs();
  final CategoryService _categoryService = CategoryService();
  final ProductService _productService = ProductService();

  /// ✅ **Get Categories with Cache**
  Future<List<CategoryModel>> getCategories() async {
    try {
      // Try cache first
      final cachedData = await _prefs.getCategoriesData();
      if (cachedData != null) {
        debugPrint("📦 Using cached categories data");
        final response = jsonDecode(cachedData);
        if (response['success'] == true) {
          return (response['categories'] as List<dynamic>)
              .map((e) => CategoryModel.fromJson(e))
              .toList();
        }
      }

      // Fetch from API
      debugPrint("🔄 Fetching categories from API...");
      final response = await _categoryService.getCategories();
      if (response != null && response['success'] == true) {
        final categories = (response['categories'] as List<dynamic>)
            .map((e) => CategoryModel.fromJson(e))
            .toList();

        // Cache the response
        await _prefs.saveCategoriesData(jsonEncode(response));
        debugPrint("✅ Cached ${categories.length} categories");
        return categories;
      }
    } catch (e) {
      debugPrint("❌ Error in getCategories: $e");
    }
    return [];
  }

  /// ✅ **Get All Products with Cache**
  Future<List<ProductModel>> getAllProducts() async {
    try {
      // Try cache first
      final cachedData = await _prefs.getAllProductsData();
      if (cachedData != null) {
        debugPrint("📦 Using cached products data");
        final response = jsonDecode(cachedData);
        if (response['success'] == true) {
          return (response['products'] as List<dynamic>)
              .map((e) => ProductModel.fromJson(e))
              .toList();
        }
      }

      // Fetch from API
      debugPrint("🔄 Fetching products from API...");
      final products = await _productService.fetchProducts();
      if (products.isNotEmpty) {
        // Cache the response
        final productsResponse = {
          'success': true,
          'products': products.map((p) => p.toJson()).toList(),
        };
        await _prefs.setString(
            'all_products_cache', jsonEncode(productsResponse));
        await _prefs.setString('all_products_cache_time',
            DateTime.now().millisecondsSinceEpoch.toString());
        debugPrint("✅ Cached ${products.length} products");
      }
      return products;
    } catch (e) {
      debugPrint("❌ Error in getAllProducts: $e");
    }
    return [];
  }

  /// ✅ **Get Products for Subcategory with Cache**
  Future<List<ProductModel>> getProductsForSubcategory(
      int subcategoryId) async {
    try {
      // Try subcategory-specific cache first
      final cachedData =
          await _prefs.getSubcategoryProductsData(subcategoryId.toString());
      if (cachedData != null) {
        debugPrint(
            "📦 Using cached subcategory products for ID: $subcategoryId");
        final response = jsonDecode(cachedData);
        if (response['success'] == true) {
          return (response['products'] as List<dynamic>)
              .map((e) => ProductModel.fromJson(e))
              .toList();
        }
      }

      // Get all products and filter
      final allProducts = await getAllProducts();
      final subcategoryProducts = allProducts.where((product) {
        final matchesCategoryId = product.categoryId == subcategoryId;
        final matchesCategoriesList = product.categories.any((cat) {
          try {
            final parsedId = int.tryParse(cat);
            return parsedId == subcategoryId;
          } catch (e) {
            return false;
          }
        });
        return matchesCategoryId || matchesCategoriesList;
      }).toList();

      // Cache the filtered results
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

      return subcategoryProducts;
    } catch (e) {
      debugPrint("❌ Error in getProductsForSubcategory: $e");
    }
    return [];
  }

  /// ✅ **Clear All Cache**
  Future<void> clearAllCache() async {
    await _prefs.clearCategoriesCache();
    await _prefs.remove('all_products_cache');
    await _prefs.remove('all_products_cache_time');
    debugPrint("✅ Cleared all category-related cache");
  }

  /// ✅ **Clear Expired Cache**
  Future<void> clearExpiredCache() async {
    await _prefs.clearExpiredCache();
    debugPrint("✅ Cleared expired cache entries");
  }

  /// ✅ **Get Cache Status**
  Future<Map<String, dynamic>> getCacheStatus() async {
    final status = <String, dynamic>{};

    // Check categories cache
    final categoriesData = await _prefs.getCategoriesData();
    status['categories_cached'] = categoriesData != null;

    // Check products cache
    final productsData = await _prefs.getAllProductsData();
    status['products_cached'] = productsData != null;

    // Check cache expiry
    final now = DateTime.now().millisecondsSinceEpoch;
    final categoriesTime = await _prefs.getString('categories_cache_time');
    final productsTime = await _prefs.getString('all_products_cache_time');

    if (categoriesTime != null) {
      try {
        final timestamp = int.parse(categoriesTime);
        status['categories_cache_age'] =
            (now - timestamp) ~/ 1000; // in seconds
      } catch (e) {
        status['categories_cache_age'] = -1;
      }
    }

    if (productsTime != null) {
      try {
        final timestamp = int.parse(productsTime);
        status['products_cache_age'] = (now - timestamp) ~/ 1000; // in seconds
      } catch (e) {
        status['products_cache_age'] = -1;
      }
    }

    return status;
  }
}
