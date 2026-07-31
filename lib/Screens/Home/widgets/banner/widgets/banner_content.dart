//this class does NOT store data.
// It only receives a single banner and displays its content.

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'banner_card.dart';
import '../../../../../models/banner_model.dart';
import '../provider/banner_provider.dart';

class BannerContent extends StatelessWidget {
  final int index;

  const BannerContent({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final bannerProvider = Provider.of<BannerProvider>(context);
    final bannerCount = bannerProvider.banners.length;

    if (bannerCount == 0) {
      return const SizedBox();
    }

    final BannerModel banner = bannerProvider.banners[index % bannerCount];

    return BannerCard(
      productName: banner.productName,
      productDescription: banner.productDescription,
      productPrice: banner.productPrice,
      buyNowButton: banner.buyNowButton,
      productImage: banner.productImage,
    );
  }
}
