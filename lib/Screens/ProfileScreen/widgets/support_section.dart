import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/app_colors.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: [
            _buildSupportItem('Customer Support', Icons.support_agent),
            _buildSupportItem('Help & FAQs', Icons.help_outline),
            _buildSupportItem('Terms & Conditions', Icons.article_outlined),
            _buildSupportItem('Privacy Policy', Icons.privacy_tip_outlined),
            // _buildSupportItem('Logout', Icons.logout, isLogout: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportItem(String title, IconData icon, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? AppColors.primaryColor : AppColors.blackColor),
      title: Text(title, style: TextStyle(fontSize: 13.sp)),
      trailing: Icon(Icons.arrow_forward_ios, size: 13.sp,color: AppColors.blackColor,),
      onTap: () {},
    );
  }
}
