import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tango/data/models/user_model.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/core/utils/date_helpers.dart';
import 'package:tango/data/models/rating_model.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tango/data/models/product_model.dart';
import 'package:tango/core/constants/data_loding.dart';
import 'package:tango/state/providers/user_provider.dart';

ViewAllProvider viewAllProvider = ViewAllProvider();

class ViewAllProvider extends ChangeNotifier {
  List<ProductModel> _product = [];
  ProductModel? _detailsProduct;
  UserModel? _userData;
  List<RatingModel> _ratingProduct = [];
  List<ProductModel> get product => _product;
  List<RatingModel> get ratingProduct => _ratingProduct;
  UserModel? get userData => _userData;
  ProductModel? get detailsProduct => _detailsProduct;

  Future getByIdProduct({
    required String categoryId,
    required String productId,
  }) async {
    GlobalLoading.showLoadingDialog();
    await FirebaseFirestore.instance
        .collection("products")
        .where("id", isEqualTo: productId)
        .where("category_id", isEqualTo: categoryId)
        .get()
        .then((onValue) async {
      if ((onValue.docs).isNotEmpty) {
        _detailsProduct = ProductModel.fromJson(onValue.docs.first.data());
        await FirebaseFirestore.instance
            .collection('wishlists')
            .doc(userProvider.currentUser?.uid)
            .collection('items')
            .where("id", isEqualTo: onValue.docs.first.data()["id"])
            .get()
            .then((onValue) {
          final wishlistProductIds = onValue.docs.map((doc) => doc.id).toSet();

          _detailsProduct?.isInWishlist =
              wishlistProductIds.contains(_detailsProduct?.id);
        }).catchError((onError) {
          log("Error by getIdByUser ${onError.toString()}");
        });
        try {
          await getIdByUser(
              userId: (onValue.docs.first["post_user_id"]).toString());
        } catch (e) {
          log("Error by getIdByUser ${e.toString()}");
        }
        try {
          await getIdByProductRating(
              productId: (onValue.docs.first.data()["id"]).toString());
        } catch (e) {
          log("getIdByProductRating ${e.toString()}");
        }
      } else {
        _detailsProduct = null;
      }
    }).catchError((onError) {
      log("onError${onError.toString()}");
    });
    notifyListeners();
    RoutingService().goBack();
  }

  Future getIdByUser({required String userId}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: userId)
        .get()
        .then((onValue) {
      if ((onValue.docs).isNotEmpty) {
        _userData = UserModel.fromJson(onValue.docs.first.data());
      } else {
        _userData = null;
      }
    }).catchError((onError) {
      log("onError getIdByUser${onError.toString()}");
    });
    notifyListeners();
  }

  Future getIdByProductRating({required String productId}) async {
    await FirebaseFirestore.instance
        .collection("product_ratings")
        .where("product_id", isEqualTo: productId)
        .get()
        .then((onValue) {
      if ((onValue.docs).isNotEmpty) {
        log("if");
        _ratingProduct = onValue.docs
            .map((doc) => RatingModel.fromJson(doc.data()))
            .toList();
      } else {
        log("else");
        _ratingProduct = [];
      }
    }).catchError((onError) {
      log("onError getIdByProductRating${onError.toString()}");
    });
    notifyListeners();

    log((ratingProduct).length.toString());
  }

  double calculateAverageRating() {
    if ((ratingProduct).isEmpty) return 0.0;
    final total = (ratingProduct).fold(
        0.0,
        (sum, rating) =>
            sum + (double.tryParse((rating.rating).toString()) ?? 0.0));
    return total / (ratingProduct).length;
  }

  Future<int> setRatingAndReview({
    required String productId,
    required String rating,
    required String review,
  }) async {
    GlobalLoading.showLoadingDialog();
    String uid = DateHelpers.generateUID();
    return await FirebaseFirestore.instance
        .collection("product_ratings")
        .doc(uid)
        .set({
      "id": uid,
      "user_id": userProvider.currentUser?.uid ?? "",
      "user_name": userProvider.currentUser?.name ?? "",
      "created_at": DateTime.now().toString(),
      "product_id": productId,
      "rating": rating,
      "review": review,
    }).then((onValue) async {
      Fluttertoast.showToast(
        msg: "Thank you for your review!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.primary,
        textColor: AppColors.white,
      );
      await getIdByProductRating(productId: productId);
      RoutingService().goBack();

      return 1;
    }).catchError((onError) {
      RoutingService().goBack();

      return 0;
    });
  }

  Future getProduct() async {
    GlobalLoading.showLoadingDialog();
    await FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((onValue) async {
      if ((onValue.docs).isNotEmpty) {
        _product = onValue.docs
            .map((doc) => ProductModel.fromJson(doc.data()))
            .toList();

        await FirebaseFirestore.instance
            .collection('wishlists')
            .doc(userProvider.currentUser?.uid)
            .collection('items')
            .get()
            .then((onValue) {
          final wishlistProductIds = onValue.docs.map((doc) => doc.id).toSet();
          for (var item in product) {
            item.isInWishlist = wishlistProductIds.contains(item.id);
          }
          notifyListeners();
        }).catchError((onError) {
          log("wishlists${onError.toString()}");
        });
        await FirebaseFirestore.instance
            .collection('product_ratings')
            .get()
            .then((onValue) {
          final ratingProduct = onValue.docs
              .map((doc) => RatingModel.fromJson(doc.data()))
              .toList();
          for (var item in product) {
            final productRatings = ratingProduct
                .where((rating) => rating.productId == item.id)
                .toList();

            if (productRatings.isNotEmpty) {
              final total = productRatings.fold(
                  0.0,
                  (sum, rating) =>
                      sum +
                      (double.tryParse((rating.rating).toString()) ?? 0.0));
              item.rating = (total / productRatings.length).toStringAsFixed(1);
            } else {
              item.rating = "0.0";
            }
          }
        }).catchError((onError) {
          log("Error fetching product ratings: ${onError.toString()}");
        });
      } else {
        _product = [];
      }
    }).catchError((onError) {
      log("onError${onError.toString()}");
    });
    notifyListeners();
    RoutingService().goBack();
  }

  Future addWishlist(ProductModel productModel) async {
    final wishlistRef = FirebaseFirestore.instance
        .collection('wishlists')
        .doc(userProvider.currentUser?.uid)
        .collection('items')
        .doc(productModel.id);

    await wishlistRef.set(productModel.toJson());
    final index = product.indexWhere((item) => item.id == productModel.id);
    if (index != -1) {
      product[index].isInWishlist = true;
      _detailsProduct?.isInWishlist = true;
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
    final index = product.indexWhere((item) => item.id == productId);
    if (index != -1) {
      product[index].isInWishlist = false;
      _detailsProduct?.isInWishlist = false;
    }
    notifyListeners();
  }
}
