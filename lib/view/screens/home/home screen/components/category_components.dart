import 'dart:async';
import 'add_button.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/core/utils/price_utils.dart';
import 'package:tango/data/models/product_model.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/view/widgets/discount_banner.dart';
import 'package:tango/core/constants/carousel_helper.dart';
import 'package:tango/state/providers/theme_provider.dart';
import 'package:tango/state/providers/view_all_provider.dart';
import 'package:tango/state/providers/add_to_cart_provider.dart';

class ProductItem extends StatefulWidget {
  final String? whereCondition;
  const ProductItem({
    super.key,
    this.whereCondition,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await viewAllProvider.getProduct();
    });
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    AddToCartProvider addToCartProvider =
        Provider.of<AddToCartProvider>(context);
    ViewAllProvider viewAllProvider = Provider.of<ViewAllProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                textAlign: TextAlign.center,
                (widget.whereCondition != null)
                    ? widget.whereCondition ?? ""
                    : "You might need",
                style: TextStyle(
                  color: themeProvider.isDark
                      ? AppColors.grey
                      : AppColors.lightPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              InkWell(
                onTap: () {
                  unawaited(
                    RoutingService().pushNamed(
                      Routes.productViewAll.name,
                    ),
                  );
                },
                child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: themeProvider.isDark
                        ? AppColors.grey
                        : AppColors.lightPrimary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: themeProvider.isDark
                        ? AppColors.darkSurface
                        : AppColors.lightSurface,
                    size: 15,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: fullHeight(context) / 3.6,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: viewAllProvider.product.length,
            itemBuilder: (context, index) {
              ProductModel item = viewAllProvider.product[index];
              String productId = viewAllProvider.product[index].id ?? '';

              GlobalKey productKey = GlobalKey();
              return InkWell(
                onTap: () {
                  unawaited(
                    RoutingService().pushNamed(
                      Routes.productDetailsScreen.name,
                      queryParameters: {
                        'post_id': item.id,
                        'category_id': item.categoryId,
                      },
                    ),
                  );
                },
                child: Container(
                  key: productKey,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  width: fullWidth(context) / 2.5,
                  decoration: BoxDecoration(
                    color: themeProvider.isDark
                        ? AppColors.black
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey,
                        offset: const Offset(.5, .5),
                        blurRadius: .5,
                        spreadRadius: .5,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CarouselWidget(
                              imageUrls: List<String>.from(item.imageUrl ?? []),
                              width: fullWidth(context) / 2.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        color: themeProvider.isDark
                                            ? AppColors.darkPrimary
                                                .withValues(alpha: 0.4)
                                            : AppColors.lightPrimary
                                                .withValues(alpha: 0.4),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            (double.tryParse(item.rating
                                                        .toString()) ??
                                                    0.0.toInt())
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: themeProvider.isDark
                                                  ? AppColors.white
                                                  : AppColors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Gap(3),
                                          Icon(
                                            Icons.star,
                                            size: 15,
                                            color: themeProvider.isDark
                                                ? AppColors.white
                                                : AppColors.black,
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
                                  '₹${item.price} / ${item.unit}',
                                  style: TextStyle(
                                    decoration: (item.discount ?? false)
                                        ? TextDecoration.lineThrough
                                        : null,
                                    fontSize:
                                        (item.discount ?? false) ? 10 : 16,
                                    color: (item.discount ?? false)
                                        ? AppColors.grey
                                        : themeProvider.isDark
                                            ? AppColors.white
                                            : AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (item.discount ?? false)
                                  Text(
                                    "₹${calculateDiscountedPrice(
                                      (int.tryParse(item.price.toString()) ??
                                              0.0)
                                          .toDouble(),
                                      (int.tryParse(item.discountPercentage
                                                  .toString()) ??
                                              0.0)
                                          .toDouble(),
                                    ).toStringAsFixed(0).toString()} / ${item.quantity} ${item.unit}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: themeProvider.isDark
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: AddButton(
                          productId: productId,
                          product: item,
                          productKey: productKey,
                        ),
                      ),
                      if (item.discount ?? false)
                        Positioned(
                          top: 0,
                          left: 10,
                          child: DiscountBannerWidget(
                            discount:
                                "${item.discountPercentage.toString()}% OFF",
                          ),
                        ),
                      // Positioned(
                      //   top: 8,
                      //   right: 8,
                      //   child: LikeButton(
                      //     circleColor: CircleColor(
                      //       start: AppColors.darkPrimary,
                      //       end: AppColors.darkPrimary,
                      //     ),
                      //     bubblesColor: BubblesColor(
                      //       dotPrimaryColor: AppColors.darkPrimary,
                      //       dotSecondaryColor: AppColors.darkPrimary,
                      //     ),
                      //     onTap: (isLiked) async {
                      //       if (isLiked) {
                      //         viewAllProvider.removeFromWishlist(item.id ?? "");
                      //         return false;
                      //       } else {
                      //         viewAllProvider.addWishlist(item);
                      //         return true;
                      //       }
                      //     },
                      //     size: 18,
                      //     isLiked: item.isInWishlist,
                      //     animationDuration: const Duration(milliseconds: 1000),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
