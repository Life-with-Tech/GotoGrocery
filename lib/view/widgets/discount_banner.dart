import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/state/providers/theme_provider.dart';
import 'package:tango/view/widgets/custom_painter_widgets.dart';

class DiscountBannerWidget extends StatelessWidget {
  final String discount;

  const DiscountBannerWidget({required this.discount, super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return CustomPaint(
      size: const Size(30, 35), // Specify the size of the banner
      painter: DiscountBannerPainter(
        discountText: discount,
        discountColor: themeProvider.isDark
            ? AppColors.lightPrimary
            : AppColors.darkPrimary,
      ),
    );
  }
}
