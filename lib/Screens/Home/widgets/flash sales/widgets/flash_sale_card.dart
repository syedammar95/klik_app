// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../../Utils/app_colors.dart';
// import '../../../../FlashSale/flash_sale_screen.dart';
// import '../../../../ProductDetail/product_details_screen.dart';
//
// class FlashSaleCard extends StatelessWidget {
//   final int index;
//
//   const FlashSaleCard({super.key, required this.index});
//
//   static const List<Map<String, dynamic>> flashSaleData = [
//     {
//       'imageUrl': 'assets/images/img.png',
//       'discountedPrice': 150,
//       'originalPrice': 200,
//       'discountPercent': "70%",
//     },
//     {
//       'imageUrl': 'assets/images/img.png',
//       'discountedPrice': 130,
//       'originalPrice': 180,
//       'discountPercent': "60%",
//     },
//     {
//       'imageUrl': 'assets/images/img.png',
//       'discountedPrice': 170,
//       'originalPrice': 250,
//       'discountPercent': "75%",
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final data = flashSaleData[index % flashSaleData.length];
//
//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const ProductDetailScreen()),
//       ),
//       child: Container(
//         width: 120.w,
//         margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
//         decoration: BoxDecoration(
//           color: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(8.r),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.boxShadowColor.withOpacity(0.1),
//               blurRadius: 3,
//               spreadRadius: 0.4,
//               offset: const Offset(-1, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// **Product Image**
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius:
//                       BorderRadius.vertical(top: Radius.circular(8.r)),
//                   child: Image.asset(
//                     data['imageUrl'],
//                     height: 100.h,
//                     width: double.infinity,
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//
//                 /// **Discount Tag**
//                 Positioned(
//                   top: 0.h,
//                   left: 0.w,
//                   child: Container(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
//                     decoration: BoxDecoration(
//                       color: AppColors.yellowColor,
//                       borderRadius: BorderRadius.circular(4.r),
//                     ),
//                     child: Text(
//                       data['discountPercent'],
//                       style: TextStyle(color: AppColors.blackColor, fontSize: 8.sp),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 6.h),
//
//             /// **Price & Rating**
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 5.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.star, color: AppColors.yellowColor, size: 14.sp),
//                       SizedBox(width: 4.w),
//                       Text('(2)',
//                           style: TextStyle(
//                               fontSize: 10.sp,
//                               color: AppColors.greyColor)),
//                       SizedBox(width: 4.w),
//                       Text('|',
//                           style: TextStyle(
//                               color: AppColors.greyColor,
//                               fontSize: 10.sp)),
//                       SizedBox(width: 4.w),
//                       Text('39.6k',
//                           style: TextStyle(
//                               color: AppColors.greyColor,
//                               fontSize: 10.sp)),
//                       SizedBox(width: 4.w),
//                       Text('sold',
//                           style: TextStyle(
//                               fontSize: 10.sp,
//                               color: AppColors.greyColor)),
//                     ],
//                   ),
//                   SizedBox(height: 4.h),
//                   Row(
//                     children: [
//                       Text('Rs.',
//                           style: TextStyle(
//                               color: AppColors.blackColor,
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.bold)),
//                       Text('${data['discountedPrice']}',
//                           style: TextStyle(
//                               color: AppColors.blackColor,
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text('Rs.',
//                           style: TextStyle(
//                               color: AppColors.redColor,
//                               fontSize: 10.sp,
//                               decoration: TextDecoration.lineThrough)),
//                       Text('${data['originalPrice']}',
//                           style: TextStyle(
//                               color: AppColors.redColor,
//                               fontSize: 10.sp,
//                               decoration: TextDecoration.lineThrough)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
