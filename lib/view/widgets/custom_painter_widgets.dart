import 'package:flutter/material.dart';
import 'package:tango/core/constants/app_colors.dart';

class DiscountBannerPainter extends CustomPainter {
  final String discountText;

  DiscountBannerPainter({required this.discountText});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 2, size.height / 1.2);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
    final textPainter = TextPainter(
      text: TextSpan(
        text: discountText,
        style: TextStyle(
          color: AppColors.surface,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 2,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final offset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
