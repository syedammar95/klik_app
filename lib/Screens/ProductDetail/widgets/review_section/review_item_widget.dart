import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Utils/app_colors.dart';
import '../../../../models/reviews_model.dart';

/// ReviewItemWidget
/// Displays individual review items with modern styling
class ReviewItemWidget extends StatelessWidget {
  final ReviewModel review;

  const ReviewItemWidget({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.lightGreyColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReviewHeader(),
          SizedBox(height: 12.h),
          _buildReviewContent(),
          SizedBox(height: 12.h),
          _buildReviewFooter(),
        ],
      ),
    );
  }

  Widget _buildReviewHeader() {
    return Row(
      children: [
        // User Avatar
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Icon(
            Icons.person,
            color: AppColors.primaryColor,
            size: 20.sp,
          ),
        ),
        SizedBox(width: 12.w),
        // User Info and Rating
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      review.name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildStarRating(),
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                _formatDate(review.createdAt),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStarRating() {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < review.rating ? Icons.star : Icons.star_border,
          color: AppColors.yellowColor,
          size: 14.sp,
        );
      }),
    );
  }

  Widget _buildReviewContent() {
    return Text(
      review.review,
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.blackColor,
        height: 1.4,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildReviewFooter() {
    return Row(
      children: [
        // Review Status Badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: review.isApproved == 1
                ? AppColors.greenColor.withOpacity(0.1)
                : AppColors.orangeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                review.isApproved == 1 ? Icons.check_circle : Icons.pending,
                size: 12.sp,
                color: review.isApproved == 1
                    ? AppColors.greenColor
                    : AppColors.orangeColor,
              ),
              SizedBox(width: 4.w),
              Text(
                review.isApproved == 1 ? 'Verified' : 'Pending',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: review.isApproved == 1
                      ? AppColors.greenColor
                      : AppColors.orangeColor,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        // Rating Number
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            '${review.rating}/5',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return 'Today';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return months == 1 ? '1 month ago' : '$months months ago';
      } else {
        final years = (difference.inDays / 365).floor();
        return years == 1 ? '1 year ago' : '$years years ago';
      }
    } catch (e) {
      return 'Recently';
    }
  }
}
