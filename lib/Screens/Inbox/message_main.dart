import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klik_app/Screens/Inbox/promos_01.dart';
import '../../Utils/app_colors.dart';
import '../../global widgets/chats_icon_round_item.dart';
import '../../global widgets/orders_page_item.dart';
import 'activities_01.dart';
import 'chat_01.dart';
import 'orders_screen.dart';

class MessagePage01 extends StatelessWidget {
  const MessagePage01({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FDFF),
      appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 22.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChatsIconRoundItem(
                      icon: Icons.message,
                      circleColor: Colors.green,
                      iconColor: Colors.white,
                      iconSize: 23.sp,
                      text: "Chats",
                      textSize: 11.sp,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Chat01()));
                      },
                    ),
                    ChatsIconRoundItem(
                      icon: Icons.shopping_bag,
                      circleColor: Colors.blue,
                      iconColor: Colors.white,
                      iconSize: 23.sp,
                      text: "Orders",
                      textSize: 11.sp,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const OrdersScreen()));
                      },
                    ),
                    ChatsIconRoundItem(
                      icon: Icons.local_activity,
                      circleColor: Colors.deepOrange,
                      iconColor: Colors.white,
                      iconSize: 23.sp,
                      text: "Activities",
                      textSize: 11.sp,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Activities01()));
                      },
                    ),
                    ChatsIconRoundItem(
                      icon: Icons.alarm,
                      circleColor: Colors.redAccent,
                      iconColor: Colors.white,
                      iconSize: 23.sp,
                      text: "Promos",
                      textSize: 11.sp,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Promos01()));
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 6.h),
            // Orders Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Last 7 days', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8.h),
                  OrdersPageItem(
                    firstText: 'Order Cancellation',
                    secondText: '1 minute ago',
                    leftIcon: Icons.credit_card,
                    secondImage: "assets/images/img.png",
                    longText: "Dear customer, we're sorry that your order has been cancelled. Please tap here to find the",
                    orderId: "5627657626552676",
                    onTap: () {},
                  ),
                  SizedBox(height: 8.h),
                  OrdersPageItem(
                    firstText: 'Order Cancellation',
                    secondText: '1 minute ago',
                    leftIcon: Icons.credit_card,
                    secondImage: "assets/images/img.png",
                    longText: "Dear customer, we're sorry that your order has been cancelled. Please tap here to find the",
                    orderId: "5627657626552676",
                    onTap: () {},
                  ),
                  SizedBox(height: 8.h),
                  OrdersPageItem(
                    firstText: 'Order Cancellation',
                    secondText: '1 minute ago',
                    leftIcon: Icons.credit_card,
                    secondImage: "assets/images/img.png",
                    longText: "Dear customer, we're sorry that your order has been cancelled. Please tap here to find the",
                    orderId: "5627657626552676",
                    onTap: () {},
                  ),
                  SizedBox(height: 8.h),
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
