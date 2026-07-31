//
// import 'package:klik_app/models/reviews_model.dart';
//
// class ProductModel {
//   final String id;
//   final String title;
//   final String category;
//   final String subCategory;
//   final double price;
//   final double oldPrice;
//   final double rating;
//   final List<String> images;
//   final bool isAuthentic;
//   final bool freeDelivery;
//   final String estimatedDelivery;
//   final String description;
//   final List<String> highlights;
//   final Map<String, String> specifications;
//   final List<ReviewModel> reviewList;
//   final int totalSold;
//
//   const ProductModel({
//     required this.id,
//     required this.title,
//     required this.category,
//     required this.subCategory,
//     required this.price,
//     required this.oldPrice,
//     required this.rating,
//     required this.images,
//     required this.isAuthentic,
//     required this.freeDelivery,
//     required this.estimatedDelivery,
//     this.description = "No description available",
//     required this.highlights,
//     required this.specifications,
//     this.reviewList = const [],
//     this.totalSold = 0,
//   });
//
//   /// ✅ Dynamic getter to return total number of reviews
//   int get reviews => reviewList.length;
//
//   /// ✅ Convert ProductModel to JSON (useful for APIs)
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "category": category,
//     "subCategory": subCategory,
//     "price": price,
//     "oldPrice": oldPrice,
//     "rating": rating,
//     "images": images,
//     "isAuthentic": isAuthentic,
//     "freeDelivery": freeDelivery,
//     "estimatedDelivery": estimatedDelivery,
//     "description": description,
//     "highlights": highlights,
//     "specifications": specifications,
//     "reviewList": reviewList.isNotEmpty
//         ? reviewList.map((review) => review.toJson()).toList()
//         : null,
//     "totalSold": totalSold,
//   };
//
//   /// ✅ Convert JSON to ProductModel
//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json["id"],
//       title: json["title"],
//       category: json["category"] ?? "Uncategorized",
//       subCategory: json["subCategory"] ?? "Uncategorized",
//       price: (json["price"] as num).toDouble(),
//       oldPrice: (json["oldPrice"] as num).toDouble(),
//       rating: (json["rating"] as num).toDouble(),
//       images: List<String>.from(json["images"]),
//       isAuthentic: json["isAuthentic"] ?? false,
//       freeDelivery: json["freeDelivery"] ?? false,
//       estimatedDelivery: json["estimatedDelivery"] ?? "",
//       description: json["description"] ?? "No description available",
//       highlights: List<String>.from(json["highlights"] ?? []),
//       specifications: Map<String, String>.from(json["specifications"] ?? {}),
//       reviewList: (json["reviewList"] != null)
//           ? (json["reviewList"] as List)
//           .map((review) => ReviewModel.fromJson(review))
//           .toList()
//           : [],
//       totalSold: json["totalSold"] ?? 0,
//     );
//   }
// }
