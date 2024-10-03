import 'package:animated_icon/animated_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/core/constants/cached_image_widget.dart';
import 'package:tango/state/providers/add_to_cart_provider.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'add_button.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late String userId;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    userId = user?.uid ?? '';
  }

  Future<bool> checkIfFavorite(String productId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(productId)
        .get();

    return doc.exists;
  }

  void toggleFavorite(String productId, Map product, bool isFavorite) async {
    if (isFavorite) {
      await removeFromFavorites(productId);
    } else {
      await addToFavorites(productId, product);
    }
    setState(() {});
  }

  Future<void> addToFavorites(String productId, Map product) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(productId)
        .set({
      'name': product['name'],
      'price': product['price'],
      'image_url': product['image_url'],
    });
  }

  Future<void> removeFromFavorites(String productId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(productId)
        .delete();
  }

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
              Text(
                textAlign: TextAlign.center,
                "See more",
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: fullHeight(context) / 5,
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
                    return FutureBuilder<bool>(
                      future: checkIfFavorite(productId),
                      builder: (context, favoriteSnapshot) {
                        if (!favoriteSnapshot.hasData) {
                          return Container();
                        }
                        bool isFavorite = favoriteSnapshot.data!;
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          height: fullHeight(context) / 5,
                          width: fullWidth(context) / 2,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                              Positioned(
                                top: 8,
                                right: 8,
                                child: LikeButton(
                                  onTap: (isLiked) async {
                                    toggleFavorite(productId, item, isFavorite);
                                    return true;
                                  },
                                  size: 18,
                                  isLiked: isFavorite,
                                  animationDuration:
                                      const Duration(milliseconds: 1000),
                                ),

                                //  GestureDetector(
                                //   onTap: () => toggleFavorite(
                                //       productId, item, isFavorite),
                                //   child: Container(
                                //     padding: const EdgeInsets.all(5),
                                //     decoration: BoxDecoration(
                                //       color: isFavorite
                                //           ? Colors.red.withOpacity(0.3)
                                //           : Colors.grey.withOpacity(0.3),
                                //       borderRadius: BorderRadius.circular(10),
                                //     ),
                                //     child:

                                //     ),
                                //   ),
                                // ),
                              ),
                            ],
                          ),
                        );
                      },
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
