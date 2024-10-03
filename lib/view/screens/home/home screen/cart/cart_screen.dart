import 'dart:developer';
import 'package:tango/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/state/providers/add_to_cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AddToCartProvider cartProvider = Provider.of<AddToCartProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        await Future.microtask(() {
          RoutingService().goName(
            Routes.home.name,
          );
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              await Future.microtask(() {
                RoutingService().goName(
                  Routes.home.name,
                );
              });
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: AppColors.surface,
            ),
          ),
          title: Text(
            L10n().getValue()!.cart,
            style: TextStyle(
              color: AppColors.surface,
              fontSize: 18,
            ),
          ),
        ),
        body: cartProvider.cart.isNotEmpty
            ? ListView.builder(
                itemCount: cartProvider.cart.length,
                itemBuilder: (context, index) {
                  final item = cartProvider.cart[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item["image_url"],
                              width: 70,
                              height: 70,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                              width: 16), // Spacing between image and text
                          // Product Details (Name, Price)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["name"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        4), // Spacing between name and price
                                Text(
                                  '₹${item["price"].toString()} / ${item["quantity"]} ${item["unit"]}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Quantity Adjustments
                          Row(
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.remove, color: Colors.red),
                                onPressed: () {
                                  if ((int.tryParse(item["total_quantity"]
                                              .toString()) ??
                                          0) >
                                      (int.tryParse(
                                              item["quantity"].toString()) ??
                                          0)) {
                                    addToCartProvider.updateQuantity(
                                        item["id"], 0);
                                  } else {
                                    cartProvider.removeItem(item["id"]);
                                  }
                                },
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  ((int.tryParse(item["total_quantity"]
                                                  .toString()) ??
                                              0) /
                                          (int.tryParse(item["quantity"]
                                                  .toString()) ??
                                              0))
                                      .toStringAsFixed(0),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.add, color: Colors.green),
                                onPressed: () {
                                  addToCartProvider.updateQuantity(
                                      item["id"], 1);
                                },
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              cartProvider.removeItem(item["id"]);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text("Your cart is empty."),
              ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: ₹${cartProvider.totalAmount.toString()} ',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Checkout"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
