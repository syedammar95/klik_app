import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'Screens/Auth/email section/provider/email_authProvider.dart';
import 'Screens/Categories/provider/category_provider.dart';
import 'Screens/Dashboard/provider/dashboard_provider.dart';
import 'Screens/Home/widgets/banner/provider/banner_provider.dart';
import 'Screens/Home/widgets/For you section/provider/for_you_provider.dart';
import 'Screens/Home/widgets/category list/provider/home_category_provider.dart';
import 'Screens/Home/widgets/search bar/provider/search_bar_provider.dart';
import 'Screens/ProductDetail/provider/product_detail_provider.dart';
import 'Screens/ProductDetail/provider/review_provider.dart';
import 'Screens/Cart/provider/cart_provider.dart';
import 'providers/product_provider.dart';
import 'Utils/helpers/app_initializer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // Initialize FCM Service after Firebase is initialized
  // try {
  //   await FCMService().initialize();
  // } catch (e) {
  //   debugPrint('Error initializing FCM Service: $e');
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmailAuthProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => HomeCategoryProvider()),
        ChangeNotifierProvider(create: (_) => ForYouProvider()),
        ChangeNotifierProvider(create: (_) => SearchBarProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => BannerProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: AppInitializer(),
          );
        },
      ),
    );
  }
}
