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
import 'package:tango/router/routing_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/data/models/product_model.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'package:tango/state/providers/home_provider.dart';
import 'package:tango/state/providers/theme_provider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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
      log("Snapshot: ${widget.id}");
      log("Snapshot: ${widget.categoryId}");
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
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
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection("products")
            .where("id", isEqualTo: widget.id)
            .where("category_id", isEqualTo: widget.categoryId)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            if ((snapshot.data?.docs ?? []).isEmpty) {
              return Center(child: Text('No product found.'));
            }
            ProductModel item = ProductModel.fromJson(
                snapshot.data?.docs.first.data() as Map<String, dynamic>);
            return ListView(
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
                              item.imageUrl ?? "",
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
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          }

          // Fallback for any unexpected state
          return Center(child: Text('Unexpected error occurred.'));
        },
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
