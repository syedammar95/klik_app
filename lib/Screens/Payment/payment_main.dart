import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Utils/app_colors.dart';
import '../../global widgets/Payment/deposit_screens.dart';
import '../../global widgets/Payment/other_wallet_item.dart';
import '../../global widgets/Payment/own_wallet_item.dart';
import 'cash_on_delivery_01.dart';
import 'credit_debit_01.dart';
import 'easy_paisa_01.dart';
import 'hbl_bank_01.dart';
import 'jazz_cash_01.dart';

class PaymentMain extends StatelessWidget {
  const PaymentMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Payment Method',
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Container(
                color: Colors.blue.shade100,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info, size: 16.sp, color: Colors.blue[900]),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          'Please collect bank vouchers to avail bank discounts and mega deals/flash sales',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11.sp, color: Colors.blue[900]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7.h),
                    child: Text(
                      'Recommended method(s)',
                      style: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                  const OwnWalletItem(
                    firstText: 'KLIK Wallet',
                    secondText: 'Select to top-up & pay',
                    amount: '1500',
                    leftIcon: Icons.wallet,
                    rightIcon: Icons.radio_button_checked,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7.h),
                    child: Text(
                      'Other Payment Methods',
                      style: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                  OtherWalletItem(
                    firstText: 'Credit/Debit Card',
                    secondText: 'Credit/Debit Card',
                    leftIcon: Icons.credit_card,
                    showPaymentIcons: true,
                    rightIcon: Icons.arrow_forward_ios_rounded,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CreditDebit01()));
                    },
                  ),
                  SizedBox(height: 10.h),
                  OtherWalletItem(
                    firstText: 'JazzCash',
                    secondText: '',
                    leftIcon: Icons.credit_card,
                    showPaymentIcons: false,
                    rightIcon: Icons.arrow_forward_ios_rounded,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const JazzCash01()));
                    },
                  ),
                  SizedBox(height: 10.h),
                  OtherWalletItem(
                    firstText: 'EasyPaisa',
                    secondText: 'Easypaisa mobile account required',
                    leftIcon: Icons.credit_card,
                    showPaymentIcons: false,
                    rightIcon: Icons.arrow_forward_ios_rounded,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EasyPaisa01()));
                    },
                  ),
                  SizedBox(height: 10.h),
                  OtherWalletItem(
                    firstText: 'HBL Bank Account',
                    secondText: '',
                    leftIcon: Icons.credit_card,
                    showPaymentIcons: false,
                    rightIcon: Icons.arrow_forward_ios_rounded,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HblBank01()));
                    },
                  ),
                  SizedBox(height: 10.h),
                  OtherWalletItem(
                    firstText: 'Cash on Delivery',
                    secondText: 'Cash on Delivery',
                    leftIcon: Icons.credit_card,
                    showPaymentIcons: false,
                    rightIcon: Icons.arrow_forward_ios_rounded,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CashOnDelivery01()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w), // Adjusted padding responsively
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8.h), // Adjusted height responsively
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal', style: TextStyle(fontSize: 11.sp)), // Reduced font size
                  Text('\$100', style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold)), // Reduced font size
                ],
              ),
              SizedBox(height: 12.h), // Adjusted height responsively
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Amount', style: TextStyle(fontSize: 11.sp)), // Reduced font size
                  Text('\$100', style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold)), // Reduced font size
                ],
              ),
              SizedBox(height: 12.h), // Adjusted height responsively
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Please top-up', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold)), // Reduced font size
                  Text('\$100', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold)), // Reduced font size
                ],
              ),
              SizedBox(height: 4.h), // Adjusted height responsively
              Divider(color: Colors.grey.shade300),
              SizedBox(height: 4.h), // Adjusted height responsively
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r), // Adjusted border radius responsively
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6.h), // Adjusted padding responsively
                  ),
                  onPressed: () {
                    _showBottomSheet(context, _walletDepositBottomSheet(context));
                  },
                  child: Text(
                    'TOPUP AND PAY',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

void _showBottomSheet(BuildContext context, Widget content) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.7,
      minChildSize: 0.7,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: SingleChildScrollView(
          controller: controller,
          child: content,
        ),
      ),
    ),
  );
}
Widget _walletDepositBottomSheet(BuildContext context) {
  return Column(
    children: [
      const CustomBottomSheet(
        title: 'Wallet Deposit',
        showLeftIcon: false,
        showRightIcon: true,
        showFirstText: true,
        showSecondText: true,
        amount: '500.00',
        firstText: 'Deposit Amount(Rs)',
        secondText: 'Additional Information',
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: GestureDetector(
          onTap: () {
            _showBottomSheet(context, _selectMethodBottomSheet(context));
          },
          child: Container(
            width: double.infinity,
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Select a Method',
                          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.ccMastercard, size: 16.sp),
                    SizedBox(width: 6.w),
                    Icon(FontAwesomeIcons.ccVisa, size: 16.sp),
                    SizedBox(width: 6.w),
                    Icon(FontAwesomeIcons.ccApplePay, size: 16.sp),
                    SizedBox(width: 14.w),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColors.primaryColor),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _selectMethodBottomSheet(BuildContext context) {
  return Column(

    children: [
      const CustomBottomSheet(
        title: 'Select Deposit Method',
        showLeftIcon: true,
        showRightIcon: true,
        showFirstText: false,
        showSecondText: false,
        amount: '500.00',
        firstText: '',
        secondText: '',
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Debit/Credit Card',
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
            Text(
                'Add a new card',
                style: TextStyle(fontSize: 11.sp, color: Colors.grey),
              ),
            SizedBox(height: 10.h),
            OtherWalletItem(
              firstText: 'Credit/Debit Card',
              secondText: '',
              leftIcon: Icons.credit_card,
              showPaymentIcons: false,
              rightIcon: Icons.radio_button_off,
              onTap: (){
                _showBottomSheet(context, _debitCreditBottomSheet(context));
              },
              containerColor: Colors.grey.shade100,
            ),
            SizedBox(height: 10.h),
            Text(
              'Digital Wallet',
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              'Link your digital wallet for convenient deposit',
              style: TextStyle(fontSize: 11.sp, color: Colors.grey),
            ),
            SizedBox(height: 10.h),
            OtherWalletItem(
              firstText: 'JazzCash',
              secondText: '',
              leftIcon: Icons.credit_card,
              showPaymentIcons: false,
              rightIcon: Icons.radio_button_off,
              onTap: (){
                _showBottomSheet(context, _jazzCashBottomSheet(context));
              },
              containerColor: Colors.grey.shade100,
            ),
            SizedBox(height: 10.h),
            OtherWalletItem(
              firstText: 'EasyPaisa Direct',
              secondText: '',
              leftIcon: Icons.credit_card,
              showPaymentIcons: false,
              rightIcon: Icons.radio_button_off,
              onTap: (){
                _showBottomSheet(context, _easyPaisaBottomSheet(context));
              },
              containerColor: Colors.grey.shade100,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _debitCreditBottomSheet(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: const CustomBottomSheet(
          title: 'Wallet Deposit',
          showLeftIcon: true,
          showRightIcon: true,
          showFirstText: true,
          showSecondText: true,
          amount: '500.00',
          firstText: 'Deposit Amount(Rs)',
          secondText: 'Deposit Method',
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: OtherWalletItem(
          firstText: 'Debit/Credit Card',
          secondText: '',
          leftIcon: Icons.credit_card,
          showPaymentIcons: false,
          rightIcon: Icons.arrow_forward_ios,
          onTap: () {
            _showBottomSheet(context, _addCreditMethodBottomSheet(context));
          },
          containerColor: Colors.grey.shade100,
        ),
      ),
      SizedBox(height: 150.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 6.h),
            ),
            onPressed: () {
              _showBottomSheet(context, _addCreditMethodBottomSheet(context));
            },
            child: const Text(
              'Deposit',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _jazzCashBottomSheet(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: const CustomBottomSheet(
          title: 'Wallet Deposit',
          showLeftIcon: true,
          showRightIcon: true,
          showFirstText: true,
          showSecondText: true,
          amount: '500.00',
          firstText: 'Deposit Amount(Rs)',
          secondText: 'Deposit Method',
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: OtherWalletItem(
          firstText: 'JazzCash',
          secondText: '',
          leftIcon: Icons.credit_card,
          showPaymentIcons: false,
          rightIcon: Icons.arrow_forward_ios,
          onTap: () {
            _showBottomSheet(context, _addJazzCashBottomSheet(context));
          },
          containerColor: Colors.grey.shade100,
        ),
      ),
      SizedBox(height: 150.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 6.h),
            ),
            onPressed: () {
              _showBottomSheet(context, _addJazzCashBottomSheet(context));
            },
            child: const Text(
              'Deposit',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _easyPaisaBottomSheet(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: const CustomBottomSheet(
          title: 'Wallet Deposit',
          showLeftIcon: true,
          showRightIcon: true,
          showFirstText: true,
          showSecondText: true,
          amount: '500.00',
          firstText: 'Deposit Amount(Rs)',
          secondText: 'Deposit Method',
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: OtherWalletItem(
          firstText: 'EasyPaisa',
          secondText: '',
          leftIcon: Icons.credit_card,
          showPaymentIcons: false,
          rightIcon: Icons.arrow_forward_ios,
          onTap: () {
            _showBottomSheet(context, _addEasyPaisaBottomSheet(context));
          },
          containerColor: Colors.grey.shade100,
        ),
      ),
      SizedBox(height: 150.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 6.h),
            ),
            onPressed: () {
              _showBottomSheet(context, _addEasyPaisaBottomSheet(context));
            },
            child: const Text(
              'Deposit',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _addCreditMethodBottomSheet(BuildContext context) {
  return Column(
    children: [
      const CustomBottomSheet(
        title: 'Select Deposit Method',
        showLeftIcon: true,
        showRightIcon: true,
        showFirstText: false,
        showSecondText: false,
        amount: '500.00',
        firstText: '',
        secondText: '',
      ),
      SizedBox(height: 12.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Card Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp)),
            Row(
              children: [
                Icon(FontAwesomeIcons.ccMastercard, size: 18.r),
                SizedBox(width: 8.w),
                Icon(FontAwesomeIcons.ccVisa, size: 18.r),
                SizedBox(width: 8.w),
                Icon(FontAwesomeIcons.ccApplePay, size: 18.r),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 6.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 35.h,
                maxHeight: 35.h,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Card number',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 13.sp,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 4.0.h,
                    horizontal: 12.0.w,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 35.h,
                      maxHeight: 35.h,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Expiry (MM/YY)',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13.sp,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                          borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 4.0.h,
                          horizontal: 12.0.w,
                        ),
                        suffixIcon: Icon(Icons.help_outline, size: 18.r, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 35.h,
                      maxHeight: 35.h,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'CVV',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13.sp,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                          borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 4.0.h,
                          horizontal: 12.0.w,
                        ),
                        suffixIcon: Icon(Icons.help_outline, size: 18.r, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 35.h,
                maxHeight: 35.h,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Name on card',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 13.sp,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 4.0.h,
                    horizontal: 12.0.w,
                  ),
                  suffixIcon: Icon(Icons.help_outline, size: 18.r, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.grey.shade100,
          ),
          padding: EdgeInsets.all(10.r),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.gpp_good, size: 16.r, color: Colors.green),
                  SizedBox(width: 8.w),
                  Text('Your Card is safe with Valley', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp)),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.check, size: 16.r, color: Colors.green),
                  SizedBox(width: 8.w),
                  Text('Compiles with PCO DSS for secure data handling.', style: TextStyle(fontSize: 11.sp)),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.check, size: 16.r, color: Colors.green),
                  SizedBox(width: 8.w),
                  Text('Card info stays safe and encrypted.', style: TextStyle(fontSize: 11.sp)),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.check, size: 16.r, color: Colors.green),
                  SizedBox(width: 8.w),
                  Text('Advance security measures for safe transactions', style: TextStyle(fontSize: 11.sp)),
                ],
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 30.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 6.h),
            ),
            onPressed: () {},
            child: Text(
              'Proceed',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
            ),
          ),
        ),
      ),
    ],
  );
}


Widget _addJazzCashBottomSheet(BuildContext context) {
  return Column(
    children: [
      const CustomBottomSheet(
        title: 'Link Deposit Method',
        showLeftIcon: true,
        showRightIcon: true,
        showFirstText: false,
        showSecondText: false,
        amount: '500.00',
        firstText: 'Deposit Amount(Rs)',
        secondText: 'Deposit Method',
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.wallet, size: 24.r, color: AppColors.primaryColor),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'JazzCash',
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'JazzCash account is required',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '1.FOR JAZZ/WARID: Unlock your phone and you will receive a MPIN input Prompt',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '2.FOR OTHER NETWORKS: log-in to your JazzCash App and enter your MPIN',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Note: Ensure your JazzCash account is Active and has sufficient balance',
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'JazzCash Account Number',
              style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 6.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 35.h,
                maxHeight: 35.h,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'JazzCash Account Number',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 13.sp,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 4.0.h,
                    horizontal: 12.0.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.grey.shade100,
          ),
          padding: EdgeInsets.all(12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Save Payment Option', style: TextStyle(fontSize: 12.sp)),
              Text('We will save this account for your convenience. If required, you can remove the account in the "Payment Options" in the "Account" menu.', style: TextStyle(fontSize: 11.sp)),
            ],
          ),
        ),
      ),
      SizedBox(height: 20.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 6.h),
            ),
            onPressed: () {},
            child: Text(
              'Link Now',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
            ),
          ),
        ),
      ),
    ],
  );
}


Widget _addEasyPaisaBottomSheet(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: const CustomBottomSheet(
          title: 'Easypaisa Account Linking',
          showLeftIcon: true,
          showRightIcon: true,
          showFirstText: false,
          showSecondText: false,
          amount: '500.00',
          firstText: 'Deposit Amount(Rs)',
          secondText: 'Deposit Method',
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Easypaisa Mobile Account Number',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 12.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 35.h,
                maxHeight: 35.h,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '03xxxxxxxxx',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 13.sp,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 4.0.h,
                    horizontal: 12.0.w,
                  ),
                  suffixIcon: Icon(Icons.keyboard_alt_outlined, size: 20.r, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      // Handle checkbox state
                    },
                  ),
                  Text(
                    "I'm not a robot",
                    style: TextStyle(fontSize: 13.sp, color: Colors.black),
                  ),
                ],
              ),
              Image.asset(
                'assets/images/recaptcha.png',
                height: 40.r,
                width: 40.r,
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 20.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 6.h),
            ),
            onPressed: () {
            },
            child: Text(
              'Next',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
            ),
          ),
        ),
      ),
    ],
  );
}
