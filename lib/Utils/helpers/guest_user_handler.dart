// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../constants/app_colors.dart';
// import '../helpers/show_toast_dialouge.dart';
// import '../../screens/Auth/email section/provider/email_authProvider.dart';
//
// class GuestUserHandler {
//   /// Check if user is logged in and handle guest user access
//   static Future<bool> checkUserLogin(BuildContext context) async {
//     final authProvider = Provider.of<EmailAuthProvider>(context, listen: false);
//     await authProvider.loadUserSession();
//
//     if (!authProvider.isLoggedIn) {
//       ShowToastDialog.show(
//         context,
//         'Please login',
//         type: ToastType.error,
//       );
//       return false;
//     }
//     return true;
//   }
//
//   /// Show guest user widget with custom message
//   static Widget showGuestUserWidget({
//     required String message,
//     IconData? icon,
//     Color? iconColor,
//     double? iconSize,
//     EdgeInsetsGeometry? padding,
//     bool showCloseButton = true,
//     VoidCallback? onClose,
//   }) {
//     return GuestUserWidget(
//       message: message,
//       icon: icon,
//       iconColor: iconColor,
//       iconSize: iconSize,
//       padding: padding,
//       showCloseButton: showCloseButton,
//       onClose: onClose,
//     );
//   }
//
//   /// Handle guest user access with custom action
//   static Future<bool> handleGuestUserAccess(
//     BuildContext context, {
//     required String message,
//     required VoidCallback onSuccess,
//     IconData? icon,
//     Color? iconColor,
//     double? iconSize,
//     EdgeInsetsGeometry? padding,
//     bool showCloseButton = true,
//     VoidCallback? onClose,
//   }) async {
//     final isLoggedIn = await checkUserLogin(context);
//
//     if (!isLoggedIn) {
//       // Show guest user widget
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => Dialog(
//           backgroundColor: AppColors.whiteColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.r),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(24.w),
//             child: GuestUserWidget(
//               message: message,
//               icon: icon,
//               iconColor: iconColor,
//               iconSize: iconSize,
//               padding: padding,
//               showCloseButton: showCloseButton,
//               onClose: onClose,
//             ),
//           ),
//         ),
//       );
//       return false;
//     }
//
//     onSuccess();
//     return true;
//   }
// }
