import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../Utils/app_colors.dart';
import 'provider/search_bar_provider.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchBarProvider>(
      builder: (context, searchProvider, child) {
        return Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Container(
            height: 30.h,
            decoration: BoxDecoration(
              color: AppColors.scaffoldColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.r),
                bottomLeft: Radius.circular(6.r),
                topRight: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      searchProvider.searchQuery = value;
                    },
                    style: TextStyle(fontSize: 12.sp),
                    decoration: InputDecoration(
                      hintText: "Search here",
                      hintStyle: TextStyle(
                          color: AppColors.greyColor, fontSize: 12.sp),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.5.h),
                    ),
                  ),
                ),
                Container(
                  height: 35.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      bottomLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                      // No rounding on bottom-right
                    ),
                    border: Border.all(color: AppColors.whiteColor, width: 1),
                  ),
                  child: Center(
                      child: Text(
                    'Search',
                    style:
                        TextStyle(fontSize: 12.sp, color: AppColors.whiteColor),
                  )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
