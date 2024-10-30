import 'package:flutter/material.dart';
import 'package:tango/data/local/user_local.dart';

ThemeProvider themeProvider = ThemeProvider();

class ThemeProvider extends ChangeNotifier {
  ThemeMode thememode = ThemeMode.system;

  ThemeMode get themeMode => thememode;

  bool isdark = false;
  bool get isDark => isdark;

  void toggleThemeMode(bool theme) async {
    if (theme) {
      thememode = ThemeMode.light;
      isdark = true;
      setThemeData(true);
    } else {
      thememode = ThemeMode.dark;
      isdark = false;
      setThemeData(false);
    }
    notifyListeners();
  }
}
