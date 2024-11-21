import 'dart:io';
import 'dart:developer';
import 'package:gap/gap.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tango/core/utils/price_utils.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/core/utils/date_helpers.dart';
import 'package:tango/data/models/rating_model.dart';
import 'package:tango/core/constants/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/data/models/product_model.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/state/providers/home_provider.dart';
import 'package:tango/state/providers/theme_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tango/state/providers/view_all_provider.dart';
import 'package:tango/state/providers/add_to_cart_provider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:tango/core/constants/custom_cached_network_image.dart';
import 'package:tango/view/screens/home/home%20screen/product%20add/product_add.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String id;
  final String categoryId;

  const ProductDetailsScreen({
    super.key,
    required this.id,
    required this.categoryId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await viewAllProvider.getByIdProduct(
        categoryId: widget.categoryId,
        productId: widget.id,
      );
    });
  }

  ProductModel? product;
  @override
  Widget build(BuildContext context) {
    ViewAllProvider viewAllProvider = Provider.of<ViewAllProvider>(context);
    AddToCartProvider addToCartProvider =
        Provider.of<AddToCartProvider>(context);
    product = addToCartProvider
        .idByProduct((viewAllProvider.detailsProduct?.id).toString());

    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white.withOpacity(0.7),
          ),
          child: IconButton(
            onPressed: () async {
              await Future.microtask(() {
                RoutingService().goBack();
              });
            },
            icon: Icon(
              (Platform.isAndroid)
                  ? Icons.arrow_back
                  : Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary,
            ),
          ),
        ),
        actions: [
          const Gap(5),
          InkWell(
            onTap: () async {
              // log("responseLead $image");

              String link = generateProductShareUrl(
                postId: widget.id.toString(),
                categoryId: widget.categoryId.toString(),
              );
              final imageData =
                  "https://firebasestorage.googleapis.com/v0/b/gotogrocery-15ced.appspot.com/o/products%2FGreenspoon-Kwik-Basket-Sweet-Banana-removebg-preview%20(1).png?alt=media&token=90302e0b-7574-4991-b95a-fda4fd3e0327";

              final temp = await getTemporaryDirectory();

              final path = "${temp.path}/image.jpg";
              // log(link.toString());
              final uri = Uri.parse(imageData ?? "");
              final res = await http.get(uri);
              final bytes = res.bodyBytes;
              File(path).writeAsBytesSync(bytes);
              await Share.shareXFiles(
                [XFile(path)],
                text:
                    "Take a look at this Vikash Kumar on Krishi Vikas Udyog ${link.toString()}",
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withOpacity(0.7),
              ),
              child: Icon(
                Icons.share,
                size: 22,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withOpacity(0.7),
            ),
            child: Icon(
              Icons.favorite,
              size: 22,
            ),
          ),
          const Gap(5),
        ],
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: fullWidth(context),
                height: fullHeight(context),
                alignment: Alignment.topCenter,
                child: Container(
                  alignment: Alignment.topCenter,
                  width: fullWidth(context),
                  height: fullHeight(context) / 2.2,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    // ),
                    image: DecorationImage(
                      image: NetworkImage(
                        viewAllProvider.detailsProduct?.imageUrl ?? "",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                width: fullWidth(context),
                height: fullHeight(context) / 1.7,
                decoration: BoxDecoration(
                  color:
                      themeProvider.isDark ? AppColors.black : AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              viewAllProvider.detailsProduct?.name ?? "",
                              style: TextStyle(
                                color: themeProvider.isDark
                                    ? AppColors.white
                                    : AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 2,
                            ),
                            Text(
                              '₹${viewAllProvider.detailsProduct?.price} / ${viewAllProvider.detailsProduct?.quantity} ${viewAllProvider.detailsProduct?.unit}',
                              style: TextStyle(
                                decoration:
                                    (viewAllProvider.detailsProduct?.discount ??
                                            false)
                                        ? TextDecoration.lineThrough
                                        : null,
                                fontSize:
                                    (viewAllProvider.detailsProduct?.discount ??
                                            false)
                                        ? 10
                                        : 16,
                                color:
                                    (viewAllProvider.detailsProduct?.discount ??
                                            false)
                                        ? AppColors.grey
                                        : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (viewAllProvider.detailsProduct?.discount ??
                                false)
                              Text(
                                "₹${calculateDiscountedPrice(
                                  (int.tryParse((viewAllProvider
                                                  .detailsProduct?.price)
                                              .toString()) ??
                                          0.0)
                                      .toDouble(),
                                  (int.tryParse((viewAllProvider.detailsProduct
                                                  ?.discountPercentage)
                                              .toString()) ??
                                          0.0)
                                      .toDouble(),
                                ).toStringAsFixed(0).toString()} / ${viewAllProvider.detailsProduct?.quantity} ${viewAllProvider.detailsProduct?.unit}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                        (addToCartProvider.idItemContains(
                                viewAllProvider.detailsProduct?.id ?? ""))
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.lightPrimary,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if ((int.tryParse(product!.totalQuantity
                                                    .toString()) ??
                                                0) >
                                            (int.tryParse(product!.quantity
                                                    .toString()) ??
                                                0)) {
                                          addToCartProvider.updateQuantity(
                                              product!.id!, 0);
                                        } else {
                                          addToCartProvider
                                              .removeItem(product!.id!);
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 20,
                                        height: 20,
                                        child: Icon(
                                          Icons.remove,
                                          size: 15,
                                          color: themeProvider.isDark
                                              ? AppColors.darkSurface
                                              : AppColors.lightSurface,
                                        ),
                                      ),
                                    ),
                                    const Gap(2),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 20,
                                      height: 20,
                                      child: Text(
                                        ((int.tryParse(product!.totalQuantity
                                                        .toString()) ??
                                                    0) /
                                                (int.tryParse(product!.quantity
                                                        .toString()) ??
                                                    0))
                                            .toStringAsFixed(0),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: themeProvider.isDark
                                              ? AppColors.darkSurface
                                              : AppColors.lightSurface,
                                        ),
                                      ),
                                    ),
                                    const Gap(2),
                                    InkWell(
                                      onTap: () {
                                        addToCartProvider.updateQuantity(
                                            product!.id!, 1);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 20,
                                        height: 20,
                                        child: Icon(
                                          Icons.add,
                                          size: 15,
                                          color: themeProvider.isDark
                                              ? AppColors.darkSurface
                                              : AppColors.lightSurface,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  await addToCartProvider
                                      .addCart(viewAllProvider.detailsProduct!);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightPrimary,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    "Add\nTo\nCart",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    if (viewAllProvider.detailsProduct?.description != null)
                      const Gap(10),
                    if (viewAllProvider.detailsProduct?.description != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                            color: themeProvider.isDark
                                ? AppColors.white.withOpacity(0.3)
                                : AppColors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 16,
                                color: themeProvider.isDark
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              (viewAllProvider.detailsProduct?.description)
                                  .toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: themeProvider.isDark
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const Gap(20),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: themeProvider.isDark
                            ? AppColors.white.withOpacity(0.3)
                            : AppColors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SwitchListTile(
                            title: Text("In Stock"),
                            value: viewAllProvider.detailsProduct?.inStock ??
                                false,
                            onChanged: (value) {},
                          ),
                          SwitchListTile(
                            title: Text("Discount"),
                            value: viewAllProvider.detailsProduct?.discount ??
                                false,
                            onChanged: (value) {},
                          ),
                          SwitchListTile(
                            title: Text("In Organic"),
                            value: viewAllProvider.detailsProduct?.isOrganic ??
                                false,
                            onChanged: (value) {},
                          ),
                          SwitchListTile(
                            title: Text("In Sale"),
                            value:
                                viewAllProvider.detailsProduct?.onSale ?? false,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          color: themeProvider.isDark
                              ? AppColors.white.withOpacity(0.3)
                              : AppColors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ratings & Reviews",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: themeProvider.isDark
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  RoutingService().pushNamed(
                                    Routes.rateProductScreen.name,
                                    queryParameters: {
                                      "product_id":
                                          viewAllProvider.detailsProduct?.id,
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(52),
                                    color: themeProvider.isDark
                                        ? AppColors.white.withOpacity(0.3)
                                        : AppColors.black.withOpacity(0.3),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    "Rate Product",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Gap(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RatingBarIndicator(
                                rating:
                                    viewAllProvider.calculateAverageRating(),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: AppColors.primary,
                                ),
                                itemCount: 5,
                                itemSize: 15,
                                direction: Axis.horizontal,
                              ),
                              const Gap(20),
                              Text(
                                "${(viewAllProvider.ratingProduct ?? []).length.toString()} rating & review",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: themeProvider.isDark
                                      ? AppColors.white.withOpacity(0.3)
                                      : AppColors.black.withOpacity(0.3),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          if (viewAllProvider.ratingProduct != [])
                            Column(
                              children: List.generate(
                                (viewAllProvider.ratingProduct ?? []).length,
                                (generator) {
                                  RatingModel rating =
                                      (viewAllProvider.ratingProduct ??
                                          [])[generator];
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: themeProvider.isDark
                                            ? AppColors.white.withOpacity(0.3)
                                            : AppColors.black.withOpacity(0.3),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 10,
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.person,
                                                    size: 15,
                                                    color: themeProvider.isDark
                                                        ? AppColors.white
                                                        : AppColors.black,
                                                  ),
                                                  Text(
                                                    (rating.userName ?? "")
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          themeProvider.isDark
                                                              ? AppColors.white
                                                              : AppColors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                rating.review ?? "",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: themeProvider.isDark
                                                      ? AppColors.white
                                                      : AppColors.black,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                maxLines: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Gap(10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            RatingBarIndicator(
                                              rating: double.tryParse(rating
                                                      .rating
                                                      .toString()) ??
                                                  0.0,
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                Icons.star,
                                                color: AppColors.primary,
                                              ),
                                              unratedColor: themeProvider.isDark
                                                  ? AppColors.white
                                                  : AppColors.grey,
                                              itemCount: 5,
                                              itemSize: 15,
                                              direction: Axis.horizontal,
                                            ),
                                            Text(
                                              DateHelpers.formatDate(rating
                                                      .createdAt ??
                                                  DateTime.now().toString()),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: themeProvider.isDark
                                                    ? AppColors.white
                                                    : AppColors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                        ],
                      ),
                    ),
                    const Gap(20),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          color: themeProvider.isDark
                              ? AppColors.white.withOpacity(0.3)
                              : AppColors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contact",
                            style: TextStyle(
                              fontSize: 14,
                              color: themeProvider.isDark
                                  ? AppColors.white
                                  : AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(10),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: themeProvider.isDark
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            ),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: CustomCachedNetworkImage(
                                    imageUrl:
                                        viewAllProvider.userData?.image ?? "",
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        (viewAllProvider.userData?.name ?? "")
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: themeProvider.isDark
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        viewAllProvider.userData?.email ?? "",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: themeProvider.isDark
                                              ? AppColors.white
                                              : AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(10),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: themeProvider.isDark
                                      ? AppColors.white
                                      : AppColors.black,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String generateProductShareUrl({
    required String postId,
    required String categoryId,
  }) {
    String url = "https://indiangrocery.com/product_details_screen/";

    url += "?post_id=$postId";

    url += "&category_id=$categoryId";

    return url;

    // final DynamicLinkParameters parameters = DynamicLinkParameters(
    //   //!/RtQw
    //   uriPrefix:
    //       'https://gotogrocery.page.link',
    //   link: Uri.parse(
    //     'https://yourapp.com/product_details_screen?post_id=$postId&category_id=$categoryId',
    //   ),
    //   androidParameters: AndroidParameters(
    //     packageName:
    //         'com.example.gotogrocery',
    //   ),
    //   iosParameters: IOSParameters(
    //     bundleId: 'com.example.gotogrocery',
    //   ),
    // );

    // final ShortDynamicLink dynamicLink =
    //     await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    // return dynamicLink.shortUrl.toString();
  }
}
