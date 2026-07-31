import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klik_app/Screens/Home/widgets/For%20you%20section/for_you_section.dart';
import 'package:klik_app/Screens/Home/widgets/banner/banner_widget.dart';
import 'package:klik_app/Screens/Home/widgets/category%20list/category_widget.dart';
import 'package:klik_app/Screens/Home/widgets/flash%20sales/flash_sale_widget.dart';
import 'package:klik_app/Screens/Home/widgets/search%20bar/search_bar.dart';
import '../../Utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: _buildAppBar(context),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            BannerWidget(),
            CategoryWidget(),
            FlashSaleWidget(),
            ForYouSectionWidget(),
          ],
        ),
      ),
    );
  }

  /// **Builds AppBar with a Search Bar**
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const CustomSearchBar(),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 15.w),
          child: Icon(
            Icons.notifications_active,
            color: AppColors.whiteColor,
            size: 24.sp,
          ),
        )
      ],
    );
  }
}
