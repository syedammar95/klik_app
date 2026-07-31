import 'package:flutter/material.dart';

import '../../../Utils/app_colors.dart';

/// ProductDetailTabBar Widget
/// Displays the tab bar for product detail sections
class ProductDetailTabBar extends StatelessWidget {
  final TabController tabController;
  final ScrollController tabScrollController;
  final Function(int) onTabTapped;

  const ProductDetailTabBar({
    super.key,
    required this.tabController,
    required this.tabScrollController,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: tabScrollController,
        child: TabBar(
          isScrollable: true,
          controller: tabController,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.greyColor,
          indicatorColor: AppColors.primaryColor,
          onTap: onTabTapped,
          tabs: const [
            Tab(child: FittedBox(child: Text("Overview"))),
            Tab(child: FittedBox(child: Text("Product Details"))),
            Tab(child: FittedBox(child: Text("Ratings & Reviews"))),
          ],
        ),
      ),
    );
  }
}
