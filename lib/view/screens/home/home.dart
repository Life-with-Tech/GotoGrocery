import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/state/providers/app_provider.dart';
import 'package:tango/view/screens/home/favorite%20screen/favorite_screen.dart';
import 'package:tango/view/screens/home/home%20screen/home_screen.dart';
import 'package:tango/view/screens/home/profile%20screen/profile_screen.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
    Future.delayed(Duration.zero, () {
      FirebaseMessaging.instance.getInitialMessage().then(
        (message) {
          log("FirebaseMessaging.instance.getInitialMessage");
          if (message != null) {
            log("New Notification");
          }
        },
      );

      // 2. This method only call when App in forground it mean app must be opened
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          HomeScreen(),
          FavoriteScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: WaterDropNavBar(
        iconSize: 30,
        bottomPadding: 10,
        inactiveIconColor: AppColors.surface,
        waterDropColor: AppColors.surface,
        backgroundColor: AppColors.primary,
        onItemSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
          pageController.animateToPage(
            selectedIndex,
            duration: const Duration(
              milliseconds: 400,
            ),
            curve: Curves.easeOutQuad,
          );
        },
        selectedIndex: selectedIndex,
        barItems: <BarItem>[
          BarItem(
            filledIcon: Icons.home,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
            filledIcon: Icons.favorite_rounded,
            outlinedIcon: Icons.favorite_border_rounded,
          ),
          // BarItem(
          //   filledIcon: Icons.email_rounded,
          //   outlinedIcon: Icons.email_outlined,
          // ),
          BarItem(
            filledIcon: Icons.person,
            outlinedIcon: Icons.person_outline,
          ),
        ],
      ),
    );
  }
}