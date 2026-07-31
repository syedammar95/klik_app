import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Utils/app_colors.dart';
import '../../Auth/signIn_widget.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome to', style: _headerTextStyle()),
              Text('Klik', style: _headerTextStyle()),
              SizedBox(height: 4.h),
              Text('Try your first order', style: _subTextStyle()),
              Text('with free shipping included', style: _subTextStyle()),
              SizedBox(height: 10.h),
              _buildSignInButton(context),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 15.w,
          child: Image.asset(
            'assets/images/welcome_deal.png',
            height: 180.h,
            width: 160.w,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  TextStyle _headerTextStyle() {
    return TextStyle(
        fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.white);
  }

  TextStyle _subTextStyle() {
    return TextStyle(fontSize: 12.sp, color: Colors.white);
  }

  Widget _buildSignInButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blackColor,
        foregroundColor: AppColors.whiteColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignInWidget()),
      ),
      child: Text('SignIn / Register',
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
    );
  }
}
