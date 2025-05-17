import 'dart:async';
import 'dart:developer';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';
import 'package:tango/core/constants/carousel_helper.dart';
import 'package:tango/core/constants/custom_cached_network_image.dart';
import 'package:tango/core/utils/price_utils.dart';
import 'package:tango/core/widget/app_text.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/data/models/product_model.dart';
import 'package:tango/state/providers/view_all_provider.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/state/providers/home_provider.dart';
import 'package:tango/state/providers/theme_provider.dart';
import 'package:tango/state/providers/add_to_cart_provider.dart';
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
      await viewAllProvider.getProduct();
    });
  }

  ProductModel? product;
  @override
  Widget build(BuildContext context) {
    ViewAllProvider viewAllProvider = Provider.of<ViewAllProvider>(context);
    AddToCartProvider addToCartProvider =
        Provider.of<AddToCartProvider>(context);

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
        itemCount: viewAllProvider.product.length,
        itemBuilder: (BuildContext context, int index) {
          ProductModel item = viewAllProvider.product[index];

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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color:
                      themeProvider.isDark ? AppColors.white : AppColors.black,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: fullHeight(context) / 9,
                    width: fullWidth(context) / 4,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CarouselWidget(
                        imageUrls: List<String>.from(item.imageUrl ?? []),
                        width: fullWidth(context) / 4,
                        height: fullHeight(context) / 9,
                        show: false,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: AppText(
                            text: item.name ?? "",
                            color: AppColors.lightPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        AppText(
                          text: "₹${item.price} / ${item.quantity}${item.unit}",
                          color: AppColors.lightPrimary,
                          fontWeight: FontWeight.bold,
                          textDecoration: (item.discount ?? false)
                              ? TextDecoration.lineThrough
                              : null,
                          fontSize: 12,
                        ),
                        if (item.discount ?? false)
                          Text(
                            "₹${calculateDiscountedPrice(
                              (int.tryParse(item.price.toString()) ?? 0.0)
                                  .toDouble(),
                              (int.tryParse(
                                          item.discountPercentage.toString()) ??
                                      0.0)
                                  .toDouble(),
                              (int.tryParse(item.discountFlat.toString()) ??
                                      0.0)
                                  .toDouble(),
                            ).toStringAsFixed(0).toString()}/${item.quantity}${item.unit}",
                            style: TextStyle(
                              fontSize: 10,
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
            ),

            // Container(
            //   margin: const EdgeInsets.symmetric(
            //     horizontal: 10,
            //     vertical: 10,
            //   ),
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 10,
            //     vertical: 10,
            //   ),
            //   // width: fullWidth(context),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     border: Border.all(
            //       color:
            //           themeProvider.isDark ? AppColors.white : AppColors.black,
            //     ),
            //   ),
            //   child: Stack(
            //     children: [
            //       Row(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text("data"),
            //           CarouselHelper(
            //             imageUrls: [
            //               "https://firebasestorage.googleapis.com/v0/b/gotogrocery-15ced.appspot.com/o/images%2Fimage_picker_68F97136-FB57-492B-A095-E047D75428FF-91598-0000113154E76E10.jpg?alt=media&token=5fd86224-0423-4055-9685-05fc28addc1a, https://firebasestorage.googleapis.com/v0/b/gotogrocery-15ced.appspot.com/o/images%2Fimage_picker_DCC7FEAE-2362-4FDA-A86F-72F90E772C6B-91598-0000113157E07300.jpg?alt=media&token=c1a6ed1a-acf1-4057-a96f-036b850f2539"
            //                   "https://firebasestorage.googleapis.com/v0/b/gotogrocery-15ced.appspot.com/o/images%2Fimage_picker_68F97136-FB57-492B-A095-E047D75428FF-91598-0000113154E76E10.jpg?alt=media&token=5fd86224-0423-4055-9685-05fc28addc1a, https://firebasestorage.googleapis.com/v0/b/gotogrocery-15ced.appspot.com/o/images%2Fimage_picker_DCC7FEAE-2362-4FDA-A86F-72F90E772C6B-91598-0000113157E07300.jpg?alt=media&token=c1a6ed1a-acf1-4057-a96f-036b850f2539"
            //                   "https://firebasestorage.googleapis.com/v0/b/gotogrocery-15ced.appspot.com/o/images%2Fimage_picker_68F97136-FB57-492B-A095-E047D75428FF-91598-0000113154E76E10.jpg?alt=media&token=5fd86224-0423-4055-9685-05fc28addc1a, https://firebasestorage.googleapis.com/v0/b/gotogrocery-15ced.appspot.com/o/images%2Fimage_picker_DCC7FEAE-2362-4FDA-A86F-72F90E772C6B-91598-0000113157E07300.jpg?alt=media&token=c1a6ed1a-acf1-4057-a96f-036b850f2539"
            //             ],
            //             width: fullWidth(context) / 2.5,
            //           ),
            //           // Card(
            //           //   elevation: 20,
            //           //   shadowColor: themeProvider.isDark
            //           //       ? AppColors.white
            //           //       : AppColors.black,
            //           //   child: CustomCachedNetworkImage(
            //           //     imageUrl: item.imageUrl?.first ?? "",
            //           //     height: fullHeight(context) / 9,
            //           //     width: fullWidth(context) / 3,
            //           //     fit: BoxFit.contain,
            //           //   ),
            //           // ),

            //           // Padding(
            //           //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //           //   child: Column(
            //           //     crossAxisAlignment: CrossAxisAlignment.start,
            //           //     mainAxisAlignment: MainAxisAlignment.center,
            //           //     children: [
            //           //       Text(
            //           //         item.name ?? "",
            //           //         maxLines: 1,
            //           //         style: TextStyle(
            //           //           color: themeProvider.isDark
            //           //               ? AppColors.white
            //           //               : AppColors.black,
            //           //           overflow: TextOverflow.ellipsis,
            //           //           fontSize: 15,
            //           //           fontWeight: FontWeight.bold,
            //           //         ),
            //           //       ),
            //           //       const Gap(2),
            //           //       Row(
            //           //         children: [
            //           //           Container(
            //           //             padding: const EdgeInsets.symmetric(
            //           //               vertical: 2,
            //           //               horizontal: 5,
            //           //             ),
            //           //             decoration: BoxDecoration(
            //           //               color: AppColors.primary.withOpacity(0.4),
            //           //               borderRadius: BorderRadius.circular(10),
            //           //             ),
            //           //             child: Row(
            //           //               children: [
            //           //                 Text(
            //           //                   (double.tryParse(
            //           //                               item.rating.toString()) ??
            //           //                           0.0.toInt())
            //           //                       .toString(),
            //           //                   style: const TextStyle(
            //           //                     fontSize: 12,
            //           //                     color: AppColors.primary,
            //           //                     fontWeight: FontWeight.bold,
            //           //                   ),
            //           //                 ),
            //           //                 const Gap(3),
            //           //                 const Icon(
            //           //                   Icons.star,
            //           //                   size: 15,
            //           //                   color: AppColors.primary,
            //           //                 ),
            //           //               ],
            //           //             ),
            //           //           ),
            //           //           const Gap(5),
            //           //           Text(
            //           //             "${item.rating} Ratings",
            //           //             style: TextStyle(
            //           //               fontSize: 12,
            //           //               color: themeProvider.isDark
            //           //                   ? AppColors.white
            //           //                   : AppColors.black,
            //           //               fontWeight: FontWeight.bold,
            //           //             ),
            //           //           ),
            //           //         ],
            //           //       ),
            //           //       const Gap(5),
            //           //       Row(
            //           //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           //         mainAxisSize: MainAxisSize.max,
            //           //         children: [
            //           //           Column(
            //           //             crossAxisAlignment: CrossAxisAlignment.start,
            //           //             mainAxisAlignment: MainAxisAlignment.start,
            //           //             mainAxisSize: MainAxisSize.min,
            //           //             children: [
            //           //               Text(
            //           //                 '₹${item.price} / ${item.quantity} ${item.unit}',
            //           //                 style: TextStyle(
            //           //                   decoration: (item.discount ?? false)
            //           //                       ? TextDecoration.lineThrough
            //           //                       : null,
            //           //                   fontSize:
            //           //                       (item.discount ?? false) ? 10 : 16,
            //           //                   color: (item.discount ?? false)
            //           //                       ? AppColors.grey
            //           //                       : Colors.green,
            //           //                   fontWeight: FontWeight.bold,
            //           //                 ),
            //           //               ),
            //           //               if (item.discount ?? false)
            //           //                 Text(
            //           //                   "₹${calculateDiscountedPrice(
            //           //                     (int.tryParse(
            //           //                                 item.price.toString()) ??
            //           //                             0.0)
            //           //                         .toDouble(),
            //           //                     (int.tryParse(item.discountPercentage
            //           //                                 .toString()) ??
            //           //                             0.0)
            //           //                         .toDouble(),
            //           //                   ).toStringAsFixed(0).toString()} / ${item.quantity} ${item.unit}",
            //           //                   style: const TextStyle(
            //           //                     fontSize: 16,
            //           //                     color: Colors.green,
            //           //                     fontWeight: FontWeight.bold,
            //           //                   ),
            //           //                 ),
            //           //             ],
            //           //           ),
            //           //           // const Gap(25),
            //           //           // (addToCartProvider
            //           //           //         .idItemContains(item.id ?? ""))
            //           //           //     ? Container(
            //           //           //         padding: const EdgeInsets.symmetric(
            //           //           //             vertical: 5, horizontal: 5),
            //           //           //         decoration: BoxDecoration(
            //           //           //           color: AppColors.lightPrimary,
            //           //           //           borderRadius: const BorderRadius.only(
            //           //           //             topLeft: Radius.circular(10),
            //           //           //             bottomLeft: Radius.circular(10),
            //           //           //           ),
            //           //           //         ),
            //           //           //         child: Row(
            //           //           //           mainAxisSize: MainAxisSize.min,
            //           //           //           children: [
            //           //           //             InkWell(
            //           //           //               onTap: () {
            //           //           //                 if ((int.tryParse(product!
            //           //           //                             .totalQuantity
            //           //           //                             .toString()) ??
            //           //           //                         0) >
            //           //           //                     (int.tryParse(product!
            //           //           //                             .quantity
            //           //           //                             .toString()) ??
            //           //           //                         0)) {
            //           //           //                   addToCartProvider
            //           //           //                       .updateQuantity(
            //           //           //                           product!.id!, 0);
            //           //           //                 } else {
            //           //           //                   addToCartProvider
            //           //           //                       .removeItem(product!.id!);
            //           //           //                 }
            //           //           //               },
            //           //           //               child: Container(
            //           //           //                 alignment: Alignment.center,
            //           //           //                 width: 20,
            //           //           //                 height: 20,
            //           //           //                 child: Icon(
            //           //           //                   Icons.remove,
            //           //           //                   size: 15,
            //           //           //                   color: themeProvider.isDark
            //           //           //                       ? AppColors.darkSurface
            //           //           //                       : AppColors.lightSurface,
            //           //           //                 ),
            //           //           //               ),
            //           //           //             ),
            //           //           //             const Gap(2),
            //           //           //             Container(
            //           //           //               alignment: Alignment.center,
            //           //           //               width: 20,
            //           //           //               height: 20,
            //           //           //               child: Text(
            //           //           //                 ((int.tryParse(product!
            //           //           //                                 .totalQuantity
            //           //           //                                 .toString()) ??
            //           //           //                             0) /
            //           //           //                         (int.tryParse(product!
            //           //           //                                 .quantity
            //           //           //                                 .toString()) ??
            //           //           //                             0))
            //           //           //                     .toStringAsFixed(0),
            //           //           //                 style: TextStyle(
            //           //           //                   fontSize: 16,
            //           //           //                   color: themeProvider.isDark
            //           //           //                       ? AppColors.darkSurface
            //           //           //                       : AppColors.lightSurface,
            //           //           //                 ),
            //           //           //               ),
            //           //           //             ),
            //           //           //             const Gap(2),
            //           //           //             InkWell(
            //           //           //               onTap: () {
            //           //           //                 addToCartProvider
            //           //           //                     .updateQuantity(
            //           //           //                         product!.id!, 1);
            //           //           //               },
            //           //           //               child: Container(
            //           //           //                 alignment: Alignment.center,
            //           //           //                 width: 20,
            //           //           //                 height: 20,
            //           //           //                 child: Icon(
            //           //           //                   Icons.add,
            //           //           //                   size: 15,
            //           //           //                   color: themeProvider.isDark
            //           //           //                       ? AppColors.darkSurface
            //           //           //                       : AppColors.lightSurface,
            //           //           //                 ),
            //           //           //               ),
            //           //           //             ),
            //           //           //           ],
            //           //           //         ),
            //           //           //       )
            //           //           //     : GestureDetector(
            //           //           //         onTap: () async {
            //           //           //           await addToCartProvider.addCart(item);
            //           //           //         },
            //           //           //         child: Container(
            //           //           //           padding: const EdgeInsets.symmetric(
            //           //           //               horizontal: 10, vertical: 10),
            //           //           //           decoration: BoxDecoration(
            //           //           //             color: AppColors.lightPrimary,
            //           //           //             borderRadius:
            //           //           //                 BorderRadius.circular(10),
            //           //           //           ),
            //           //           //           child: Icon(
            //           //           //             Icons.add,
            //           //           //             size: 15,
            //           //           //             color: themeProvider.isDark
            //           //           //                 ? AppColors.darkSurface
            //           //           //                 : AppColors.lightSurface,
            //           //           //           ),
            //           //           //         ),
            //           //           //       ),
            //           //         ],
            //           //       ),
            //           //     ],
            //           //   ),
            //           // ),
            //         ],
            //       ),
            //       // Positioned(
            //       //   bottom: 0,
            //       //   right: 0,
            //       //   child: AddButton(
            //       //     productId: item.id ?? "",
            //       //     product: item,
            //       //     productKey: productKey,
            //       //     cartKey: cartKey,
            //       //   ),
            //       // ),
            //       // if (item.discount ?? false)
            //       //   Positioned(
            //       //     top: 0,
            //       //     left: 10,
            //       //     child: DiscountBannerWidget(
            //       //         discount:
            //       //             "${item.discountPercentage.toString()}% OFF"),
            //       //   ),
            //       // Positioned(
            //       //   top: 8,
            //       //   right: 8,
            //       //   child: LikeButton(
            //       //     onTap: (isLiked) async {
            //       //       if (isLiked) {
            //       //         homeProvider.removeFromWishlist(item.id ?? "");
            //       //         return false;
            //       //       } else {
            //       //         homeProvider.addWishlist(item);
            //       //         return true;
            //       //       }
            //       //     },
            //       //     size: 18,
            //       //     isLiked: item.isInWishlist,
            //       //     animationDuration: const Duration(milliseconds: 1000),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
