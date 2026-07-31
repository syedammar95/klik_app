import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klik_app/Screens/ProfileScreen/widgets/coins_card_section.dart';
import 'package:klik_app/Screens/ProfileScreen/widgets/discount_card_section.dart';
import 'package:klik_app/Screens/ProfileScreen/widgets/header_section.dart';
import 'package:klik_app/Screens/ProfileScreen/widgets/history_section.dart';
import 'package:klik_app/Screens/ProfileScreen/widgets/orders_section.dart';
import 'package:klik_app/Screens/ProfileScreen/widgets/support_section.dart';
import '../../Utils/app_colors.dart';
import '../Settings/settings_01.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderSection(),
            const OrdersSection(),
            SizedBox(height: 10.h),
            const HistorySection(),
            const DiscountCardSection(),
            const CoinsCardSection(),
            SizedBox(height: 10.h),
            const SupportSection(),
          ],
        ),
      ),
    );
  }

  /// **App Bar**
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primaryColor,
      surfaceTintColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Settings01()),
          ),
          icon: Icon(Icons.settings, size: 22.sp, color: AppColors.whiteColor),
        ),
      ],
    );
  }
}
