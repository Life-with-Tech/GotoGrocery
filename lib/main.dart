import 'dart:async';
import 'package:tango/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:tango/firebase_options.dart';
import 'package:tango/router/app_router.dart';
import 'package:tango/data/local/user_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tango/view/themes/app_theme.dart';
import 'package:tango/state/providers/app_provider.dart';
import 'package:tango/state/providers/home_provider.dart';
import 'package:tango/state/providers/user_provider.dart';
import 'package:tango/state/providers/theme_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:tango/state/providers/view_all_provider.dart';
import 'package:tango/core/services/notification_services.dart';
import 'package:tango/state/providers/add_to_cart_provider.dart';
import 'package:tango/state/providers/connectivity_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

late SharedPreferences preferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  preferences = await SharedPreferences.getInstance();

  LocalNotificationService.initialize();

  await userProvider.getToken();
  await appDataProvider.loadSavedLocale();
  await getCurrentUser();
  await getCurrentTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(value: userProvider),
        ChangeNotifierProvider<HomeProvider>.value(value: homeProvider),
        ChangeNotifierProvider<ViewAllProvider>.value(value: viewAllProvider),
        ChangeNotifierProvider<ConnectivityProvider>.value(
          value: connectivityProvider,
        ),
        ChangeNotifierProvider<AppDataProvider>.value(value: appDataProvider),
        ChangeNotifierProvider<AddToCartProvider>.value(
            value: addToCartProvider),
        ChangeNotifierProvider<ThemeProvider>.value(
          value: themeProvider,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter router = MyAppRoutes().router;

  @override
  Widget build(BuildContext context) {
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();

    return Consumer2<AppDataProvider, ThemeProvider>(
      builder: (context, value, themeData, child) => MaterialApp.router(
        locale: value.locale,
        supportedLocales:
            L10n().all.map((e) => Locale(e["value"]! as String)).toList(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        themeMode: themeData.themeMode,
        theme: AppTheme.lightThemeData,
        darkTheme: AppTheme.darkThemeData,
        debugShowCheckedModeBanner: false,
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () {
      unawaited(
        Provider.of<ConnectivityProvider>(context, listen: false).cancel(),
      );
    });
    super.dispose();
  }
}
