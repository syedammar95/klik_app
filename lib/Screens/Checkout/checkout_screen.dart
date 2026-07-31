import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utils/app_colors.dart';
import 'widgets/check_out_card.dart';
import '../Address/select_shipping_address.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAddressSection(context),
            _buildCartItems(),
          ],
        ),
      ),
    );
  }

  /// Builds the App Bar for the checkout screen.
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Checkout',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
          color: AppColors.whiteColor,
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      automaticallyImplyLeading: false,
    );
  }

  /// Builds the Address Selection Section.
  Widget _buildAddressSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        color: AppColors.whiteColor,
        width: double.infinity,
        height: 60.h,
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () => _navigateToSelectShippingAddress(context),
          child: Text(
            '+ Address',
            style: TextStyle(fontSize: 14.sp, color: AppColors.blackColor),
          ),
        ),
      ),
    );
  }

  /// Navigates to the Select Shipping Address screen.
  void _navigateToSelectShippingAddress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectShippingAddress()),
    );
  }

  /// Builds the Cart Items Section.
  Widget _buildCartItems() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Container(
        color: AppColors.whiteColor,
        width: double.infinity,
        child: const CheckOutCard(
          shippedBy: 'Shipped by Global Sellers',
          productName: 'Original Branded T-Shirt',
          brand: 'No Brand',
          colorFamily: 'Black',
          rupees: 1000.00,
          quantityProduct: 1,
          deliveryCharges: 120,
        ),
      ),
    );
  }
}
