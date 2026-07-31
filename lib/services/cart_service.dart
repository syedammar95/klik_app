import '../models/cart/get_cart_model.dart';
import 'client/api_client.dart';

class CartService {
  final ApiClient _apiClient = ApiClient();

  /// 🔹 **Add Product to Cart (Using Query Parameters)**
  Future<Map<String, dynamic>?> addToCart({
    required int userId,
    required int productId,
    required int? variationId,
    required int quantity,
    required double price,
    required double totalPrice,
  }) async {
    final data = {
      "user_id": userId.toString(),
      "product_id": productId.toString(),
      "variation_id": variationId.toString(),
      "quantity": quantity.toString(),
      "price": price.toString(),
      "total_price": totalPrice.toString(),
    };

    print("🛒 DEBUG: CartService.addToCart called with:");
    print("🛒 DEBUG: userId: $userId");
    print("🛒 DEBUG: productId: $productId");
    print("🛒 DEBUG: variationId: $variationId");
    print("🛒 DEBUG: quantity: $quantity");
    print("🛒 DEBUG: price: $price");
    print("🛒 DEBUG: totalPrice: $totalPrice");
    print("🛒 DEBUG: data: $data");

    final response = await _apiClient.post('/cart.php', data);
    print("🛒 DEBUG: CartService.addToCart response: $response");

    return response;
  }

  /// 🔹 **Fetch Cart Items**
  Future<GetCartModel> getCart(int userId) async {
    try {
      final response =
          await _apiClient.get('/cart.php', queryParams: {"user_id": userId});

      if (response != null && response['success'] == true) {
        // Create GetCartModel from the response
        GetCartModel cartModel = GetCartModel.fromJson(response);
        return cartModel;
      } else {
        return GetCartModel(success: false, cart: []);
      }
    } catch (e) {
      throw Exception("Error fetching cart data: $e");
    }
  }

  Future<Map<String, dynamic>?> deleteCart(int cartId) async {
    try {
      final response = await _apiClient.delete(
        '/cart.php',
        data: {
          "cart_id": cartId,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> updateCart(int cartId, int quantity) async {
    try {
      final response = await _apiClient.put(
        '/cart.php',
        {
          "cart_id": cartId,
          "quantity": quantity,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // /// checkout
  // Future<Map<String, dynamic>?> checkout({
  //   required int userId,
  //   required String firstName,
  //   required String lastName,
  //   required String email,
  //   required int phone,
  //   required String address,
  //   required String city,
  //   required String state,
  //   required int zip,
  //   required String orderNotes,
  //   required String paymentMethod,
  //   required int discount,
  //   required int couponCode,
  //   required int couponAmount,
  //   required int shippingCharge,
  // }) async {
  //   final data = {
  //     "user_id": userId.toString(),
  //     "first_name": firstName,
  //     "last_name": lastName,
  //     "email": email,
  //     "phone": phone,
  //     "address": address,
  //     "city": city,
  //     "state": state,
  //     "zip": zip,
  //     "order_notes": orderNotes,
  //     "payment_method": paymentMethod,
  //     "discount": discount,
  //     "coupon_code": couponCode,
  //     "coupon_amount": couponAmount,
  //     "shipping_charge": shippingCharge,
  //   };
  //
  //   return await _apiClient.post('/checkout.php', data);
  // }
}
