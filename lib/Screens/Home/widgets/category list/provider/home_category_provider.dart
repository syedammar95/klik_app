import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../../models/category/categories_model.dart';
import '../../../../../services/category_service.dart';
import '../../../../../Utils/constants/my_sharePrefs.dart';

class HomeCategoryProvider with ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  final MySharedPrefs _prefs = MySharedPrefs();

  List<Map<String, String>> _categories = [];
  bool _isLoading = false;
  String? _error;

  /// **📌 Getters**
  List<Map<String, String>> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// **🔹 Initialize and fetch categories**
  Future<void> initialize() async {
    await fetchCategories();
  }

  /// **📌 Fetch Categories from API with comprehensive caching**
  Future<void> fetchCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // ✅ Check cache first using proper validation
      final cachedData = await _prefs.getCategoriesData();
      if (cachedData != null) {
        try {
          debugPrint("📦 Using cached categories data for home screen");
          final Map<String, dynamic> cachedJson = jsonDecode(cachedData);
          final categories = (cachedJson['categories'] as List<dynamic>)
              .map((e) => CategoryModel.fromJson(e))
              .toList();

          _categories = _convertToHomeFormat(categories);
          debugPrint("✅ Loaded ${_categories.length} categories from cache");
          _isLoading = false;
          notifyListeners();
          return;
        } catch (e) {
          debugPrint("❌ Error parsing cached categories: $e");
        }
      }

      // Fetch from API if no valid cache
      debugPrint("🔄 Fetching categories from API...");
      final response = await _categoryService.getCategories();

      if (response != null && response['success'] == true) {
        final categories = (response['categories'] as List<dynamic>)
            .map((e) => CategoryModel.fromJson(e))
            .toList();

        _categories = _convertToHomeFormat(categories);

        // ✅ Cache the response using proper method
        await _prefs.saveCategoriesData(jsonEncode(response));
        debugPrint("✅ Fetched ${_categories.length} categories from API");
      } else {
        debugPrint("❌ API response failed or null: $response");
        if (_categories.isEmpty) {
          _error = "Failed to load categories";
        }
      }
    } catch (e) {
      debugPrint("❌ Error fetching categories: $e");
      if (_categories.isEmpty) {
        _error = "Error loading categories: $e";
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  /// **🔹 Convert CategoryModel list to home screen format**
  List<Map<String, String>> _convertToHomeFormat(
      List<CategoryModel> categories) {
    // ✅ FIXED: Show ALL categories instead of limiting to 6
    return categories
        .map((category) => {
              'imagePath': category.icon.isNotEmpty ? category.fixedIcon : '',
              'categoryName': category.name,
            })
        .toList();
  }

  /// **🔹 Refresh categories**
  Future<void> refresh() async {
    await _prefs.clearCategoriesCache();
    await fetchCategories();
  }

  /// **🔹 Clear cache**
  Future<void> clearCache() async {
    await _prefs.clearCategoriesCache();
    _categories = [];
    notifyListeners();
  }
}
