import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/router/routing_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/state/providers/add_to_cart_provider.dart';
import 'package:tango/view/screens/home/home%20screen/components/banner.dart';
import 'package:tango/view/screens/home/home%20screen/components/categaory.dart';
import 'package:tango/view/screens/home/home%20screen/components/category_components.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AddToCartProvider addToCartProvider =
        Provider.of<AddToCartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          color: AppColors.secondary,
          "assets/icons/Untitled_design-removebg-preview.png",
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
          height: 100,
          width: 100,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chat, color: AppColors.surface),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: addToCartProvider.cartKey,
        backgroundColor: AppColors.primary,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Icon(
                Icons.shopping_cart,
                color: AppColors.surface,
                size: 28,
              ),
            ),
            if (addToCartProvider.cart.isNotEmpty)
              Positioned(
                right: -5,
                top: -5,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _formatNumber(addToCartProvider.cart.length),
                      style: TextStyle(
                        color: AppColors.surface,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        ),
        onPressed: () async {
          await Future.microtask(() {
            RoutingService().pushNamed(
              Routes.cart.name,
            );
          });
        },
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        children: const [
          BannerHome(),
          Gap(10),
          Categaory(),
          Gap(10),
          ProductItem(),
        ],
      ),
    );
  }

  String _formatNumber(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M+';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K+';
    } else {
      return count.toString();
    }
  }
}
