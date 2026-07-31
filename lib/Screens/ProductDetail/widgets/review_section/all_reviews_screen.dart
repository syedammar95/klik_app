import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../models/product/product_model.dart';
import '../../provider/review_provider.dart';
import 'review_item_widget.dart';
import 'review_form_bottom_sheet.dart';

/// AllReviewsScreen
/// Dedicated screen to display all reviews for a product
class AllReviewsScreen extends StatefulWidget {
  final ProductModel product;

  const AllReviewsScreen({
    super.key,
    required this.product,
  });

  @override
  State<AllReviewsScreen> createState() => _AllReviewsScreenState();
}

class _AllReviewsScreenState extends State<AllReviewsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch reviews when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReviewProvider>().fetchReviews(widget.product.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: _buildAppBar(),
      body: Consumer<ReviewProvider>(
        builder: (context, reviewProvider, child) {
          if (reviewProvider.isLoading) {
            return _buildLoadingState();
          } else if (reviewProvider.error != null) {
            return _buildErrorState(reviewProvider.error!);
          } else if (reviewProvider.reviews.isEmpty) {
            return _buildEmptyState();
          } else {
            return _buildReviewsList(reviewProvider);
          }
        },
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
      elevation: 0,
      title: Text(
        'Reviews & Ratings',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Consumer<ReviewProvider>(
          builder: (context, reviewProvider, child) {
            if (reviewProvider.reviews.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Center(
                  child: Text(
                    '${reviewProvider.reviews.length} reviews',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.whiteColor.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: AppColors.redColor,
            ),
            SizedBox(height: 16.h),
            Text(
              'Failed to load reviews',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              error,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.greyColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () {
                context
                    .read<ReviewProvider>()
                    .fetchReviews(widget.product.productId);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whiteColor,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star_border,
              size: 64.sp,
              color: AppColors.greyColor,
            ),
            SizedBox(height: 16.h),
            Text(
              'No reviews yet',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Be the first to share your experience with this product',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.greyColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: _showReviewForm,
              icon: const Icon(Icons.add),
              label: const Text('Write a Review'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whiteColor,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsList(ReviewProvider reviewProvider) {
    return Column(
      children: [
        // Rating Summary Header
        _buildRatingSummaryHeader(reviewProvider),
        // Reviews List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: reviewProvider.reviews.length,
            itemBuilder: (context, index) {
              final review = reviewProvider.reviews[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: ReviewItemWidget(review: review),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSummaryHeader(ReviewProvider reviewProvider) {
    final averageRating = reviewProvider.averageRating;
    final totalReviews = reviewProvider.reviews.length;
    final ratingBreakdown = reviewProvider.ratingBreakdown;

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.boxShadowColor,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Average Rating
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  _buildStarRating(averageRating),
                  SizedBox(height: 4.h),
                  Text(
                    'Based on $totalReviews review${totalReviews != 1 ? 's' : ''}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 32.w),
              // Rating Breakdown
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [5, 4, 3, 2, 1].map((rating) {
                    final count = ratingBreakdown[rating] ?? 0;
                    final percentage =
                        totalReviews > 0 ? (count / totalReviews) * 100 : 0.0;

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Row(
                        children: [
                          Text(
                            '$rating',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.greyColor,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.star,
                            size: 12.sp,
                            color: AppColors.yellowColor,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: percentage / 100,
                              backgroundColor: AppColors.lightGreyColor
                                  .withValues(alpha: 0.3),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.yellowColor),
                              minHeight: 6.h,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '$count',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStarRating(double rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star
              : index < rating
                  ? Icons.star_half
                  : Icons.star_border,
          color: AppColors.yellowColor,
          size: 18.sp,
        );
      }),
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: _showReviewForm,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.whiteColor,
        elevation: 0,
        icon: Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: AppColors.whiteColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.add,
            size: 16.sp,
            color: AppColors.whiteColor,
          ),
        ),
        label: Text(
          'Write Review',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  void _showReviewForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReviewFormBottomSheet(
        product: widget.product,
        onSubmit: (name, email, rating, review) async {
          final success = await context.read<ReviewProvider>().submitReview(
                productId: widget.product.productId,
                categoryId: widget.product.categoryId,
                name: name,
                email: email,
                rating: rating,
                review: review,
              );

          if (success && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Review submitted successfully!'),
                backgroundColor: AppColors.greenColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.read<ReviewProvider>().error ??
                    'Failed to submit review'),
                backgroundColor: AppColors.redColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
      ),
    );
  }
}
