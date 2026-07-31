import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utils/app_colors.dart';
import '../../global widgets/activities_promos_card.dart';

class Activities01 extends StatelessWidget {
  const Activities01({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(
          'Activities',
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
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ActivitiesPromosCard(
                    firstText: 'HELLO! Click HERE to get 5% VOUCHER',
                    secondText: '12/04/2024',
                    leftIcon: Icons.local_activity,
                    circleColor: Colors.deepOrange,
                    category: "BEAUTY",
                    categoryColor: Colors.brown.shade900,
                    deal: 'HOT DEALS',
                    dealColor: Colors.brown.shade900,
                    dealLine: 'Best deals on best prices',
                    dealLineColor: Colors.brown.shade900,
                    buttonText: 'Shop Now',
                    buttonColor: Colors.pinkAccent.shade700,
                    buttonTextColor: Colors.white,
                    centreCircleColor: Colors.pinkAccent.shade700,
                    percent: '60',
                    lastImage: 'assets/images/beauty.png',
                    lastLongText: '60% OFF + 5% ADDITIONAL DISCOUNT',
                    mainContainerColor: Colors.pinkAccent.shade100,
                    onTap: () {},
                  ),
                  SizedBox(height: 6.h),
                  ActivitiesPromosCard(
                    firstText: 'HELLO! Click HERE to get 5% VOUCHER',
                    secondText: '12/04/2024',
                    leftIcon: Icons.local_activity,
                    circleColor: Colors.deepOrange,
                    category: "BEAUTY",
                    categoryColor: Colors.brown.shade900,
                    deal: 'HOT DEALS',
                    dealColor: Colors.brown.shade900,
                    dealLine: 'Best deals on best prices',
                    dealLineColor: Colors.brown.shade900,
                    buttonText: 'Shop Now',
                    buttonColor: Colors.pinkAccent.shade700,
                    buttonTextColor: Colors.white,
                    centreCircleColor: Colors.pinkAccent.shade700,
                    percent: '60',
                    lastImage: 'assets/images/beauty.png',
                    lastLongText: '60% OFF + 5% ADDITIONAL DISCOUNT',
                    mainContainerColor: Colors.green.shade100,
                    onTap: () {},
                  ),
                  SizedBox(height: 6.h),
                  ActivitiesPromosCard(
                    firstText: 'HELLO! Click HERE to get 5% VOUCHER',
                    secondText: '12/04/2024',
                    leftIcon: Icons.local_activity,
                    circleColor: Colors.deepOrange,
                    category: "BEAUTY",
                    categoryColor: Colors.deepOrange.shade900,
                    deal: 'HOT DEALS',
                    dealColor: Colors.deepOrange.shade900,
                    dealLine: 'Best deals on best prices',
                    dealLineColor: Colors.deepOrange.shade900,
                    buttonText: 'Shop Now',
                    buttonColor: Colors.deepOrange.shade900,
                    buttonTextColor: Colors.white,
                    centreCircleColor: Colors.deepOrange.shade900,
                    percent: '60',
                    lastImage: 'assets/images/beauty.png',
                    lastLongText: '60% OFF + 5% ADDITIONAL DISCOUNT',
                    mainContainerColor: Colors.orangeAccent.shade100,
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