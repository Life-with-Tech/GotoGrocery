import "dart:developer";
import "package:tango/l10n/l10n.dart";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

AppDataProvider appDataProvider = AppDataProvider();

class AppDataProvider extends ChangeNotifier {
  int _index = 0;
  int get index => _index;
  void updatedIndex({required int index}) async {
    _index = index;
    notifyListeners();
  }

  Locale? _locale;
  Locale? get locale => _locale;

  Future<void> loadSavedLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString("language_code");
    if (languageCode != null) {
      _locale = L10n().getLocale(languageCode);
    } else {
      _locale = L10n().getLocale("en");
    }
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    final String? code = L10n().getCodeFromLocale(locale);
    log(code.toString());
    if (code == null) {
      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language_code", code);
    _locale = locale;
    log(locale.languageCode);

    notifyListeners();
  }

  Future<void> clearLocale() async {
    _locale = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("language_code");
    notifyListeners();
  }
}
