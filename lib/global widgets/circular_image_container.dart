import 'package:flutter/material.dart';
import '../Utils/app_colors.dart';

/// 🔹 **Reusable Circular Image Container Widget**
///
/// A modular widget that displays images in a circular container with
/// theme-adaptive outline and shadow effects following Material Design guidelines.
///
/// Features:
/// - Perfect circular shape with consistent sizing
/// - Theme-adaptive outline color (light/dark mode support)
/// - Material Design compliant shadows
/// - Loading states with branded indicators
/// - Error handling with fallback icons
/// - Network and asset image support
class CircularImageContainer extends StatelessWidget {
  final String imageUrl;
  final double size;
  final double outlineWidth;
  final Color? customOutlineColor;
  final Color? customBackgroundColor;
  final IconData? fallbackIcon;
  final Color? fallbackIconColor;
  final VoidCallback? onTap;
  final bool showShadow;
  final double shadowBlurRadius;
  final Offset shadowOffset;

  const CircularImageContainer({
    super.key,
    required this.imageUrl,
    this.size = 40.0,
    this.outlineWidth = 0.5,
    this.customOutlineColor,
    this.customBackgroundColor,
    this.fallbackIcon,
    this.fallbackIconColor,
    this.onTap,
    this.showShadow = true,
    this.shadowBlurRadius = 0.0,
    this.shadowOffset = const Offset(0, 2),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: _getOutlineColor(),
            width: outlineWidth,
          ),
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: _getOutlineColor().withValues(alpha: 0.1),
                    blurRadius: shadowBlurRadius,
                    offset: shadowOffset,
                  ),
                ]
              : null,
        ),
        child: ClipOval(
          child: _buildImageContent(),
        ),
      ),
    );
  }

  /// 🔹 **Build Image Content (Network or Asset)**
  Widget _buildImageContent() {
    if (imageUrl.isEmpty || imageUrl == 'null') {
      return _buildFallbackIcon();
    }

    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackIcon();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildFallbackIcon();
        },
      );
    } else {
      return Image.asset(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackIcon();
        },
      );
    }
  }

  /// 🔹 **Build Fallback Icon**
  Widget _buildFallbackIcon() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        shape: BoxShape.circle,
      ),
      child: Icon(
        fallbackIcon ?? Icons.image_not_supported,
        size: size * 0.5,
        color: _getFallbackIconColor(),
      ),
    );
  }

  /// 🔹 **Get Theme-Adaptive Outline Color**
  Color _getOutlineColor() {
    if (customOutlineColor != null) {
      return customOutlineColor!;
    }

    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    if (brightness == Brightness.dark) {
      return AppColors.primaryColor.withValues(alpha: 0.6);
    } else {
      return AppColors.primaryColor.withValues(alpha: 0.8);
    }
  }

  /// 🔹 **Get Theme-Adaptive Background Color**
  Color _getBackgroundColor() {
    if (customBackgroundColor != null) {
      return customBackgroundColor!;
    }

    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    if (brightness == Brightness.dark) {
      return AppColors.primaryColor.withValues(alpha: 0.15);
    } else {
      return AppColors.primaryColor.withValues(alpha: 0.1);
    }
  }

  /// 🔹 **Get Theme-Adaptive Fallback Icon Color**
  Color _getFallbackIconColor() {
    if (fallbackIconColor != null) {
      return fallbackIconColor!;
    }

    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    if (brightness == Brightness.dark) {
      return AppColors.primaryColor.withValues(alpha: 0.7);
    } else {
      return AppColors.primaryColor.withValues(alpha: 0.8);
    }
  }
}

/// 🔹 **Predefined Circular Image Container Variants**
class CircularImageVariants {
  /// Small circular image (32px)
  static Widget small({
    required String imageUrl,
    VoidCallback? onTap,
    IconData? fallbackIcon,
  }) {
    return CircularImageContainer(
      imageUrl: imageUrl,
      size: 32.0,
      outlineWidth: 0.5,
      onTap: onTap,
      fallbackIcon: fallbackIcon,
    );
  }

  /// Medium circular image (40px) - Default
  static Widget medium({
    required String imageUrl,
    VoidCallback? onTap,
    IconData? fallbackIcon,
  }) {
    return CircularImageContainer(
      imageUrl: imageUrl,
      size: 40.0,
      outlineWidth: 0.5,
      onTap: onTap,
      fallbackIcon: fallbackIcon,
    );
  }

  /// Large circular image (56px)
  static Widget large({
    required String imageUrl,
    VoidCallback? onTap,
    IconData? fallbackIcon,
  }) {
    return CircularImageContainer(
      imageUrl: imageUrl,
      size: 56.0,
      outlineWidth: 0.5,
      onTap: onTap,
      fallbackIcon: fallbackIcon,
    );
  }

  /// Extra large circular image (80px)
  static Widget extraLarge({
    required String imageUrl,
    VoidCallback? onTap,
    IconData? fallbackIcon,
  }) {
    return CircularImageContainer(
      imageUrl: imageUrl,
      size: 80.0,
      outlineWidth: 0.5,
      onTap: onTap,
      fallbackIcon: fallbackIcon,
    );
  }
}
