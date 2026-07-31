import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../Utils/constants/my_sharePrefs.dart';
import '../../../models/cart/get_cart_model.dart';
import '../../../providers/product_provider.dart';
import '../../../services/cart_service.dart';
import '../../../models/product/product_model.dart';
import '../../Auth/email section/provider/email_authProvider.dart';

class CartProvider with ChangeNotifier {
  final CartService _cartServices = CartService();
  final MySharedPrefs _prefs = MySharedPrefs();
  final Map<int, bool> _cart = {};
  Map<int, bool> get cart => _cart;

  bool isLoading = false;
  bool _isAddingToCart = false;
  bool get isAddingToCart => _isAddingToCart;
  bool get isInitialized => _isInitialized;
  GetCartModel? _cartModel;
  GetCartModel? get cartModel => _cartModel;
  bool _isInitialized = false;
  bool _isSyncing =
      false; // 🔧 FIX: Prevent multiple simultaneous sync operations
  DateTime? _lastCartModification; // 🔧 FIX: Track when cart was last modified

  static const String _cartCacheKey = 'cart_data';
  static const Duration _cartCacheValidity = Duration(hours: 24);

  /// 🔧 FIX: Add authentication state listener
  EmailAuthProvider? _authProvider;
  bool _isListeningToAuth = false;

  /// 🔧 FIX: Set up authentication state listener
  void setupAuthListener(EmailAuthProvider authProvider) {
    if (_isListeningToAuth) return;

    _authProvider = authProvider;
    _isListeningToAuth = true;

    // Listen to auth state changes
    authProvider.addListener(_onAuthStateChanged);

    print("🛒 CartProvider: Auth listener set up successfully");
  }

  /// 🔧 FIX: Handle authentication state changes
  void _onAuthStateChanged() {
    if (_authProvider == null) return;

    final isLoggedIn = _authProvider!.isLoggedIn;
    print("🛒 CartProvider: Auth state changed - isLoggedIn: $isLoggedIn");

    if (!isLoggedIn) {
      // User logged out or switched to guest mode
      print("🛒 CartProvider: User logged out, clearing cart state");
      _clearCartState();
    }
  }

  /// 🔧 FIX: Clear cart state without triggering API calls
  void _clearCartState() {
    print("🛒 Clearing cart state...");
    _cart.clear();
    _cartModel = GetCartModel(success: true, cart: []);
    _isInitialized = false;

    // Force refresh cart badge specifically
    forceRefreshCartBadge();

    print("🛒 Cart state cleared successfully");
  }

  @override
  void dispose() {
    // Remove auth listener if set up
    if (_authProvider != null && _isListeningToAuth) {
      _authProvider!.removeListener(_onAuthStateChanged);
      _isListeningToAuth = false;
    }
    super.dispose();
  }

  /// Get total number of items in cart
  int get cartItemCount {
    // 🔧 FIX: Use local cart count for immediate UI updates
    // The model count might not be updated immediately after optimistic updates
    final localCount = _cart.length;
    final modelCount = _cartModel?.cart?.length ?? 0;

    print("🛒 cartItemCount: local=$localCount, model=$modelCount");

    // 🔧 FIX: Return the higher count to ensure UI shows the most up-to-date state
    // But ensure it's never negative
    final finalCount = localCount > modelCount ? localCount : modelCount;
    return finalCount > 0 ? finalCount : 0;
  }

  /// 🔧 FIX: Get cart count directly from local cart map for immediate UI updates
  int get cartItemCountImmediate {
    // 🔧 FIX: Add safety check to ensure count is never negative
    final count = _cart.length;
    return count > 0 ? count : 0;
  }

  /// 🔧 FIX: Check if cart is actually empty
  bool get isCartEmpty {
    final isEmpty = _cart.isEmpty;
    print("🛒 isCartEmpty check: $_cart -> $isEmpty");
    return isEmpty;
  }

  /// 🔧 FIX: Get detailed cart state for debugging
  Map<String, dynamic> get cartDebugInfo {
    return {
      'localCartSize': _cart.length,
      'localCartKeys': _cart.keys.toList(),
      'modelCartSize': _cartModel?.cart?.length ?? 0,
      'modelCartIds': _cartModel?.cart?.map((e) => e.productId).toList() ?? [],
      'isSyncing': _isSyncing,
      'lastModification': _lastCartModification?.toString(),
    };
  }

  /// Initialize cart data
  Future<void> initialize(BuildContext context) async {
    if (_isInitialized) return;

    final authProvider = Provider.of<EmailAuthProvider>(context, listen: false);
    try {
      await authProvider.loadUserSession();
      if (authProvider.isLoggedIn) {
        // Try to load from cache first
        final cachedCart = await _loadCartFromCache();
        if (cachedCart != null) {
          _cartModel = cachedCart;
          _updateCartMapFromModel();
          notifyListeners();
        }
        // Always fetch fresh data from API
        await getCart(context);
      } else {
        // 🔧 FIX: Ensure cart is empty for guest users
        print("🛒 User not logged in, clearing cart for guest mode");
        _cart.clear();
        _cartModel = GetCartModel(success: true, cart: []);
        _isInitialized = true;
        notifyListeners();
      }
    } catch (e) {
      print('Error initializing cart: $e');
      // 🔧 FIX: Ensure cart is cleared on error for guest users
      _cart.clear();
      _cartModel = GetCartModel(success: true, cart: []);
      _isInitialized = true;
      notifyListeners();
    } finally {
      _isInitialized = true;
    }
  }

  /// Load cart data from cache
  Future<GetCartModel?> _loadCartFromCache() async {
    try {
      final cartData = await _prefs.getString(_cartCacheKey);
      if (cartData != null) {
        final cartJson = jsonDecode(cartData);
        final timestamp = cartJson['timestamp'] as int?;

        // Check if cache is still valid
        if (timestamp != null &&
            DateTime.now().millisecondsSinceEpoch - timestamp <
                _cartCacheValidity.inMilliseconds) {
          return GetCartModel.fromJson(cartJson['data']);
        }
      }
    } catch (e) {
      print('Error loading cart from cache: $e');
    }
    return null;
  }

  /// Save cart data to cache
  Future<void> _saveCartToCache() async {
    if (_cartModel == null) return;

    try {
      final cartData = {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'data': _cartModel!.toJson(),
      };
      await _prefs.setString(_cartCacheKey, jsonEncode(cartData));
    } catch (e) {
      print('Error saving cart to cache: $e');
    }
  }

  /// Update cart map from model
  void _updateCartMapFromModel() {
    _cart.clear();
    if (_cartModel?.cart != null) {
      for (var item in _cartModel!.cart!) {
        if (item.productId != null) {
          _cart[item.productId!] = true;
        }
      }
    }
    // 🔧 FIX: Ensure UI updates after map update
    notifyListeners();
  }

  /// 🔧 FIX: Sync cart map with model to ensure consistency
  void _syncCartMapWithModel({bool notify = true}) {
    // 🔧 FIX: Prevent multiple simultaneous sync operations
    if (_isSyncing) return;

    _isSyncing = true;

    try {
      print("🛒 Syncing cart map with model...");
      print("🛒 Current local cart: $_cart");

      if (_cartModel?.cart != null && _cartModel!.cart!.isNotEmpty) {
        final newCartMap = <int, bool>{};
        for (var item in _cartModel!.cart!) {
          if (item.productId != null) {
            newCartMap[item.productId!] = true;
          }
        }

        print("🛒 Model cart items: ${newCartMap.keys.toList()}");

        // Only update if there are actual changes
        bool hasChanges = _cart.length != newCartMap.length;
        if (!hasChanges) {
          for (var key in _cart.keys) {
            if (!newCartMap.containsKey(key)) {
              hasChanges = true;
              break;
            }
          }
        }

        if (hasChanges) {
          print("🛒 Changes detected, updating cart map...");
          // 🔧 FIX: Preserve any items that might have been added optimistically
          final preservedItems = <int, bool>{};
          for (var key in _cart.keys) {
            if (!newCartMap.containsKey(key)) {
              // This item might have been added optimistically, preserve it
              preservedItems[key] = true;
              print("🛒 Preserving optimistically added item: $key");
            }
          }

          _cart.clear();
          _cart.addAll(newCartMap);
          // Add back preserved items
          _cart.addAll(preservedItems);

          print("🛒 Final cart after sync: $_cart");

          // 🔧 FIX: Only notify if explicitly requested and safe to do so
          if (notify) {
            notifyListeners();
          }
        } else {
          print("🛒 No changes detected, keeping current cart state");
        }
      } else {
        // 🔧 FIX: Handle empty cart state properly
        print("🛒 Model cart is empty, clearing local cart map");
        if (_cart.isNotEmpty) {
          _cart.clear();
          print("🛒 Local cart cleared. Final cart state: $_cart");

          if (notify) {
            notifyListeners();
          }
        }
      }
    } finally {
      _isSyncing = false;
    }
  }

  /// Calculate total cart price using compute
  Future<double> calculateTotalPrice() async {
    if (_cartModel == null || _cartModel!.cart == null) return 0.0;

    return compute(_calculateTotal, _cartModel!.cart!);
  }

  /// Static method for compute
  static double _calculateTotal(List<dynamic> items) {
    double total = 0.0;
    for (var item in items) {
      final price = double.tryParse(item.effectivePrice) ?? 0.0;
      final quantity = item.quantity ?? 1;
      total += price * quantity;
    }
    return total;
  }

  double get totalCartPrice {
    if (_cartModel == null || _cartModel!.cart == null) return 0.0;

    double total = 0.0;
    for (var item in _cartModel!.cart!) {
      if (inCart(item.productId!)) {
        final price = double.tryParse(item.effectivePrice) ?? 0.0;
        final quantity = item.quantity ?? 1;
        total += price * quantity;
      }
    }
    return total;
  }

  double get totalSavedAmount {
    if (_cartModel == null || _cartModel!.cart == null) return 0.0;

    double totalSaved = 0.0;
    for (var item in _cartModel!.cart!) {
      if (inCart(item.productId!)) {
        final originalPrice = double.tryParse(item.price ?? '0') ?? 0.0;
        final discountPrice = double.tryParse(item.discountPrice ?? '0') ?? 0.0;
        final quantity = item.quantity ?? 1;

        if (discountPrice > 0 && discountPrice < originalPrice) {
          totalSaved += (originalPrice - discountPrice) * quantity;
        }
      }
    }
    return totalSaved;
  }

  void updateQuantity(int index, int newQuantity, int productId) {
    cartModel!.cart![index].quantity = newQuantity;
    notifyListeners();
    updateCart(productId, newQuantity);
  }

  void updateCart(int productId, int quantity) async {
    if (_cartModel != null && _cartModel!.cart != null) {
      try {
        int? cartId;
        for (var item in _cartModel!.cart!) {
          if (item.productId == productId) {
            cartId = item.id!;
            break;
          }
        }

        if (cartId != null) {
          await _cartServices.updateCart(cartId, quantity);
          await _saveCartToCache(); // Update cache after successful API call
        }
      } catch (e) {
        print("Error updating cart item: $e");
        rethrow;
      }
    }
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setAddingToCart(bool value) {
    _isAddingToCart = value;
    notifyListeners();
  }

  Future<void> deleteCart(int productId) async {
    print("🛒 Deleting product $productId from cart...");
    print("🛒 Cart state before deletion: $_cart");

    if (_cartModel != null && _cartModel!.cart != null) {
      try {
        int? cartId;
        int? itemIndex;

        for (int i = 0; i < _cartModel!.cart!.length; i++) {
          if (_cartModel!.cart![i].productId == productId) {
            cartId = _cartModel!.cart![i].id!;
            itemIndex = i;
            break;
          }
        }

        if (cartId != null) {
          print(
              "🛒 Found cart item with ID: $cartId, removing from backend...");

          await _cartServices.deleteCart(cartId);
          print("🛒 Backend deletion successful");

          if (itemIndex != null) {
            _cartModel!.cart!.removeAt(itemIndex);
            print("🛒 Removed from cart model at index: $itemIndex");
          }

          // 🔧 FIX: Ensure local cart map is properly updated
          _cart.remove(productId);
          print("🛒 Removed from local cart map");

          await _saveCartToCache(); // Update cache after successful deletion

          // 🔧 FIX: Force UI refresh to ensure all components are updated
          forceRefreshUI();

          print("🛒 Cart item removed successfully. Final cart state: $_cart");
        } else {
          print(
              "🛒 Product not found in cart model, but removing from local state anyway");
          // 🔧 FIX: Remove from local state even if not found in model
          _cart.remove(productId);
          forceRefreshUI();
        }
      } catch (e) {
        print("🛒 Error deleting cart item: $e");
        // 🔧 FIX: Even if backend fails, remove from local state for UI consistency
        _cart.remove(productId);
        forceRefreshUI();
        rethrow;
      }
    } else {
      print("🛒 No cart model, removing from local state only");
      // 🔧 FIX: Remove from local state even if no model
      _cart.remove(productId);
      forceRefreshUI();
    }
  }

  /// 🔧 FIX: Efficiently refresh cart state without full reload
  Future<void> refreshCartState(BuildContext context) async {
    try {
      final provider = Provider.of<EmailAuthProvider>(context, listen: false);
      await provider.loadUserSession();
      final userId = provider.user!.id;

      final response = await _cartServices.getCart(userId);

      if (response.success == true) {
        _cartModel = response;
        _syncCartMapWithModel();
        await _patchCartImagesFromProductCache(context);
        await _saveCartToCache();
      }
    } catch (e) {
      print('Error refreshing cart state: $e');
      // Don't rethrow - this is a background refresh
    }
  }

  /// 🔧 FIX: Force sync local cart items to server
  Future<bool> forceSyncLocalCartToServer(BuildContext context) async {
    try {
      final provider = Provider.of<EmailAuthProvider>(context, listen: false);
      await provider.loadUserSession();
      final userId = provider.user!.id;

      print("🛒 Force syncing local cart to server...");
      print("🛒 Local cart items: ${_cart.keys.toList()}");

      // Get current server cart
      final serverResponse = await _cartServices.getCart(userId);
      final serverCartItems =
          serverResponse.cart?.map((item) => item.productId).toSet() ?? <int>{};

      print("🛒 Server cart items: ${serverCartItems.toList()}");

      // Find items that are in local cart but not in server cart
      final localCartItems = _cart.keys.toSet();
      final missingItems = localCartItems.difference(serverCartItems);

      print("🛒 Missing items on server: ${missingItems.toList()}");

      if (missingItems.isEmpty) {
        print("🛒 All local cart items are already on server");
        return true;
      }

      // Try to add missing items to server
      bool allSynced = true;
      for (final productId in missingItems) {
        try {
          print("🛒 Attempting to add product $productId to server cart...");

          // Get product details from cache or API
          final productProvider =
              Provider.of<ProductProvider>(context, listen: false);
          final product = productProvider.getProductById(productId);

          if (product != null) {
            final response = await _cartServices.addToCart(
              userId: userId,
              productId: productId,
              variationId: null,
              quantity: 1,
              price: product.price.toDouble(),
              totalPrice: product.price.toDouble(),
            );

            if (response?['success'] == true) {
              print("🛒 Successfully added product $productId to server cart");
            } else {
              print(
                  "🛒 Failed to add product $productId to server cart: ${response?['message']}");
              allSynced = false;
            }
          } else {
            print("🛒 Product $productId not found in cache, skipping sync");
            allSynced = false;
          }
        } catch (e) {
          print("🛒 Error syncing product $productId: $e");
          allSynced = false;
        }
      }

      if (allSynced) {
        print("🛒 All local cart items successfully synced to server");
        // Refresh cart state to get updated server cart
        await refreshCartState(context);
      }

      return allSynced;
    } catch (e) {
      print('🛒 Error force syncing local cart to server: $e');
      return false;
    }
  }

  /// 🔧 FIX: Force refresh UI to ensure all components are updated
  void forceRefreshUI() {
    print("🛒 Force refreshing UI...");
    print("🛒 Current cart state: $_cart");
    print("🛒 Cart item count: ${_cart.length}");
    print("🛒 Cart item count immediate: $cartItemCountImmediate");

    // Force multiple notifications to ensure all components are updated
    notifyListeners();

    // Schedule additional notification for next frame to catch any missed updates
    Future.microtask(() {
      print("🛒 Scheduling additional UI refresh...");
      notifyListeners();
    });
  }

  /// 🔧 FIX: Force refresh cart badge specifically
  void forceRefreshCartBadge() {
    print("🛒 Force refreshing cart badge...");
    print("🛒 Current cart state: $_cart");
    print("🛒 Cart item count: $cartItemCountImmediate");

    // Ensure cart state is consistent
    if (_cart.isEmpty) {
      _cartModel = GetCartModel(success: true, cart: []);
    }

    // Force UI refresh
    notifyListeners();

    // Schedule additional refresh for next frame
    Future.microtask(() {
      print("🛒 Scheduling additional cart badge refresh...");
      notifyListeners();
    });
  }

  /// 🔧 FIX: Safe method to refresh cart state without triggering build-time notifications
  Future<void> refreshCartStateSafe(BuildContext context) async {
    try {
      final provider = Provider.of<EmailAuthProvider>(context, listen: false);
      await provider.loadUserSession();
      final userId = provider.user!.id;

      final response = await _cartServices.getCart(userId);

      if (response.success == true) {
        _cartModel = response;
        // Use safe sync without notifications during build
        _syncCartMapWithModel(notify: false);
        await _patchCartImagesFromProductCache(context);
        await _saveCartToCache();
        // Schedule notification for next frame
        Future.microtask(() {
          notifyListeners();
        });
      }
    } catch (e) {
      print('Error refreshing cart state: $e');
      // Don't rethrow - this is a background refresh
    }
  }

  /// 🔧 FIX: Check if a product is in cart with immediate response
  bool inCart(int productId) {
    // First check local map for immediate response
    final inLocalCart = _cart[productId] ?? false;

    // Also verify against model for consistency, but don't sync during build
    if (_cartModel?.cart != null) {
      final inModel =
          _cartModel!.cart!.any((item) => item.productId == productId);

      // If there's a mismatch, schedule sync for next frame instead of immediate sync
      if (inLocalCart != inModel) {
        // 🔧 FIX: Schedule sync for next frame to avoid build-time notifications
        // Use a microtask to ensure it runs after the current build phase
        Future.microtask(() {
          _syncCartMapWithModel();
        });
        return inModel;
      }
    }

    return inLocalCart;
  }

  /// 🔧 FIX: Safe method to check cart state without triggering sync operations
  /// Use this during build phases to avoid setState during build errors
  bool inCartSafe(int productId) {
    // Only check local map - no sync operations
    return _cart[productId] ?? false;
  }

  void addToCart(int productId) {
    _cart[productId] = true;
    _lastCartModification = DateTime.now(); // 🔧 FIX: Track modification time
    print("🛒 Updated cart: $_cart at $_lastCartModification");
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _cart.remove(productId);
    _lastCartModification = DateTime.now(); // 🔧 FIX: Track modification time
    // 🔧 FIX: Also remove from cart model if it exists
    if (_cartModel?.cart != null) {
      _cartModel!.cart!.removeWhere((item) => item.productId == productId);
    }
    // 🔧 FIX: Ensure immediate UI update
    notifyListeners();
  }

  /// 🔧 FIX: Clear entire cart and ensure proper state synchronization
  Future<void> clearEntireCart(BuildContext context) async {
    print("🛒 Clearing entire cart...");
    print("🛒 Cart state before clearing: $_cart");

    try {
      // Clear local state immediately for UI responsiveness
      _cart.clear();
      _cartModel = GetCartModel(success: true, cart: []);

      // Clear cache
      await _prefs.remove(_cartCacheKey);

      // Force UI refresh
      forceRefreshUI();

      print("🛒 Cart cleared successfully. Final cart state: $_cart");
    } catch (e) {
      print("🛒 Error clearing cart: $e");
      // Even if there's an error, ensure local state is cleared
      _cart.clear();
      _cartModel = GetCartModel(success: true, cart: []);
      forceRefreshUI();
    }
  }

  /// 🔧 FIX: Clear cart state when user logs out
  /// This method should be called during logout to reset cart badge
  Future<void> clearCartOnLogout() async {
    print("🛒 Clearing cart state on logout...");
    print("🛒 Cart state before logout: $_cart");

    try {
      // Clear local state immediately
      _cart.clear();
      _cartModel = GetCartModel(success: true, cart: []);

      // Clear cache
      await _prefs.remove(_cartCacheKey);

      // Reset initialization flag
      _isInitialized = false;

      // Force refresh cart badge specifically
      forceRefreshCartBadge();

      print("🛒 Cart state cleared on logout. Final cart state: $_cart");
    } catch (e) {
      print("🛒 Error clearing cart on logout: $e");
      // Even if there's an error, ensure local state is cleared
      _cart.clear();
      _cartModel = GetCartModel(success: true, cart: []);
      _isInitialized = false;
      forceRefreshCartBadge();
    }
  }

  /// 🔧 FIX: Manual cart refresh for debugging and testing
  Future<void> manualRefreshCart(BuildContext context) async {
    print("🛒 Manual cart refresh triggered...");
    print("🛒 Current cart state before refresh: $_cart");

    try {
      await getCart(context);
      print("🛒 Cart refreshed successfully");
      print("🛒 Final cart state: $_cart");

      // Force UI refresh
      forceRefreshUI();
    } catch (e) {
      print("🛒 Error during manual cart refresh: $e");
    }
  }

  /// 🔧 FIX: Custom method to handle cart API responses
  /// The cart API returns {success: "Item added to cart"} instead of {success: true}
  bool handleCartApiResponse(Map<String, dynamic>? response) {
    if (response == null) return false;

    // Check if success field exists and has any value (not just true)
    if (response.containsKey('success') && response['success'] != null) {
      final successValue = response['success'];

      // Handle different success formats
      if (successValue == true) return true; // Boolean true
      if (successValue is String && successValue.isNotEmpty) {
        return true; // Non-empty string
      }
      if (successValue is int && successValue > 0) {
        return true; // Positive integer
      }

      print(
          "🛒 Cart API success value: $successValue (type: ${successValue.runtimeType})");
      return true; // Assume success if the field exists and has a value
    }

    return false;
  }

  Future<void> postAddedCart(
    BuildContext context,
    int productId,
    int? variationId,
    int quantity,
    double price,
    double totalPrice,
  ) async {
    print("🛒 DEBUG: postAddedCart called with:");
    print("🛒 DEBUG: productId: $productId");
    print("🛒 DEBUG: variationId: $variationId");
    print("🛒 DEBUG: quantity: $quantity");
    print("🛒 DEBUG: price: $price");
    print("🛒 DEBUG: totalPrice: $totalPrice");

    setAddingToCart(true);
    try {
      final provider = Provider.of<EmailAuthProvider>(context, listen: false);
      print("🛒 DEBUG: Got auth provider");

      await provider.loadUserSession();
      print("🛒 DEBUG: User session loaded");

      if (provider.user == null) {
        print("🛒 DEBUG: User is null after loading session");
        throw Exception("User session not available");
      }

      final userId = provider.user!.id;
      print("🛒 DEBUG: User ID: $userId");

      print("🛒 Adding product $productId to cart...");
      print("🛒 Cart state before: $_cart");

      // 🔧 FIX: Optimistically update UI immediately for better UX
      addToCart(productId);

      print("🛒 Cart state after optimistic update: $_cart");

      final response = await _cartServices.addToCart(
        userId: userId,
        productId: productId,
        variationId: variationId,
        quantity: quantity,
        price: price,
        totalPrice: totalPrice,
      );
      print("🛒 API Response: ${response.toString()}");
      print("🛒 API Response type: ${response.runtimeType}");
      print("🛒 API Response keys: ${response?.keys.toList()}");
      print("🛒 API Response success value: ${response?['success']}");
      print(
          "🛒 API Response success type: ${response?['success']?.runtimeType}");
      print("🛒 API Response success == true: ${response?['success'] == true}");
      print("🛒 API Response success != null: ${response?['success'] != null}");

      // 🔧 FIX: Use custom cart API response handler
      if (handleCartApiResponse(response)) {
        print("🛒 Cart API success detected, refreshing cart data...");

        // Refresh cart data to ensure consistency
        await Future.delayed(const Duration(milliseconds: 300));

        await getCart(context);
        await _patchCartImagesFromProductCache(context);

        // Ensure our optimistic update is preserved
        if (!_cart.containsKey(productId)) {
          print(
              "🛒 Product $productId was removed during refresh, restoring...");
          _cart[productId] = true;
          notifyListeners();
        }

        print("🛒 Final cart state: $_cart");

        // Force refresh UI to ensure all components are updated
        forceRefreshUI();
      } else {
        print("🛒 Cart API failed, rolling back optimistic update...");
        // Rollback optimistic update if API fails
        removeFromCart(productId);
        notifyListeners();
      }
    } catch (e) {
      print("🛒 Error occurred, rolling back optimistic update...");
      // 🔧 FIX: Rollback optimistic update on error
      removeFromCart(productId);
      notifyListeners();
      print("Error adding to cart: $e");
      rethrow;
    } finally {
      setAddingToCart(false);
    }
  }

  Future<void> getCart(BuildContext context) async {
    setLoading(true);
    final provider = Provider.of<EmailAuthProvider>(context, listen: false);
    await provider.loadUserSession();
    final userId = provider.user!.id;

    try {
      print("🛒 Fetching cart data for user $userId...");
      print("🛒 Current local cart state: $_cart");

      GetCartModel response = await _cartServices.getCart(userId);

      if (response.success == true &&
          response.cart != null &&
          response.cart!.isNotEmpty) {
        print("🛒 Received ${response.cart!.length} items from API");

        _cartModel = response;
        // 🔧 FIX: Use improved sync method for better consistency
        _syncCartMapWithModel();
        await _patchCartImagesFromProductCache(context);
        await _saveCartToCache(); // Cache the fresh data
        print('🛒 Cart Items: ${response.cart}');
        print('🛒 Local cart after sync: $_cart');
      } else {
        print("🛒 No items in cart from API, clearing local state");
        _cartModel = GetCartModel(success: true, cart: []);
        _cart.clear();
        print('No items in the cart.');
      }

      // 🔧 FIX: Ensure UI updates after all operations
      notifyListeners();
    } catch (e) {
      print('🛒 Error fetching cart data: $e');
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  /// Patch missing imageUrls in cart items using ProductProvider's cache
  Future<void> _patchCartImagesFromProductCache(BuildContext context) async {
    try {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      if (_cartModel?.cart == null) return;
      bool updated = false;

      for (final item in _cartModel!.cart!) {
        // Check if image URL needs patching or if current URL might be invalid
        if (item.imageUrl == null ||
            item.imageUrl!.isEmpty ||
            item.imageUrl!.contains('No+Image') ||
            item.imageUrl!.contains('placeholder') ||
            _shouldTryAlternativeImage(item.imageUrl!)) {
          // Try cache first
          var product = productProvider.getProductById(item.productId!);
          if (product == null) {
            // Fetch from backend if not in cache
            try {
              final products =
                  await productProvider.productService.fetchProducts();
              product = products.firstWhere(
                (p) => p.productId == item.productId!,
                orElse: () => ProductModel(
                  productId: 0,
                  vendorId: null,
                  productName: '',
                  brandName: '',
                  price: 0,
                  discountPrice: 0,
                  description: '',
                  stock: 0,
                  categories: [],
                  images: [],
                  variations: [],
                  tags: [],
                ),
              );
            } catch (e) {
              print('Error fetching product for cart image: $e');
            }
          }

          // Try to find a valid image from product data
          String? validImageUrl = _findValidImageUrl(product, item.productId!);

          if (validImageUrl != null && validImageUrl.isNotEmpty) {
            item.imageUrl = validImageUrl;
            updated = true;
            print(
                'Patched cart image for product ${item.productId}: ${item.imageUrl}');
          } else {
            // Set empty string to trigger fallback UI
            item.imageUrl = '';
            updated = true;
            print(
                'No valid image found for product ${item.productId}, using fallback UI');
          }
        }
      }

      if (updated) {
        notifyListeners();
        // Cache the updated cart
        await _saveCartToCache();
      }
    } catch (e) {
      print('Error patching cart images: $e');
    }
  }

  /// Check if we should try to find an alternative image URL
  bool _shouldTryAlternativeImage(String currentUrl) {
    // If URL contains known problematic patterns, try to find alternative
    return currentUrl.contains('klik.pk') ||
        currentUrl.contains('ehomes.pk/Vendor_Panel/uploads/') ||
        currentUrl.contains('admin_panel/uploads/');
  }

  /// Find a valid image URL from product data, trying multiple sources
  String? _findValidImageUrl(ProductModel? product, int productId) {
    if (product == null || product.productId == 0 || product.images.isEmpty) {
      return null;
    }

    // Try each image in the product's image list
    for (String image in product.images) {
      if (image.isNotEmpty) {
        String imageUrl = image;

        // Ensure proper URL format
        if (!imageUrl.startsWith('http')) {
          imageUrl = 'https://ehomes.pk/Vendor_Panel/uploads/$imageUrl';
        }

        // Try different URL variations for the same image
        List<String> urlVariations = _generateImageUrlVariations(imageUrl);

        for (String variation in urlVariations) {
          if (_isValidImageUrl(variation)) {
            print('Found valid image URL for product $productId: $variation');
            return variation;
          }
        }
      }
    }

    return null;
  }

  /// Generate different URL variations for an image
  List<String> _generateImageUrlVariations(String baseUrl) {
    List<String> variations = [baseUrl];

    // Extract filename from URL
    try {
      final uri = Uri.parse(baseUrl);
      final pathSegments = uri.pathSegments;
      if (pathSegments.isNotEmpty) {
        final filename = pathSegments.last;

        // Try different base URLs
        variations.addAll([
          'https://ehomes.pk/Vendor_Panel/uploads/$filename',
          'https://ehomes.pk/admin_panel/uploads/$filename',
          'https://ehomes.pk/uploads/$filename',
        ]);

        // Try with different file extensions
        if (filename.contains('.')) {
          final nameWithoutExt =
              filename.substring(0, filename.lastIndexOf('.'));
          variations.addAll([
            'https://ehomes.pk/Vendor_Panel/uploads/$nameWithoutExt.jpg',
            'https://ehomes.pk/Vendor_Panel/uploads/$nameWithoutExt.png',
            'https://ehomes.pk/Vendor_Panel/uploads/$nameWithoutExt.jpeg',
          ]);
        }
      }
    } catch (e) {
      print('Error generating URL variations: $e');
    }

    return variations;
  }

  /// Check if an image URL is valid (basic validation)
  bool _isValidImageUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.scheme.isNotEmpty &&
          uri.host.isNotEmpty &&
          uri.path.isNotEmpty &&
          !url.contains('No+Image') &&
          !url.contains('placeholder');
    } catch (e) {
      return false;
    }
  }

  /// Clears the cart state after successful checkout
  Future<void> clearCart() async {
    _cart.clear();
    _cartModel = GetCartModel(success: true, cart: []);
    await _prefs.remove(_cartCacheKey); // Clear cache
    notifyListeners();
  }

  /// 🔧 FIX: Handle authentication state changes
  /// This method should be called when user logs in/out to sync cart state
  Future<void> handleAuthStateChange(
      BuildContext context, bool isLoggedIn) async {
    print("🛒 Handling auth state change: isLoggedIn=$isLoggedIn");
    print("🛒 Current cart state: $_cart");

    if (isLoggedIn) {
      // User logged in, initialize cart
      print("🛒 User logged in, initializing cart...");
      _isInitialized = false; // Reset initialization flag
      await initialize(context);
    } else {
      // User logged out or guest mode, clear cart
      print("🛒 User logged out or guest mode, clearing cart...");
      await clearCartOnLogout();
    }
  }
}
