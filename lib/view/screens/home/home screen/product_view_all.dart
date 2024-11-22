import 'dart:async';
import 'package:gap/gap.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:like_button/like_button.dart';
import 'package:tango/core/utils/price_utils.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/data/models/product_model.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/view/widgets/discount_banner.dart';
import 'package:tango/state/providers/home_provider.dart';
import 'package:tango/state/providers/theme_provider.dart';
import 'package:tango/core/constants/cached_image_widget.dart';
import 'package:tango/state/providers/add_to_cart_provider.dart';

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

  ProductModel? product;
  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    AddToCartProvider addToCartProvider =
        Provider.of<AddToCartProvider>(context);

    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      bottomNavigationBar: addToCartProvider.cart.isNotEmpty
          ? Container(
              color: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Total Price Display
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${addToCartProvider.cart.length}', // Assuming `totalPrice` is a property in `addToCartProvider`
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        'Items added',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      await Future.microtask(() {
                        RoutingService().pushNamed(
                          Routes.cart.name,
                        );
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View Cart', // Assuming `totalPrice` is a property in `addToCartProvider`
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(2),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: AppColors.white,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          : null,
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

          product = addToCartProvider.idByProduct((item.id).toString());
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
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              // width: fullWidth(context),
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
                        shadowColor: themeProvider.isDark
                            ? AppColors.white
                            : AppColors.black,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '₹${item.price} / ${item.quantity} ${item.unit}',
                                      style: TextStyle(
                                        decoration: (item.discount ?? false)
                                            ? TextDecoration.lineThrough
                                            : null,
                                        fontSize:
                                            (item.discount ?? false) ? 10 : 16,
                                        color: (item.discount ?? false)
                                            ? AppColors.grey
                                            : Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (item.discount ?? false)
                                      Text(
                                        "₹${calculateDiscountedPrice(
                                          (int.tryParse(
                                                      item.price.toString()) ??
                                                  0.0)
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
                                // const Gap(25),
                                // (addToCartProvider
                                //         .idItemContains(item.id ?? ""))
                                //     ? Container(
                                //         padding: const EdgeInsets.symmetric(
                                //             vertical: 5, horizontal: 5),
                                //         decoration: BoxDecoration(
                                //           color: AppColors.lightPrimary,
                                //           borderRadius: const BorderRadius.only(
                                //             topLeft: Radius.circular(10),
                                //             bottomLeft: Radius.circular(10),
                                //           ),
                                //         ),
                                //         child: Row(
                                //           mainAxisSize: MainAxisSize.min,
                                //           children: [
                                //             InkWell(
                                //               onTap: () {
                                //                 if ((int.tryParse(product!
                                //                             .totalQuantity
                                //                             .toString()) ??
                                //                         0) >
                                //                     (int.tryParse(product!
                                //                             .quantity
                                //                             .toString()) ??
                                //                         0)) {
                                //                   addToCartProvider
                                //                       .updateQuantity(
                                //                           product!.id!, 0);
                                //                 } else {
                                //                   addToCartProvider
                                //                       .removeItem(product!.id!);
                                //                 }
                                //               },
                                //               child: Container(
                                //                 alignment: Alignment.center,
                                //                 width: 20,
                                //                 height: 20,
                                //                 child: Icon(
                                //                   Icons.remove,
                                //                   size: 15,
                                //                   color: themeProvider.isDark
                                //                       ? AppColors.darkSurface
                                //                       : AppColors.lightSurface,
                                //                 ),
                                //               ),
                                //             ),
                                //             const Gap(2),
                                //             Container(
                                //               alignment: Alignment.center,
                                //               width: 20,
                                //               height: 20,
                                //               child: Text(
                                //                 ((int.tryParse(product!
                                //                                 .totalQuantity
                                //                                 .toString()) ??
                                //                             0) /
                                //                         (int.tryParse(product!
                                //                                 .quantity
                                //                                 .toString()) ??
                                //                             0))
                                //                     .toStringAsFixed(0),
                                //                 style: TextStyle(
                                //                   fontSize: 16,
                                //                   color: themeProvider.isDark
                                //                       ? AppColors.darkSurface
                                //                       : AppColors.lightSurface,
                                //                 ),
                                //               ),
                                //             ),
                                //             const Gap(2),
                                //             InkWell(
                                //               onTap: () {
                                //                 addToCartProvider
                                //                     .updateQuantity(
                                //                         product!.id!, 1);
                                //               },
                                //               child: Container(
                                //                 alignment: Alignment.center,
                                //                 width: 20,
                                //                 height: 20,
                                //                 child: Icon(
                                //                   Icons.add,
                                //                   size: 15,
                                //                   color: themeProvider.isDark
                                //                       ? AppColors.darkSurface
                                //                       : AppColors.lightSurface,
                                //                 ),
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       )
                                //     : GestureDetector(
                                //         onTap: () async {
                                //           await addToCartProvider.addCart(item);
                                //         },
                                //         child: Container(
                                //           padding: const EdgeInsets.symmetric(
                                //               horizontal: 10, vertical: 10),
                                //           decoration: BoxDecoration(
                                //             color: AppColors.lightPrimary,
                                //             borderRadius:
                                //                 BorderRadius.circular(10),
                                //           ),
                                //           child: Icon(
                                //             Icons.add,
                                //             size: 15,
                                //             color: themeProvider.isDark
                                //                 ? AppColors.darkSurface
                                //                 : AppColors.lightSurface,
                                //           ),
                                //         ),
                                //       ),
                              ],
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
