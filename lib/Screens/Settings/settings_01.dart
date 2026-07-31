import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/app_colors.dart';
import '../Address/select_shipping_address.dart';
import '../Auth/signIn_widget.dart';
import '../ContactUs/contact_us.dart';
import '../Payment/payment_main.dart';
import '../TrackOrder/track_order_01.dart';

class Settings01 extends StatelessWidget {
  const Settings01({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold, color: AppColors.whiteColor),
        ),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.whiteColor),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  _buildListItem(Icons.person, 'Account Information', context),
                  _buildDivider(),
                  _buildListItem(Icons.payment, 'Payment Setting', context),
                  _buildDivider(),
                  _buildListItem(Icons.location_on, 'Address Book', context),
                  _buildDivider(),
                  _buildListItem(Icons.track_changes, 'Track Order', context),
                  _buildDivider(),
                  _buildListItem(Icons.chat, 'Messages', context),
                  _buildDivider(),
                  _buildListItem(Icons.flag, 'Country', context),
                  _buildDivider(),
                  _buildListItem(Icons.language, 'Languages', context),
                  _buildDivider(),
                  _buildListItem(Icons.security, 'Account Security', context),
                  _buildDivider(),
                  _buildListItem(Icons.contact_page, 'Contact us', context),
                  _buildDivider(),
                  _buildListItem(Icons.help, 'Help', context),
                  _buildDivider(),
                  _buildListItem(Icons.feedback, 'Feedback', context),
                  _buildDivider(),
                  _buildListItem(Icons.delete, 'Request Account Deletion', context),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blackColor,
                foregroundColor: AppColors.whiteColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
              minimumSize: Size(200.w, 35.h)
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInWidget()),
              ),
              child: Text('Logout', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
      leading: Icon(icon, color: AppColors.secondaryColor, size: 20.h,),
      title: Text(
        title,
        style: TextStyle(fontSize: 14.sp),
      ),
      onTap: () {
        switch (title) {
          case 'Track Order':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TrackOrder01()),
            );
            break;
          case 'Address Book':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SelectShippingAddress()),
            );
            break;
          case 'Contact us':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactUs()),
            );
            break;
          case 'Payment Setting':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaymentMain()),
            );
            break;
          default:
            break;
        }
      },
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.shade300,
      thickness: 1,
      height: 1,
    );
  }
}
