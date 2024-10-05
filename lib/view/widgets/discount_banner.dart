import 'package:flutter/material.dart';
import 'package:tango/view/widgets/custom_painter_widgets.dart';

class DiscountBannerWidget extends StatelessWidget {
  final String discount;

  const DiscountBannerWidget({required this.discount, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(30, 35), // Specify the size of the banner
      painter: DiscountBannerPainter(discountText: discount),
    );
  }
}
