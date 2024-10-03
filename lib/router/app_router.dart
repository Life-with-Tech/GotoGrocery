import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/view/screens/home/home%20screen/cart/cart_screen.dart';
import 'package:tango/view/screens/home/home.dart';
import 'package:tango/view/screens/login_screen.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/view/screens/signup_screen.dart';
import 'package:tango/view/screens/splash_screen.dart';
import 'package:tango/view/screens/home/home%20screen/home_screen.dart';

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
    ],
  );
}