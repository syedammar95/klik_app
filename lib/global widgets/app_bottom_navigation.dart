import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Utils/app_colors.dart';
import '../Screens/Dashboard/provider/dashboard_provider.dart';
import 'cart_badge.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({super.key});

  static final BorderRadius _navBarRadius = BorderRadius.only(
    topLeft: Radius.circular(25.r),
    topRight: Radius.circular(25.r),
  );

  /// **🔹 Material Design Icons for Bottom Navigation**
  static const List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home_outlined, 'selectedIcon': Icons.home, 'label': 'Home'},
    {
      'icon': Icons.category_outlined,
      'selectedIcon': Icons.category,
      'label': 'Categories'
    },
    {
      'icon': Icons.shopping_cart_outlined,
      'selectedIcon': Icons.shopping_cart,
      'label': 'Cart'
    },
    {
      'icon': Icons.message_outlined,
      'selectedIcon': Icons.message,
      'label': 'Messages'
    },
    {
      'icon': Icons.person_outline,
      'selectedIcon': Icons.person,
      'label': 'Profile'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, dashboardProvider, _) {
        final selectedIndex = dashboardProvider.selectedIndex;

        return Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: _navBarRadius,
            boxShadow: [
              const BoxShadow(
                color: AppColors.boxShadowColor,
                blurRadius: 20,
                offset: Offset(0, -3),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: AppColors.primaryColor.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, -1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: _navBarRadius,
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                dashboardProvider.updateSelectedIndex(index);
              },
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: AppColors.greyColor,
              backgroundColor: AppColors.whiteColor,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              iconSize: 24.h,
              selectedLabelStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.greyColor,
              ),
              items: _navItems.asMap().entries.map((entry) {
                int index = entry.key;
                var item = entry.value;
                return _buildBottomNavigationBarItem(
                  item['icon']!,
                  item['selectedIcon']!,
                  item['label']!,
                  index,
                  selectedIndex,
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(IconData unselectedIcon,
      IconData selectedIcon, String label, int index, int selectedIndex) {
    // Determine which icon to use (selected/unselected)
    IconData iconData = index == selectedIndex ? selectedIcon : unselectedIcon;
    Color iconColor =
        index == selectedIndex ? AppColors.primaryColor : AppColors.greyColor;

    /// Build the icon widget
    Widget iconWidget = Icon(
      iconData,
      size: 24.h,
      color: iconColor,
    );

    /// Add cart badge for cart icon (index 2)
    if (index == 2) {
      // Cart icon index
      iconWidget = CartBadge(
        isBottomNavigation: true,
        child: iconWidget,
      );
    }

    return BottomNavigationBarItem(
      icon: iconWidget,
      label: label,
    );
  }
}
