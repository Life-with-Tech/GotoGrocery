import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/state/providers/app_provider.dart';
import 'package:tango/state/providers/user_provider.dart';
import 'package:tango/state/providers/theme_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:tango/view/screens/home/home%20screen/home_screen.dart';
import 'package:tango/view/screens/home/profile%20screen/profile_screen.dart';
import 'package:tango/view/screens/home/favorite%20screen/favorite_screen.dart';
import 'package:tango/view/screens/home/home%20screen/product%20add/category_select.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: appDataProvider.index);
    Future.delayed(Duration.zero, () {
      FirebaseMessaging.instance.getInitialMessage().then(
        (message) {
          log("FirebaseMessaging.instance.getInitialMessage");
          if (message != null) {
            log("New Notification");
          }
        },
      );

      FirebaseMessaging.onMessage.listen(
        (message) {
          log("FirebaseMessaging.onMessage.listen!!!");
          log("FirebaseMessaging.onMessage.listen$message");
          if (message.notification != null) {
            log(message.notification!.title.toString());
            log(message.notification!.body.toString());
            log("message.data11 ${message.data}");
            // LocalNotificationService.display(message);
          }
        },
      );

      // 3. This method only call when App in background and not terminated(not closed)
      FirebaseMessaging.onMessageOpenedApp.listen(
        (message) {
          log("FirebaseMessaging.onMessageOpenedApp.listen");
          log("FirebaseMessaging.onMessage.listen$message");

          if (message.notification != null) {
            log(message.notification!.title.toString());
            log(message.notification!.body.toString());
            log("message.data22 ${message.data['_id']}");
          }
        },
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    Future.delayed(Duration.zero, () {
      appDataProvider.updatedIndex(index: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          HomeScreen(),
          FavoriteScreen(),
          // if (userProvider.currentUser?.userType ?? false)
          CategorySelect(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: WaterDropNavBar(
        iconSize: 30,
        bottomPadding: 10,
        inactiveIconColor:
            themeProvider.isDark ? AppColors.white : AppColors.white,
        waterDropColor:
            themeProvider.isDark ? AppColors.white : AppColors.white,
        backgroundColor: AppColors.lightPrimary,
        onItemSelected: (int index) {
          appDataProvider.updatedIndex(index: index);

          pageController.animateToPage(
            appDataProvider.index,
            duration: const Duration(
              milliseconds: 400,
            ),
            curve: Curves.easeOutQuad,
          );
        },
        selectedIndex: appDataProvider.index,
        barItems: <BarItem>[
          BarItem(
            filledIcon: Icons.home,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
            filledIcon: Icons.favorite_rounded,
            outlinedIcon: Icons.favorite_border_rounded,
          ),
          // if (userProvider.currentUser?.userType ?? false)
          BarItem(
            filledIcon: Icons.upload_rounded,
            outlinedIcon: Icons.upload_outlined,
          ),
          BarItem(
            filledIcon: Icons.person,
            outlinedIcon: Icons.person_outline,
          ),
        ],
      ),
    );
  }
}
