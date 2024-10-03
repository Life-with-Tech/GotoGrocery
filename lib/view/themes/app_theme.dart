import 'package:flutter/material.dart';
import 'package:tango/core/constants/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
    ),
    scaffoldBackgroundColor: AppColors.surface,
    // Additional theme customizations can go here
  );
}
