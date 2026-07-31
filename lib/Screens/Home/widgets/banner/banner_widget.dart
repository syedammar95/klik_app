import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../Utils/app_colors.dart';
import 'widgets/banner_content.dart';
import 'provider/banner_provider.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  BannerWidgetState createState() => BannerWidgetState();
}

class BannerWidgetState extends State<BannerWidget> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    // Delay auto-scroll initialization until after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted || !_pageController.hasClients) return;

      final bannerProvider = context.read<BannerProvider>();
      final bannerCount = bannerProvider.banners.length;

      if (bannerCount > 1) {
        final nextPage = (_currentPage + 1) % bannerCount;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bannerProvider = Provider.of<BannerProvider>(context);
    final bannerCount = bannerProvider.banners.length;

    if (bannerCount == 0) {
      return const SizedBox();
    }

    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: SizedBox(
        height: 135.h,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index % bannerCount;
                });
              },
              itemCount: bannerCount,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11.w),
                  child: BannerContent(index: index),
                );
              },
            ),
            Positioned(
              bottom: 10.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  bannerCount,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: _currentPage == index ? 8.w : 6.w,
                    height: _currentPage == index ? 8.h : 6.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? AppColors.secondaryColor
                          : AppColors.greyColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
