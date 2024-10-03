import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/core/constants/app_colors.dart';
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

  void _startAddToCartAnimation() {
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

  @override
  Widget build(BuildContext context) {
    AddToCartProvider addToCartProvider =
        Provider.of<AddToCartProvider>(context);
    return GestureDetector(
      onTap: () async {
        _startAddToCartAnimation();
        await addToCartProvider.addCart(widget.product);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Icon(
          Icons.add,
          color: AppColors.surface,
          size: 20,
        ),
      ),
    );
  }
}
