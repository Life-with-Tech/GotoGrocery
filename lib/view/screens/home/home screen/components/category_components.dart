import 'add_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:like_button/like_button.dart';
import 'package:animated_icon/animated_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'package:tango/view/widgets/discount_banner.dart';
import 'package:tango/core/constants/cached_image_widget.dart';
import 'package:tango/state/providers/add_to_cart_provider.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    AddToCartProvider addToCartProvider = Provider.of(context);
    GlobalKey cartKey = addToCartProvider.cartKey;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                textAlign: TextAlign.center,
                "You might need",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: AppColors.onPrimary,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: AppColors.primary,
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.onPrimary,
                  size: 15,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: fullHeight(context) / 4,
          width: fullWidth(context),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("products").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item = snapshot.data?.docs[index]
                        .data() as Map<String, dynamic>;
                    String productId = snapshot.data?.docs[index].id ?? '';
                    GlobalKey productKey = GlobalKey();
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: fullHeight(context) / 5,
                      width: fullWidth(context) / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedImageWidget(
                                key: productKey,
                                imageUrl: item['image_url'],
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '₹${item['price']} / ${item['quantity']} ${item['unit']}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '₹${((int.tryParse(item['price']) ?? 0) * (int.tryParse(item['discount_percentage']) ?? 0) / 100).toStringAsFixed(0)}',
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
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: AddButton(
                              productId: productId,
                              product: item,
                              productKey:
                                  productKey, // Use the unique productKey here
                              cartKey: cartKey,
                            ),
                          ),
                          if (item['discount'])
                            Positioned(
                              top: 0,
                              left: 10,
                              child: DiscountBannerWidget(
                                  discount:
                                      "${item['discount_percentage'].toString()}% OFF"),
                            ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: LikeButton(
                              onTap: (isLiked) async {
                                // toggleFavorite(productId, item, isFavorite);
                                return true;
                              },
                              size: 18,
                              // isLiked: isFavorite,
                              animationDuration:
                                  const Duration(milliseconds: 1000),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
