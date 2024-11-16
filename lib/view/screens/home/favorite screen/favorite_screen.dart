import 'dart:developer';
import 'package:provider/provider.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tango/state/providers/home_provider.dart';
import 'package:tango/state/providers/theme_provider.dart';
import 'package:tango/state/providers/user_provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            L10n().getValue()!.favoriteProduct,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('wishlists')
              .doc(userProvider.currentUser?.uid)
              .collection('items') // Use document ID
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var products = snapshot.data!.docs;

              log("Fetched Products: ${products.length}"); // Log the number of products

              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> product =
                      products[index].data() as Map<String, dynamic>;

                  log("Product ID: ${products[index].id}, Data: $product"); // Log individual product details

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: themeProvider.isDark
                              ? AppColors.white
                              : AppColors.black,
                        )),
                    child: ListTile(
                      leading: Image.network(
                        product['image_url'],
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        product['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        '₹${product['price']}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          homeProvider.removeFromWishlist(product["id"]);
                          // Remove favorite by product ID
                        },
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return const Center(
              child: Text("No Favorite Items"),
            );
          },
        ));
  }
}
