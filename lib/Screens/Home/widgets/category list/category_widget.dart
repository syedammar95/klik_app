import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klik_app/Screens/Home/widgets/category%20list/widgets/home_category_list.dart';
import 'package:provider/provider.dart';
import '../../../../Utils/app_colors.dart';
import '../../../Categories/categories_screen.dart';
import 'provider/home_category_provider.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  void initState() {
    super.initState();
    // Initialize categories when widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCategoryProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// **Title with "More" Button**
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories",
                    style: TextStyle(
                        fontSize: 14.sp, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CategoriesScreen()),
                    );
                  },
                  child: Text('More',
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          /// **Category ListView (Horizontal Scroll) using Consumer**
          Consumer<HomeCategoryProvider>(
            builder: (context, categoryProvider, child) {
              if (categoryProvider.isLoading &&
                  categoryProvider.categories.isEmpty) {
                return _buildLoadingState();
              }

              if (categoryProvider.error != null &&
                  categoryProvider.categories.isEmpty) {
                return _buildErrorState(categoryProvider.error!);
              }

              final categories = categoryProvider.categories;
              if (categories.isEmpty) {
                return _buildEmptyState();
              }

              return Container(
                color: AppColors.scaffoldColor,
                height: 105
                    .h, // ✅ Increased height to accommodate taller category cards
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return HomeCategoryList(
                      containerWidth: MediaQuery.of(context).size.width.w,
                      imageUrl: categories[index]['imagePath']!,
                      text: categories[index]['categoryName']!,
                      textWeight: FontWeight.bold,
                      textSize: 10.sp, // ✅ Responsive text size for better fit
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// **🔹 Build Loading State**
  Widget _buildLoadingState() {
    return Container(
      color: AppColors.scaffoldColor,
      height: 105.h, // ✅ Increased height to match main container
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.w,
              height: 20.h,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              'Loading categories...',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// **🔹 Build Error State**
  Widget _buildErrorState(String error) {
    return Container(
      color: AppColors.scaffoldColor,
      height: 105.h, // ✅ Increased height to match main container
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.redColor,
              size: 24.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              'Failed to load categories',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.redColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            TextButton(
              onPressed: () {
                context.read<HomeCategoryProvider>().refresh();
              },
              child: Text(
                'Retry',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// **🔹 Build Empty State**
  Widget _buildEmptyState() {
    return Container(
      color: AppColors.scaffoldColor,
      height: 105.h, // ✅ Increased height to match main container
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category_outlined,
              color: AppColors.greyColor,
              size: 24.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              'No categories available',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
