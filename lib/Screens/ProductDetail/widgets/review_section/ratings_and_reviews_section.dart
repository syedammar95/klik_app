import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../models/product/product_model.dart';
import '../../provider/review_provider.dart';
import 'review_form_bottom_sheet.dart';
import 'review_item_widget.dart';
import 'all_reviews_screen.dart';

/// RatingsAndReviewsSection Widget
/// Displays product ratings and reviews information with dynamic functionality
class RatingsAndReviewsSection extends StatefulWidget {
  final ProductModel product;

  const RatingsAndReviewsSection({
    super.key,
    required this.product,
  });

  @override
  State<RatingsAndReviewsSection> createState() =>
      _RatingsAndReviewsSectionState();
}

class _RatingsAndReviewsSectionState extends State<RatingsAndReviewsSection> {
  @override
  void initState() {
    super.initState();
    // Fetch reviews when the widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReviewProvider>().fetchReviews(widget.product.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.boxShadowColor),
      ),
      child: Consumer<ReviewProvider>(
        builder: (context, reviewProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(reviewProvider),
              SizedBox(height: 16.h),
              if (reviewProvider.isLoading) ...[
                _buildLoadingIndicator(),
              ] else if (reviewProvider.error != null) ...[
                _buildErrorWidget(reviewProvider.error!),
              ] else if (reviewProvider.reviews.isEmpty) ...[
                _buildNoReviewsPlaceholder(),
              ] else ...[
                _buildRatingSummary(reviewProvider),
                SizedBox(height: 16.h),
                _buildReviewsList(reviewProvider),
                SizedBox(height: 16.h),
                _buildActionButtons(),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(ReviewProvider reviewProvider) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: AppColors.yellowColor,
          size: 24.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          'Ratings & Reviews',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
        const Spacer(),
        if (reviewProvider.reviews.isNotEmpty)
          Text(
            '(${reviewProvider.reviews.length})',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.greyColor,
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      padding: EdgeInsets.all(32.w),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.redColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.redColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.redColor,
            size: 32.sp,
          ),
          SizedBox(height: 8.h),
          Text(
            'Failed to load reviews',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.redColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            error,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.greyColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          ElevatedButton(
            onPressed: () {
              context
                  .read<ReviewProvider>()
                  .fetchReviews(widget.product.productId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            ),
            child: Text(
              'Retry',
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoReviewsPlaceholder() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.star_border,
            size: 48.sp,
            color: AppColors.greyColor,
          ),
          SizedBox(height: 12.h),
          Text(
            'No reviews yet',
            style: TextStyle(
              fontSize: 16.sp,
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
          SizedBox(height: 16.h),
          _buildAddReviewButton(),
        ],
      ),
    );
  }

  Widget _buildRatingSummary(ReviewProvider reviewProvider) {
    final averageRating = reviewProvider.averageRating;
    final totalReviews = reviewProvider.reviews.length;
    final ratingBreakdown = reviewProvider.ratingBreakdown;

    return Column(
      children: [
        Row(
          children: [
            // Average Rating Display
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  averageRating.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 32.sp,
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
            SizedBox(width: 24.w),
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
                            backgroundColor:
                                AppColors.lightGreyColor.withOpacity(0.3),
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
          size: 16.sp,
        );
      }),
    );
  }

  Widget _buildReviewsList(ReviewProvider reviewProvider) {
    // Show only the first 3 reviews in the preview
    final previewReviews = reviewProvider.reviews.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Reviews',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(height: 12.h),
        ...previewReviews
            .map((review) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: ReviewItemWidget(review: review),
                ))
            .toList(),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildAddReviewButton(),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildSeeAllReviewsButton(),
        ),
      ],
    );
  }

  Widget _buildAddReviewButton() {
    return Container(
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showReviewForm(),
          borderRadius: BorderRadius.circular(12.r),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 16.sp,
                    color: AppColors.whiteColor,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Add Review',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.whiteColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeeAllReviewsButton() {
    return Consumer<ReviewProvider>(
      builder: (context, reviewProvider, child) {
        if (reviewProvider.reviews.length <= 3) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          height: 48.h,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.primaryColor,
              width: 2.w,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _navigateToAllReviews(),
              borderRadius: BorderRadius.circular(12.r),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'See All (${reviewProvider.reviews.length})',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 16.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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

  void _navigateToAllReviews() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllReviewsScreen(product: widget.product),
      ),
    );
  }
}
