import 'package:flutter/material.dart';
import '../../../../../models/banner_model.dart';

class BannerProvider with ChangeNotifier {
  final List<BannerModel> _banners = [
    BannerModel(
      productName: 'Short Frok',
      productDescription: 'Loose outer garment',
      productPrice: '1799',
      buyNowButton: 'Buy Now',
      productImage: 'assets/images/product1.png',
    ),
    BannerModel(
      productName: 'Luxury bag',
      productDescription: 'Pieces of art that are crafted using high-quality materials',
      productPrice: '4150',
      buyNowButton: 'Buy Now',
      productImage: 'assets/images/product2.png',
    ),
    BannerModel(
      productName: 'Casio G3',
      productDescription: 'We deliver your watch with 1 year machine warranty',
      productPrice: '1329',
      buyNowButton: 'Buy Now',
      productImage: 'assets/images/product3.png',
    ),
    BannerModel(
      productName: 'Nike Runner',
      productDescription: 'Footwear intended to protect and comfort the human foot',
      productPrice: '25500',
      buyNowButton: 'Buy Now',
      productImage: 'assets/images/nike_runner.png',
    ),
  ];

  List<BannerModel> get banners => _banners;
}
