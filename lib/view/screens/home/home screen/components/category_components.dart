import 'add_button.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:like_button/like_button.dart';
import 'package:animated_icon/animated_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tango/core/utils/price_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'package:tango/view/widgets/discount_banner.dart';
import 'package:tango/core/constants/cached_image_widget.dart';
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
  Widget build(BuildContext context) {
    AddToCartProvider addToCartProvider = Provider.of(context);
    GlobalKey cartKey = addToCartProvider.cartKey;

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
        StreamBuilder(
          stream: (widget.whereCondition != null)
              ? FirebaseFirestore.instance
                  .collection("products")
                  .where("category", isEqualTo: widget.whereCondition)
                  .snapshots()
              : FirebaseFirestore.instance.collection("products").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: fullHeight(context) / 3.6,
                child: ListView.builder(
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
                        horizontal: 10,
                        vertical: 10,
                      ),
                      width: fullWidth(context) / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.primary,
                        ),
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
                                      maxLines: 1,
                                      style: const TextStyle(
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
                                            color: AppColors.primary
                                                .withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                (double.tryParse(item['rating']
                                                            .toString()) ??
                                                        0.0.toInt())
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const Gap(3),
                                              Icon(
                                                Icons.star,
                                                size: 15,
                                                color: AppColors.primary,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Gap(5),
                                        Text(
                                          "${item['user_rating']} Ratings",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(5),
                                    Text(
                                      '₹${item['price']} / ${item['quantity']} ${item['unit']}',
                                      style: TextStyle(
                                        decoration: (item['discount'])
                                            ? TextDecoration.lineThrough
                                            : null,
                                        fontSize: (item['discount']) ? 10 : 16,
                                        color: (item['discount'])
                                            ? AppColors.grey
                                            : Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (item['discount'])
                                      Text(
                                        "₹${calculateDiscountedPrice(
                                          (int.tryParse(item['price']
                                                      .toString()) ??
                                                  0.0)
                                              .toDouble(),
                                          (int.tryParse(item[
                                                          'discount_percentage']
                                                      .toString()) ??
                                                  0.0)
                                              .toDouble(),
                                        ).toStringAsFixed(0).toString()} / ${item['quantity']} ${item['unit']}",
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
                              productKey: productKey,
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
                ),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}
