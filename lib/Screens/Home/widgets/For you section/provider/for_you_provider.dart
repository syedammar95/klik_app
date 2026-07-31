import 'package:flutter/material.dart';

class ForYouProvider with ChangeNotifier {
  int _selectedIndex = 0;

  /// tags list
  final Map<String, List<Map<String, dynamic>>> _getTag = {
    'For You': [],
    'Hot Deals': [],
    'Free Delivery': [],
    'New Arrivals': [],
    'Must Buy': [],
    'Women Fashion': [],
    'Foot Wear': [],
  };

  ForYouProvider() {
    _getProduct();
  }

  /// getters

  int get selectedIndex => _selectedIndex;
  List<String> get categories => _getTag.keys.toList();
  List<Map<String, dynamic>> get selectedCategoryProducts =>
      _getTag[categories[_selectedIndex]] ?? [];

  void _getProduct() {
    _getTag['For You'] = [
      {
        'imageUrl': 'assets/images/product2.png',
        'productName': 'Branded Bag',
        'price': 5500,
        'discountedPercent': 25,
        'rating': 4.8,
        'ratingCount': 123,
        'soldCount': 713,
        'freeDelivery': true,
        'limitedTime': true,
      },
      {
        'imageUrl': 'assets/images/img.png',
        'productName': 'Casual Shirt',
        'price': 635,
        'discountedPercent': 10,
        'rating': 2.9,
        'ratingCount': 43,
        'soldCount': 71,
        'freeDelivery': false,
        'limitedTime': true,
      },
      {
        'imageUrl': 'assets/images/nike_runner.png',
        'productName': 'Nike Runner',
        'price': 1749,
        'discountedPercent': 15,
        'rating': 4.5,
        'ratingCount': 500,
        'soldCount': 700,
        'freeDelivery': true,
        'limitedTime': true,
      },
      {
        'imageUrl': 'assets/images/product4.png',
        'productName': 'Leather Jacket by F&N',
        'price': 9450,
        'discountedPercent': 35,
        'rating': 4.5,
        'ratingCount': 151,
        'soldCount': 300,
        'freeDelivery': false,
        'limitedTime': true,
      },
      {
        'imageUrl': 'assets/images/beauty.png',
        'productName': 'Zara Makeup Kit',
        'price': 749,
        'discountedPercent': 6,
        'rating': 3.0,
        'ratingCount': 7,
        'soldCount': 13,
        'freeDelivery': true,
        'limitedTime': true,
      },

    ];

    _getTag['Hot Deals'] = [
      {
        'imageUrl': 'assets/images/shiny-black-headphones-reflect-golden-nightclub-lights-generated-by-ai.jpg',
        'productName': 'Wireless Headphones',
        'price': 1800,
        'discountedPercent': 20,
        'rating': 4.3,
        'ratingCount': 85,
        'soldCount': 40,
        'freeDelivery': true,
        'limitedTime': true,
      },
      {
        'imageUrl': 'assets/images/product3.png',
        'productName': 'Smartwatch Pro',
        'price': 13500,
        'discountedPercent': 13,
        'rating': 4.7,
        'ratingCount': 120,
        'soldCount': 60,
        'freeDelivery': false,
        'limitedTime': true,
      },
    ];

    _getTag['Free Delivery'] = [
      {
        'imageUrl': 'assets/images/product4.png',
        'productName': 'Wireless Earbuds',
        'price': 500,
        'discountedPercent': 10,
        'rating': 4.6,
        'ratingCount': 75,
        'soldCount': 30,
      },
      {
        'imageUrl': 'assets/images/product1.png',
        'productName': 'Portable Bluetooth Speaker',
        'price': 850,
        'discountedPercent': 8,
        'rating': 4.4,
        'ratingCount': 95,
        'soldCount': 45,
      },
    ];

    _getTag['New Arrivals'] = [
      {
        'imageUrl': 'assets/images/product2.png',
        'productName': 'Fitness Tracker',
        'price': 900,
        'discountedPercent': 12,
        'rating': 4.6,
        'ratingCount': 150,
        'soldCount': 80,
      },
      {
        'imageUrl': 'assets/images/product3.png',
        'productName': 'VR Headset',
        'price': 2200,
        'discountedPercent': 18,
        'rating': 4.7,
        'ratingCount': 180,
        'soldCount': 110,
      },
    ];

    _getTag['Must Buy'] = [
      {
        'imageUrl': 'assets/images/product4.png',
        'productName': 'Mechanical Keyboard',
        'price': 700,
        'discountedPercent': 7,
        'rating': 4.8,
        'ratingCount': 90,
        'soldCount': 55,
      },
      {
        'imageUrl': 'assets/images/product1.png',
        'productName': '4K Monitor',
        'price': 3000,
        'discountedPercent': 25,
        'rating': 4.9,
        'ratingCount': 220,
        'soldCount': 130,
      },
    ];

    _getTag['Women Fashion'] = [
      {
        'imageUrl': 'assets/images/product2.png',
        'productName': 'Stylish Dress',
        'price': 900,
        'discountedPercent': 12,
        'rating': 4.6,
        'ratingCount': 150,
        'soldCount': 80,
      },
      {
        'imageUrl': 'assets/images/product3.png',
        'productName': 'Designer Handbag',
        'price': 2000,
        'discountedPercent': 10,
        'rating': 4.5,
        'ratingCount': 170,
        'soldCount': 95,
      },
    ];

    _getTag['Foot Wear'] = [
      {
        'imageUrl': 'assets/images/nike_runner.png',
        'productName': 'Running Shoes',
        'price': 1300,
        'discountedPercent': 10,
        'rating': 4.7,
        'ratingCount': 120,
        'soldCount': 75,
      },
      {
        'imageUrl': 'assets/images/nike_runner.png',
        'productName': 'Casual Sneakers',
        'price': 1100,
        'discountedPercent': 15,
        'rating': 4.6,
        'ratingCount': 135,
        'soldCount': 85,
      },
    ];

    notifyListeners();
  }

  void updateIndex(int index) {
    if (index != _selectedIndex && index >= 0 && index < categories.length) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  void addCategory(String categoryName) {
    if (categoryName.isNotEmpty && !_getTag.containsKey(categoryName)) {
      _getTag[categoryName] = [];
      notifyListeners();
    }
  }

  void addProduct(String category, Map<String, dynamic> product) {
    if (category.isEmpty || product.isEmpty) return;
    _getTag.putIfAbsent(category, () => []);
    _getTag[category]!.add(product);
    notifyListeners();
  }
}
