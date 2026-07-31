import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../Utils/app_colors.dart';

class DynamicProductImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  const DynamicProductImage({
    super.key,
    this.imageUrl,
    this.width = 70,
    this.height = 70,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.greyColor.withOpacity(0.1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: _buildImageWidget(),
      ),
    );
  }

  Widget _buildImageWidget() {
    // If no image URL or empty, show placeholder
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildPlaceholder();
    }

    // If it's a network URL, use CachedNetworkImage
    if (imageUrl!.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: fit,
        placeholder: (context, url) => _buildLoadingPlaceholder(),
        errorWidget: (context, url, error) => _buildErrorPlaceholder(),
        fadeInDuration: const Duration(milliseconds: 300),
        fadeOutDuration: const Duration(milliseconds: 100),
      );
    }

    // If it's a local asset path, try to load as asset
    if (imageUrl!.startsWith('assets/')) {
      return Image.asset(
        imageUrl!,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildErrorPlaceholder(),
      );
    }

    // For other cases, try to construct a network URL
    final networkUrl = _constructNetworkUrl(imageUrl!);
    return CachedNetworkImage(
      imageUrl: networkUrl,
      fit: fit,
      placeholder: (context, url) => _buildLoadingPlaceholder(),
      errorWidget: (context, url, error) => _buildErrorPlaceholder(),
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 100),
    );
  }

  String _constructNetworkUrl(String imagePath) {
    // Remove any leading slashes
    String cleanPath = imagePath.replaceAll(RegExp(r'^/+'), '');

    // If it already contains the base URL, return as is
    if (cleanPath.contains('ehomes.pk') || cleanPath.contains('klik.pk')) {
      return cleanPath.startsWith('http') ? cleanPath : 'https://$cleanPath';
    }

    // Construct the full URL
    return 'https://ehomes.pk/Vendor_Panel/uploads/$cleanPath';
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.greyColor.withOpacity(0.1),
      child: Icon(
        Icons.image_not_supported_outlined,
        color: AppColors.greyColor,
        size: 24.sp,
      ),
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      color: AppColors.greyColor.withOpacity(0.1),
      child: Center(
        child: SizedBox(
          width: 16.w,
          height: 16.h,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: AppColors.greyColor.withOpacity(0.1),
      child: Icon(
        Icons.broken_image_outlined,
        color: AppColors.greyColor,
        size: 24.sp,
      ),
    );
  }
}
