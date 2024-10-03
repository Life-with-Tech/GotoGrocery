import "dart:ui";
import "package:tango/router/routing_service.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class L10n {
  final List<Map<String, Object>> all = [
    {"id": 1, "value": "en"},
    {"id": 2, "value": "hi"},
    {"id": 3, "value": "bn"},
  ];

  String getLangcode(String code) {
    switch (code) {
      case "en":
        return "English";
      case "hi":
        return "Hindi";
      case "bn":
        return "Bengali";
      default:
        return "English";
    }
  }

  Locale getLocale(String code) => Locale(code);

  AppLocalizations? getValue() =>
      AppLocalizations.of(RoutingService.navigatorKey.currentContext!);

  String? getCodeFromLocale(Locale locale) => all.firstWhere(
        (map) => map["value"] == locale.languageCode,
        orElse: () => {"id": 1, "value": "en"},
      )["value"] as String?;
}
