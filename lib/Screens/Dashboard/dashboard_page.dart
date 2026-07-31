import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/dashboard_provider.dart';
import '../../Utils/app_colors.dart';
import '../Cart/my_cart_screen.dart';
import '../Categories/categories_screen.dart';
import '../Home/home_screen.dart';
import '../Inbox/message_main.dart';
import '../ProfileScreen/profile_screen.dart';
import '../../global widgets/app_bottom_navigation.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const List<Widget> _pages = [
    HomeScreen(),
    CategoriesScreen(),
    MyCartScreen(),
    MessagePage01(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, dashboardProvider, _) {
        final selectedIndex = dashboardProvider.selectedIndex;

        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: IndexedStack(
            index: selectedIndex,
            children: _pages,
          ),
          bottomNavigationBar: const AppBottomNavigation(),
        );
      },
    );
  }
}
