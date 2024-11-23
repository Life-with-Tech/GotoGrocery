import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tango/router/routing_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tango/data/models/product_model.dart';
import 'package:tango/core/constants/data_loding.dart';
import 'package:tango/state/providers/user_provider.dart';

HomeProvider homeProvider = HomeProvider();

class HomeProvider extends ChangeNotifier {
  List<ProductModel> productList = [];
  List<ProductModel> get product => productList;
  Future getProduct() async {
    FirebaseFirestore.instance
        .collection("products")
        .snapshots()
        .listen((onData) {
      productList =
          onData.docs.map((doc) => ProductModel.fromJson(doc.data())).toList();

      FirebaseFirestore.instance
          .collection('wishlists')
          .doc(userProvider.currentUser?.uid)
          .collection('items')
          .snapshots()
          .listen((snapshot) {
        final wishlistProductIds = snapshot.docs.map((doc) => doc.id).toSet();
        for (var product in productList) {
          product.isInWishlist = wishlistProductIds.contains(product.id);
        }
        notifyListeners();
      }).onError((handleError) {
        log(handleError.toString());
      });
    }).onError((handleError) {
      log(handleError.toString());
    });
  }

  Future addWishlist(ProductModel productModel) async {
    final wishlistRef = FirebaseFirestore.instance
        .collection('wishlists')
        .doc(userProvider.currentUser?.uid)
        .collection('items')
        .doc(productModel.id);

    await wishlistRef.set(productModel.toJson());
    final index = productList.indexWhere((item) => item.id == productModel.id);
    if (index != -1) {
      productList[index].isInWishlist = true;
    }
    notifyListeners();
  }

  Future<void> removeFromWishlist(String productId) async {
    final wishlistRef = FirebaseFirestore.instance
        .collection('wishlists')
        .doc(userProvider.currentUser?.uid)
        .collection('items')
        .doc(productId);

    await wishlistRef.delete();
    final index = productList.indexWhere((item) => item.id == productId);
    if (index != -1) {
      productList[index].isInWishlist = false;
    }
    notifyListeners();
  }
}
