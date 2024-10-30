import "dart:developer";
import "package:tango/main.dart";
import "package:tango/l10n/l10n.dart";
import "package:flutter/material.dart";

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
    final String? languageCode = preferences.getString("language_code");
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

    await preferences.setString("language_code", code);
    _locale = locale;
    log(locale.languageCode);

    notifyListeners();
  }

  Future<void> clearLocale() async {
    _locale = null;
    await preferences.remove("language_code");
    notifyListeners();
  }
}
