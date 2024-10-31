import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/view/screens/home/home.dart';
import 'package:tango/view/screens/edit_screen.dart';
import 'package:tango/view/screens/login_screen.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/view/screens/signup_screen.dart';
import 'package:tango/view/screens/splash_screen.dart';
import 'package:tango/view/screens/Account/account_blocked_sreeen.dart';
import 'package:tango/view/screens/home/home%20screen/home_screen.dart';
import 'package:tango/view/screens/home/home%20screen/cart/cart_screen.dart';
import 'package:tango/view/screens/home/profile%20screen/edit_profile_screen.dart';
import 'package:tango/view/screens/home/home%20screen/product%20add/product_add.dart';
import 'package:tango/view/screens/home/profile%20screen/profile%20drawer/device_permission.dart';

class MyAppRoutes {
  final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: RoutingService.navigatorKey,
    initialLocation: Routes.splashScreen.path,
    errorBuilder: (BuildContext context, GoRouterState state) {
      log(state.name.toString());
      return const Scaffold(
        body: Center(
          child: Text("Page Not Found"),
        ),
      );
    },
    routes: <RouteBase>[
      GoRoute(
        path: Routes.splashScreen.path,
        name: Routes.splashScreen.name,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: Routes.loginScreen.path,
        name: Routes.loginScreen.name,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: Routes.signupScreen.path,
        name: Routes.signupScreen.name,
        builder: (BuildContext context, GoRouterState state) =>
            const SignupScreen(),
      ),
      GoRoute(
        path: Routes.accountBlockedScreen.path,
        name: Routes.accountBlockedScreen.name,
        builder: (BuildContext context, GoRouterState state) =>
            const AccountBlockedScreen(),
      ),
      GoRoute(
        path: Routes.homeScreen.path,
        name: Routes.homeScreen.name,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
      GoRoute(
        path: Routes.home.path,
        name: Routes.home.name,
        builder: (BuildContext context, GoRouterState state) => const Home(),
      ),
      GoRoute(
        path: Routes.cart.path,
        name: Routes.cart.name,
        builder: (BuildContext context, GoRouterState state) =>
            const CartScreen(),
      ),
      GoRoute(
        path: Routes.editProfile.path,
        name: Routes.editProfile.name,
        builder: (BuildContext context, GoRouterState state) {
          log("queryParameters${state.uri.queryParameters["id"].toString()}");
          String? id = state.uri.queryParameters["id"];
          String? email = state.uri.queryParameters["email"];
          return EditProfileScreen(
            id: (id != null) ? id : null,
            email: (email != null) ? email : null,
          );
        },
      ),
      GoRoute(
        path: Routes.addProductScreen.path,
        name: Routes.addProductScreen.name,
        builder: (BuildContext context, GoRouterState state) {
          String id = state.pathParameters['id'] ?? '';
          return ProductAdd(
            id: id,
          );
        },
      ),
      GoRoute(
        path: Routes.devicePermissionScreen.path,
        name: Routes.devicePermissionScreen.name,
        builder: (BuildContext context, GoRouterState state) {
          return PermissionsScreen();
        },
      ),
    ],
  );
}
