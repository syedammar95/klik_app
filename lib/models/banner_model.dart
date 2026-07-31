class BannerModel {
  final String productName;
  final String productDescription;
  final String productPrice;
  final String buyNowButton;
  final String productImage;

  BannerModel({
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.buyNowButton,
    required this.productImage,
  });

  // Factory method for creating a BannerModel from JSON (for future API usage)
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      productName: json['productName'] ?? '',
      productDescription: json['productDescription'] ?? '',
      productPrice: json['productPrice'] ?? '',
      buyNowButton: json['buyNowButton'] ?? '',
      productImage: json['productImage'] ?? '',
    );
  }
}
