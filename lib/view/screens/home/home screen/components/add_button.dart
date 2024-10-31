import 'dart:developer';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'package:tango/state/providers/theme_provider.dart';
import 'package:tango/core/constants/cached_image_widget.dart';
import 'package:tango/state/providers/add_to_cart_provider.dart';

class AddButton extends StatefulWidget {
  final String productId;
  final Map<String, dynamic> product;
  final GlobalKey productKey;
  final GlobalKey cartKey;

  const AddButton({
    required this.productId,
    required this.product,
    required this.productKey,
    required this.cartKey,
    Key? key,
  }) : super(key: key);

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _isAnimating = false;
  Map<String, dynamic>? product;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void addToCartAnimation() {
    if (_isAnimating) return;

    if (widget.productKey.currentContext == null) {
      log("Product key context is null. Cannot find product render box.");
      return;
    }

    RenderBox productBox =
        widget.productKey.currentContext!.findRenderObject() as RenderBox;
    Offset productPosition = productBox.localToGlobal(Offset.zero);

    if (widget.cartKey.currentContext == null) {
      log("Cart key context is null. Cannot find cart render box.");
      return;
    }

    RenderBox cartBox =
        widget.cartKey.currentContext!.findRenderObject() as RenderBox;
    Offset cartPosition = cartBox.localToGlobal(Offset.zero);

    final OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    Animation<double> sizeAnimation =
        Tween<double>(begin: 100.0, end: 50.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    Animation<double> opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    overlayEntry = OverlayEntry(
      builder: (context) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            Offset currentPosition = Offset.lerp(
              productPosition,
              cartPosition,
              _controller.value,
            )!;

            return Positioned(
              top: currentPosition.dy,
              left: currentPosition.dx,
              child: Opacity(
                opacity: opacityAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: CachedImageWidget(
                    imageUrl: widget.product['image_url'],
                    height: sizeAnimation.value,
                    width: sizeAnimation.value,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    overlayState.insert(overlayEntry);
    _isAnimating = true;
    _controller.forward(from: 0).then((_) {
      overlayEntry.remove();
      _isAnimating = false;
    });
  }

  void removeFromCartAnimation() {
    if (_isAnimating) return;

    if (widget.cartKey.currentContext == null) {
      log("Cart key context is null. Cannot find cart render box.");
      return;
    }

    RenderBox cartBox =
        widget.cartKey.currentContext!.findRenderObject() as RenderBox;
    Offset cartPosition = cartBox.localToGlobal(Offset.zero);

    if (widget.productKey.currentContext == null) {
      log("Product key context is null. Cannot find product render box.");
      return;
    }

    RenderBox productBox =
        widget.productKey.currentContext!.findRenderObject() as RenderBox;
    Offset productPosition = productBox.localToGlobal(Offset.zero);

    final OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    // Updated size animation to increase size during reverse animation
    Animation<double> sizeAnimation =
        Tween<double>(begin: 100.0, end: 25.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    Animation<double> opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    overlayEntry = OverlayEntry(
      builder: (context) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            Offset currentPosition = Offset.lerp(
              productPosition,
              cartPosition,
              _controller.value,
            )!;

            return Positioned(
              top: currentPosition.dy,
              left: currentPosition.dx,
              child: Opacity(
                opacity: opacityAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: CachedImageWidget(
                    imageUrl: widget.product['image_url'],
                    height: sizeAnimation.value,
                    width: sizeAnimation.value,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    overlayState.insert(overlayEntry);
    _isAnimating = true;
    _controller.reverse(from: 1).then((_) {
      overlayEntry.remove();
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AddToCartProvider addToCartProvider =
        Provider.of<AddToCartProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    product = addToCartProvider.idByProduct(widget.product["id"]);
    return (addToCartProvider.idItemContains(widget.product["id"]))
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              color: themeProvider.isDark
                  ? AppColors.darkPrimary
                  : AppColors.lightPrimary,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    removeFromCartAnimation();
                    if ((int.tryParse(product!["total_quantity"].toString()) ??
                            0) >
                        (int.tryParse(product!["quantity"].toString()) ?? 0)) {
                      addToCartProvider.updateQuantity(product!["id"], 0);
                    } else {
                      addToCartProvider.removeItem(product!["id"]);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                    child: Icon(
                      Icons.remove,
                      size: 15,
                      color: themeProvider.isDark
                          ? AppColors.darkSurface
                          : AppColors.lightSurface,
                    ),
                  ),
                ),
                const Gap(2),
                Container(
                  alignment: Alignment.center,
                  width: 20,
                  height: 20,
                  child: Text(
                    ((int.tryParse(product!["total_quantity"].toString()) ??
                                0) /
                            (int.tryParse(product!["quantity"].toString()) ??
                                0))
                        .toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 16,
                      color: themeProvider.isDark
                          ? AppColors.darkSurface
                          : AppColors.lightSurface,
                    ),
                  ),
                ),
                const Gap(2),
                InkWell(
                  onTap: () {
                    addToCartAnimation();
                    addToCartProvider.updateQuantity(product!["id"], 1);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                    child: Icon(
                      Icons.add,
                      size: 15,
                      color: themeProvider.isDark
                          ? AppColors.darkSurface
                          : AppColors.lightSurface,
                    ),
                  ),
                ),
              ],
            ),
          )
        : GestureDetector(
            onTap: () async {
              addToCartAnimation();
              await addToCartProvider.addCart(widget.product);
            },
            child: Container(
              width: 30,
              height: 30,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: themeProvider.isDark
                    ? AppColors.darkPrimary
                    : AppColors.lightPrimary,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: Icon(
                Icons.add,
                color: themeProvider.isDark
                    ? AppColors.darkSurface
                    : AppColors.lightSurface,
                size: 20,
              ),
            ),
          );
  }
}
