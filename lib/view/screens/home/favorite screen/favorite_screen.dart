import 'dart:developer';
import 'package:tango/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tango/core/constants/app_colors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<String> productId = [];

  @override
  void initState() {
    super.initState();
    // fetchFavoriteProductIds();
  }

  Future<void> fetchFavoriteProductIds() async {
    try {
      var userFavorites = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("favorites")
          .get();
      List<String> fetchedProductIds =
          userFavorites.docs.map((doc) => doc.id).toList();

      setState(() {
        productId = fetchedProductIds;
      });
    } catch (e) {
      log("Error fetching favorite product IDs: $e");
    }
  }

  Future<void> removeFavorite(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("favorites")
          .doc(productId)
          .delete();

      setState(() {
        this.productId.remove(productId); // Update local state
      });

      log("Removed product with ID: $productId");
    } catch (e) {
      log("Error removing favorite product: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n().getValue()!.favoriteProduct,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: productId.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("products")
                  .where(FieldPath.documentId,
                      whereIn: productId) // Use document ID
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
                        ),
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
                              removeFavorite(products[index]
                                  .id); // Remove favorite by product ID
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
            )
          : const Center(
              child: Text("No Favorite Items"),
            ),
    );
  }
}
