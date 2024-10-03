import "dart:async";
import "dart:developer";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:tango/router/app_router.dart";
import "package:tango/router/app_routes_constant.dart";

class RoutingService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  void goName(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
    BuildContext? screenContext,
  }) {
    (screenContext ?? navigatorKey.currentContext)?.goNamed(
      name,
      extra: extra,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
    );
  }

  void pushReplacementNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
    BuildContext? screenContext,
  }) {
    (screenContext ?? navigatorKey.currentContext)?.pushReplacementNamed(
      name,
      extra: extra,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
    );
  }

  Future<Object?>? pushNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
    BuildContext? screenContext,
  }) async {
    return (screenContext ?? navigatorKey.currentContext)?.pushNamed(
      name,
      extra: extra,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
    );
  }

  bool canPop({
    BuildContext? screenContext,
  }) =>
      (screenContext ?? navigatorKey.currentContext)?.canPop() ?? false;
  void go(
    String name, {
    Object? extra,
    BuildContext? screenContext,
  }) {
    (screenContext ?? navigatorKey.currentContext)?.go(
      name,
      extra: extra,
    );
  }

  Future<dynamic> goto(BuildContext context, Widget nextScreen) async {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
    );
  }

  Future<void> gotoAndBackUntils(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
    BuildContext? screenContext,
  }) async {
    (screenContext ?? navigatorKey.currentContext)
        ?.pushReplacementNamed(name, extra: extra);
  }

  Future<void> goBack({BuildContext? context, result}) async {
    if ((context ?? navigatorKey.currentContext)?.canPop() ?? false) {
      return (context ?? navigatorKey.currentContext)?.pop(result);
    } else {
      log(
        "going back ${MyAppRoutes().router.routeInformationProvider.value.uri}",
      );
      goName(Routes.homeScreen.name);
    }
  }
}