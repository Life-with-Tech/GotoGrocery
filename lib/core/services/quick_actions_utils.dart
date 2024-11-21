import "dart:developer";
import "package:quick_actions/quick_actions.dart";
import "package:tango/core/constants/global.dart";
import "package:tango/router/routing_service.dart";
// import "package:get/get_utils/src/platform/platform.dart";
// ignore_for_file: avoid_print

class QuickActionsUtils {
  QuickActionsUtils._();
  static const _quickActions = QuickActions();
  static Future<void> init() async {
    await _quickActions.initialize((shortcutType) async {
      // on quick action click
      // Perform your logic here on action click

      final shortcut = actionList.firstWhere(
        (element) => element.id == shortcutType,
        orElse: () => actionList.first,
      );

      try {
        await RoutingService().pushNamed(shortcut.dynamicLink);
      } catch (e) {
        log(e.toString());
      }
    }).then((value) {
      _setupShortcuts();
    });
  }

  static Future<void> _setupShortcuts() async {
    final shortcuts = List.generate(
      actionList.length,
      (index) {
        final action = actionList[index];
        return ShortcutItem(
          type: action.id,
          localizedTitle: action.title,
          icon: action.iconName,
        );
      },
    );
    //Order shortcuts correctly for iOS
    // if (GetPlatform.isIOS) {
    //   shortcuts = shortcuts.reversed.toList();
    // }
    await _quickActions.setShortcutItems(shortcuts);
  }
}
