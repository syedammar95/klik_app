import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klik_app/Screens/ProductDetail/widgets/review_section/ratings_and_reviews_section.dart';
import 'package:provider/provider.dart';
import '../../Utils/app_colors.dart';
import '../../models/product/product_model.dart';
import 'provider/product_detail_provider.dart';
import 'widgets/overview_section.dart';
import 'widgets/product_info_section.dart';
import 'widgets/product_detail_tab_bar.dart';
import 'widgets/cart_test_button.dart';
import 'widgets/product_detail_section.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _tabScrollController = ScrollController();
  final PageController _pageController = PageController();

  final GlobalKey _overviewKey = GlobalKey();
  final GlobalKey _productDetailsKey = GlobalKey();
  final GlobalKey _ratingsKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Add scroll listener for tab synchronization
    _scrollController.addListener(_onScroll);

    // Add tab controller listener
    _tabController.addListener(_onTabChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailProvider>(
      builder: (context, productDetailProvider, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateSectionPositions(productDetailProvider);
        });

        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: _buildAppBar(),
          body: Column(
            children: [
              ProductDetailTabBar(
                tabController: _tabController,
                tabScrollController: _tabScrollController,
                onTabTapped: _onTabTapped,
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductDetailSection(
                        sectionKey: _overviewKey,
                        title: "Overview",
                        child: OverviewSection(
                          product: widget.product,
                          pageController: _pageController,
                          onPageChanged: (index) {
                            productDetailProvider.updateImageIndex(index);
                          },
                        ),
                      ),
                      ProductDetailSection(
                        sectionKey: _productDetailsKey,
                        title: "Product Details",
                        child: ProductInfoSection(product: widget.product),
                      ),
                      ProductDetailSection(
                        sectionKey: _ratingsKey,
                        title: "Ratings & Reviews",
                        child:
                            RatingsAndReviewsSection(product: widget.product),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: CartTestButton(product: widget.product),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Product Detail",
        style: TextStyle(color: AppColors.whiteColor, fontSize: 16.sp),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
    );
  }

  void _onScroll() {
    final productDetailProvider =
        Provider.of<ProductDetailProvider>(context, listen: false);

    // Skip if we're programmatically scrolling
    if (productDetailProvider.isScrolling) return;

    // Update section positions
    _updateSectionPositions(productDetailProvider);

    // Get the correct tab index based on scroll position
    final scrollOffset = _scrollController.offset;
    final newTabIndex =
        productDetailProvider.getTabIndexForScrollPosition(scrollOffset);

    // Update tab index if it changed
    if (_tabController.index != newTabIndex) {
      productDetailProvider.updateTabIndex(newTabIndex);
      _tabController.animateTo(newTabIndex);
      _scrollToTab(newTabIndex);
    }
  }

  void _onTabChanged() {
    final productDetailProvider =
        Provider.of<ProductDetailProvider>(context, listen: false);

    // Update provider with current tab index
    if (productDetailProvider.currentTabIndex != _tabController.index) {
      productDetailProvider.updateTabIndex(_tabController.index);
    }
  }

  void _updateSectionPositions(ProductDetailProvider provider) {
    // Update section positions for scroll synchronization
    final overviewBox =
        _overviewKey.currentContext?.findRenderObject() as RenderBox?;
    final productDetailsBox =
        _productDetailsKey.currentContext?.findRenderObject() as RenderBox?;
    final ratingsBox =
        _ratingsKey.currentContext?.findRenderObject() as RenderBox?;

    if (overviewBox != null) {
      final position = overviewBox.localToGlobal(Offset.zero).dy;
      provider.updateSectionPosition('overview', position);
    }

    if (productDetailsBox != null) {
      final position = productDetailsBox.localToGlobal(Offset.zero).dy;
      provider.updateSectionPosition('productDetails', position);
    }

    if (ratingsBox != null) {
      final position = ratingsBox.localToGlobal(Offset.zero).dy;
      provider.updateSectionPosition('ratings', position);
    }
  }

  Future<void> _scrollToSection(GlobalKey key) async {
    if (key.currentContext == null) return;

    final productDetailProvider =
        Provider.of<ProductDetailProvider>(context, listen: false);

    // Set scrolling state to prevent scroll listener from interfering
    productDetailProvider.setScrolling(true);

    try {
      // Calculate the target position
      final RenderBox? renderBox =
          key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero).dy;
        final targetOffset = position - 100; // Offset for better visibility

        // Animate to the target position
        await _scrollController.animateTo(
          targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    } catch (e) {
      // Fallback to ensureVisible if animation fails
      await Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } finally {
      // Reset scrolling state after a short delay
      Future.delayed(const Duration(milliseconds: 100), () {
        productDetailProvider.setScrolling(false);
      });
    }
  }

  /// **Scrolls the TabBar automatically when a tab is selected**
  void _scrollToTab(int index) {
    double tabWidth = 100.0.w;
    double targetScroll = index * tabWidth -
        (MediaQuery.of(context).size.width / 2) +
        (tabWidth / 2);

    _tabScrollController.animateTo(
      targetScroll,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onTabTapped(int index) {
    _scrollToSection(_getKeyForIndex(index));
    _scrollToTab(index);
  }

  GlobalKey _getKeyForIndex(int index) {
    switch (index) {
      case 0:
        return _overviewKey; // Overview tab
      case 1:
        return _productDetailsKey; // Product Details tab
      case 2:
        return _ratingsKey; // Ratings & Reviews tab
      default:
        return _overviewKey;
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _scrollController.removeListener(_onScroll);
    _tabController.dispose();
    _scrollController.dispose();
    _tabScrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
