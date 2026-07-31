class GetCartModel {
  bool? success;
  List<CartModel>? cart;

  GetCartModel({this.success, this.cart});

  GetCartModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['cart'] != null) {
      cart = <CartModel>[];
      json['cart'].forEach((v) {
        cart!.add(new CartModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartModel {
  int? id;
  String? userId;
  int? productId;
  int? variationId;
  int? quantity;
  String? discountPrice;
  String? price;
  String? totalPrice;
  String? productName;
  String? variationName;
  String? variationValue;
  String? imageUrl;

  CartModel({
    this.id,
    this.userId,
    this.productId,
    this.variationId,
    this.quantity,
    this.discountPrice,
    this.price,
    this.totalPrice,
    this.productName,
    this.variationName,
    this.variationValue,
    this.imageUrl,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    quantity = json['quantity'];
    discountPrice = json['discount_price'];
    price = json['price'];
    totalPrice = json['total_price'];
    productName = json['product_name'];
    variationName = json['variation_name'];
    variationValue = json['variation_value'];
    imageUrl = _resolveImageUrl(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['variation_id'] = this.variationId;
    data['quantity'] = this.quantity;
    data['discount_price'] = this.discountPrice;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['product_name'] = this.productName;
    data['variation_name'] = this.variationName;
    data['variation_value'] = this.variationValue;
    data['image_url'] = this.imageUrl;
    return data;
  }

  /// Helper function to fix or resolve the image URL
  static String _resolveImageUrl(Map<String, dynamic> json) {
    String? imageUrl = json['image_url'];

    // If no image URL, try to resolve from product images
    if (imageUrl == null || imageUrl.isEmpty || imageUrl.contains('No+Image')) {
      // Try to resolve from product images if available
      if (json['product'] != null && json['product'] is Map<String, dynamic>) {
        final product = json['product'] as Map<String, dynamic>;
        if (product['images'] != null &&
            product['images'] is List &&
            product['images'].isNotEmpty) {
          final firstImage = product['images'][0].toString();
          if (firstImage.startsWith('http')) {
            return firstImage;
          } else {
            return 'https://ehomes.pk/Vendor_Panel/uploads/$firstImage';
          }
        }
      }
      // Return empty string to trigger fallback UI instead of placeholder URL
      return '';
    }

    // Clean up the image URL
    String cleanUrl = imageUrl.trim();

    // Extract the filename from the old klik.pk URL if present
    if (cleanUrl.contains('klik.pk')) {
      try {
        final uri = Uri.parse(cleanUrl);
        final pathSegments = uri.pathSegments;
        if (pathSegments.isNotEmpty) {
          final filename = pathSegments.last;
          cleanUrl = 'https://ehomes.pk/Vendor_Panel/uploads/$filename';
        }
      } catch (e) {
        print('Error parsing klik.pk URL: $e');
        return '';
      }
    }

    // Convert webp to jpg if needed
    if (cleanUrl.toLowerCase().endsWith('.webp')) {
      cleanUrl = cleanUrl.substring(0, cleanUrl.length - 5) + '.jpg';
    }

    // Ensure URL starts with http
    if (!cleanUrl.startsWith('http')) {
      cleanUrl = 'https://ehomes.pk/Vendor_Panel/uploads/$cleanUrl';
    }

    // Validate URL format
    try {
      final uri = Uri.parse(cleanUrl);
      if (uri.scheme.isEmpty || uri.host.isEmpty) {
        return '';
      }
    } catch (e) {
      print('Invalid URL format: $cleanUrl');
      return '';
    }

    return cleanUrl;
  }

  String get effectivePrice {
    final hasValidDiscount = discountPrice != null &&
        discountPrice != '' &&
        discountPrice != '0' &&
        discountPrice != '0.0' &&
        price != null &&
        price != '' &&
        price != '0' &&
        price != '0.0' &&
        double.tryParse(discountPrice!) != null &&
        double.tryParse(price!) != null &&
        double.parse(discountPrice!) > 0 &&
        double.parse(discountPrice!) < double.parse(price!);
    if (hasValidDiscount) {
      return discountPrice!;
    }
    if (price != null && price != '' && price != '0' && price != '0.0') {
      return price!;
    }
    // If both are missing or zero, return 'N/A' to avoid showing 0
    return 'N/A';
  }
}
