import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/core/constants/cached_image_widget.dart';
import 'package:tango/core/utils/price_utils.dart';
import 'package:tango/data/models/product_model.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/state/providers/home_provider.dart';
import 'package:tango/state/providers/theme_provider.dart';
import 'package:tango/view/widgets/discount_banner.dart';
import 'package:tango/view/widgets/other_widget.dart';

class ProductViewAll extends StatefulWidget {
  const ProductViewAll({super.key});

  @override
  State<ProductViewAll> createState() => _ProductViewAllState();
}

class _ProductViewAllState extends State<ProductViewAll> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await homeProvider.getProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n().getValue()!.product_view_all,
          maxLines: 1,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: homeProvider.productList.length,
        itemBuilder: (BuildContext context, int index) {
          ProductModel item = homeProvider.productList[index];
          return InkWell(
            onTap: () {
              unawaited(
                  RoutingService().pushNamed(Routes.productDetailsScreen.name));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              width: fullWidth(context) / 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color:
                      themeProvider.isDark ? AppColors.white : AppColors.black,
                ),
              ),
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 20,
                        child: CachedImageWidget(
                          imageUrl: item.imageUrl ?? "",
                          height: fullHeight(context) / 9,
                          width: fullWidth(context) / 3,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.name ?? "",
                              maxLines: 1,
                              style: TextStyle(
                                color: themeProvider.isDark
                                    ? AppColors.white
                                    : AppColors.black,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(2),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        (double.tryParse(
                                                    item.rating.toString()) ??
                                                0.0.toInt())
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Gap(3),
                                      const Icon(
                                        Icons.star,
                                        size: 15,
                                        color: AppColors.primary,
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(5),
                                Text(
                                  "${item.rating} Ratings",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: themeProvider.isDark
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(5),
                            Text(
                              '₹${item.price} / ${item.quantity} ${item.unit}',
                              style: TextStyle(
                                decoration: (item.discount ?? false)
                                    ? TextDecoration.lineThrough
                                    : null,
                                fontSize: (item.discount ?? false) ? 10 : 16,
                                color: (item.discount ?? false)
                                    ? AppColors.grey
                                    : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (item.discount ?? false)
                              Text(
                                "₹${calculateDiscountedPrice(
                                  (int.tryParse(item.price.toString()) ?? 0.0)
                                      .toDouble(),
                                  (int.tryParse(item.discountPercentage
                                              .toString()) ??
                                          0.0)
                                      .toDouble(),
                                ).toStringAsFixed(0).toString()} / ${item.quantity} ${item.unit}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   right: 0,
                  //   child: AddButton(
                  //     productId: item.id ?? "",
                  //     product: item,
                  //     productKey: productKey,
                  //     cartKey: cartKey,
                  //   ),
                  // ),
                  if (item.discount ?? false)
                    Positioned(
                      top: 0,
                      left: 10,
                      child: DiscountBannerWidget(
                          discount:
                              "${item.discountPercentage.toString()}% OFF"),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: LikeButton(
                      onTap: (isLiked) async {
                        if (isLiked) {
                          homeProvider.removeFromWishlist(item.id ?? "");
                          return false;
                        } else {
                          homeProvider.addWishlist(item);
                          return true;
                        }
                      },
                      size: 18,
                      isLiked: item.isInWishlist,
                      animationDuration: const Duration(milliseconds: 1000),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
