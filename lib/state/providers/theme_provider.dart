import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tango/data/local/user_local.dart';
import 'package:tango/router/routing_service.dart';

ThemeProvider themeProvider = ThemeProvider();

class ThemeProvider extends ChangeNotifier {
  ThemeMode thememode = ThemeMode.system;

  ThemeMode get themeMode => thememode;

  bool isdark = false;
  bool get isDark => isdark;

  void toggleThemeMode(bool? theme) async {
    log(theme.toString());
    if (theme != null) {
      log("${theme}not null");
      if (theme) {
        thememode = ThemeMode.dark;
        isdark = true;
        setThemeData(true);
      } else {
        thememode = ThemeMode.light;
        isdark = false;
        setThemeData(false);
      }
    } else {
      bool isDarkMode =
          SchedulerBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark;
      thememode = (isDarkMode) ? ThemeMode.dark : ThemeMode.light;
      isdark = (isDarkMode) ? true : false;
      setThemeData((isDarkMode) ? true : false);
    }
    notifyListeners();
  }
}
