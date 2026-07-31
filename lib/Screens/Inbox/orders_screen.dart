import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utils/app_colors.dart';
import '../../global widgets/orders_page_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FDFF),
      appBar: AppBar(
        title: Text(
          'Orders',
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrdersPageItem(
                    firstText: 'Order Cancellation',
                    secondText: '1 minute ago',
                    leftIcon: Icons.credit_card,
                    secondImage: "assets/images/img.png",
                    longText: "Dear customer, we're sorry that your order has been cancelled. Please tap here to find the",
                    orderId: "5627657626552676",
                    onTap: () {},
                  ),
                  SizedBox(height: 6.h),
                  OrdersPageItem(
                    firstText: 'Order Cancellation',
                    secondText: '1 minute ago',
                    leftIcon: Icons.credit_card,
                    secondImage: "assets/images/img.png",
                    longText: "Dear customer, we're sorry that your order has been cancelled. Please tap here to find the",
                    orderId: "5627657626552676",
                    onTap: () {},
                  ),
                  SizedBox(height: 6.h),
                  OrdersPageItem(
                    firstText: 'Order Cancellation',
                    secondText: '1 minute ago',
                    leftIcon: Icons.credit_card,
                    secondImage: "assets/images/img.png",
                    longText: "Dear customer, we're sorry that your order has been cancelled. Please tap here to find the",
                    orderId: "5627657626552676",
                    onTap: () {},
                  ),
                  SizedBox(height: 6.h),
                  OrdersPageItem(
                    firstText: 'Order Cancellation',
                    secondText: '1 minute ago',
                    leftIcon: Icons.credit_card,
                    secondImage: "assets/images/img.png",
                    longText: "Dear customer, we're sorry that your order has been cancelled. Please tap here to find the",
                    orderId: "5627657626552676",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}