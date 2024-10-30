import 'package:flutter/material.dart';
import 'package:tango/core/constants/app_colors.dart';

class AppTheme {
  //! Light theme data
  static ThemeData lightThemeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.lightOnPrimary,
      surface: AppColors.lightSurface,
      secondary: AppColors.lightSecondary,
      onSecondary: AppColors.lightOnSecondary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightPrimary,
      iconTheme: IconThemeData(color: AppColors.white),
      toolbarTextStyle: TextStyle(color: AppColors.white),
      titleTextStyle: TextStyle(color: AppColors.white),
      // color: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.lightSurface,
    iconTheme: const IconThemeData(
      color: AppColors.lightSurface,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      elevation: 8.0,
      textStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          AppColors.lightPrimary,
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            color: AppColors.darkSurface,
          ),
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      overlayColor: WidgetStatePropertyAll(
        AppColors.white,
      ),
      thumbColor: const WidgetStatePropertyAll(
        AppColors.lightPrimary,
      ),
      trackColor: WidgetStatePropertyAll(
        AppColors.white,
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: AppColors.black,
      ),
    ),
  );

//! Dark theme data
  static ThemeData darkThemeData = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkOnPrimary,
      surface: AppColors.darkSurface,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkOnSecondary,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: AppColors.black,
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          AppColors.darkPrimary,
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            color: AppColors.darkSurface,
          ),
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.surface,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkPrimary,
      iconTheme: IconThemeData(color: AppColors.white),
      toolbarTextStyle: TextStyle(color: AppColors.white),
      titleTextStyle: TextStyle(color: AppColors.white),
    ),
    scaffoldBackgroundColor: AppColors.darkSurface,
  );
}
