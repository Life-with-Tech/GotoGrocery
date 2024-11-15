import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tango/data/models/product_model.dart';
import 'package:tango/core/utils/price_utils.dart';

AddToCartProvider addToCartProvider = AddToCartProvider();

class AddToCartProvider extends ChangeNotifier {
  final GlobalKey _cartKey = GlobalKey();
  GlobalKey get cartKey => _cartKey;
  List<ProductModel> _cart = [];
  List<ProductModel> get cart => _cart;
  void addCartvalue(dynamic value) {
    _cart.add(value);
    notifyListeners();
  }

  Future addCart(ProductModel value) async {
    int cartIndex = -1;

    try {
      cartIndex = cart.indexWhere((cartItem) => cartItem.id == value.id);
    } catch (e) {
      cartIndex = -1;
    }
    log("cartIndex$cartIndex");
    if (cartIndex >= 0) {
      int newQuantity =
          (int.tryParse(cart[cartIndex].totalQuantity.toString()) ?? 0) +
              (int.tryParse(cart[cartIndex].quantity.toString()) ?? 0);

      cart[cartIndex].totalQuantity = int.tryParse(newQuantity.toString());
    } else {
      log("Adding new item to cart");
      value.totalQuantity = int.tryParse(value.quantity.toString());
      _cart.add(value);
    }
    notifyListeners();

    log("cart${cart.toString()}");
  }

  void removeItem(String id) {
    _cart.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  double get totalAmount {
    return _cart.fold(0.0, (sum, item) {
      double price = double.tryParse(item.price.toString()) ?? 0.0;
      int quantity = int.tryParse(item.totalQuantity.toString()) ?? 0;
      return sum +
          (price / (int.tryParse(item.quantity.toString()) ?? 0) * quantity);
    });
  }

  double cartPrice(Map product) {
    if (product['discount']) {
      return calculateDiscountedPrice(
        (int.tryParse(product['price'].toString()) ?? 0.0).toDouble(),
        (int.tryParse(product['discount_percentage'].toString()) ?? 0.0)
            .toDouble(),
      );
    } else {
      return (int.tryParse(product['price'].toString()) ?? 0.0).toDouble();
    }
  }

  bool idItemContains(String id) {
    return _cart
        .any((item) => item.id == id); // Assuming item has an 'id' field
  }

  void updateQuantity(String id, int status) {
    ProductModel item = _cart.firstWhere((item) => item.id == id);
    if (item != null) {
      if (status == 1) {
        item.totalQuantity = (int.tryParse(item.quantity.toString()) ?? 0) +
            (int.tryParse(item.totalQuantity.toString()) ?? 0);
      } else {
        item.totalQuantity =
            (int.tryParse(item.totalQuantity.toString()) ?? 0) -
                (int.tryParse(item.quantity.toString()) ?? 0);
      }

      notifyListeners();
    }
  }

  ProductModel? idByProduct(String id) {
    ProductModel? product;
    try {
      product = cart.firstWhere((e) => e.id == id);
    } catch (e) {
      log("message$e");
    }
    return product;
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
