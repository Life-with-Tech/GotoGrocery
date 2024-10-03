class RouteName {
  const RouteName({required this.name, required this.path});
  final String name;
  final String path;
}

class Routes {
  static const RouteName splashScreen =
      RouteName(name: "splash_screen", path: "/");
  static const RouteName loginScreen =
      RouteName(name: "login_screen", path: "/login_screen");
  static const RouteName signupScreen =
      RouteName(name: "signup_screen", path: "/signup_screen");
  static const RouteName homeScreen =
      RouteName(name: "home_screen", path: "/home_screen");
  static const RouteName home = RouteName(name: "home", path: "/home");
  static const RouteName cart =
      RouteName(name: "cart_screen", path: "/cart_screen");
}