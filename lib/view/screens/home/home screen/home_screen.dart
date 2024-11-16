import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:tango/router/routing_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/state/providers/theme_provider.dart';
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
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n().getValue()!.app_title,
          maxLines: 1,
          style: TextStyle(
            color: AppColors.white,
            overflow: TextOverflow.ellipsis,
            fontSize: 20,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.chat,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: addToCartProvider.cartKey,
        backgroundColor: AppColors.lightPrimary,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Icon(
                Icons.shopping_cart,
                color: themeProvider.isDark ? AppColors.white : AppColors.white,
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
                      style: const TextStyle(
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
          // Gap(10),
          // ProductItem(
          //   whereCondition: "Fruits",
          // ),
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
