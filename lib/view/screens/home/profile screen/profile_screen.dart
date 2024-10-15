import 'dart:developer';
import 'package:gap/gap.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/core/utils/string_utils.dart';
import 'package:tango/core/constants/photo_type.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/state/providers/app_provider.dart';
import 'package:tango/state/providers/user_provider.dart';
import 'package:tango/core/constants/profile_bottom_semi_circle_clipper.dart';
import 'package:tango/view/screens/home/profile%20screen/profile_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      endDrawer: const Drawer(
        child: ProfileDrawer(),
      ),
      appBar: AppBar(
        title: Text(
          L10n().getValue()!.profile,
          style: TextStyle(
            color: AppColors.surface,
            fontSize: 18,
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.settings,
                color: AppColors.surface,
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipPath(
                clipper: BottomSemiCircleClipper(),
                child: Container(
                  width: fullWidth(context),
                  height: fullHeight(context) / 7,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: loadImage(userProvider.currentUser?.image),
                        ),
                        color: AppColors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned(
                      bottom: -5,
                      right: -5,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.surface,
                        ),
                        onPressed: () async {
                          await Future.microtask(() {
                            RoutingService().pushNamed(
                              Routes.editProfile.name,
                              queryParameters: {
                                "id": 1,
                              },
                            );
                          });
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Gap(10),
          Text(
            textAlign: TextAlign.center,
            capitalizeFirstLetter(userProvider.currentUser?.name ?? ""),
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            userProvider.currentUser?.email ?? "",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                minimumSize: Size(
                  fullWidth(context) / 2.5,
                  40,
                ),
                backgroundColor: AppColors.primary,
              ),
              onPressed: () {},
              child: Text(
                textAlign: TextAlign.center,
                "Edit Profile",
                style: TextStyle(
                  color: AppColors.surface,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Products",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Icon(
                  Icons.arrow_right_rounded,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Products",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Icon(
                  Icons.arrow_right_rounded,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Products",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Icon(
                  Icons.arrow_right_rounded,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Products",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Icon(
                  Icons.arrow_right_rounded,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Products",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Icon(
                  Icons.arrow_right_rounded,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Products",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Icon(
                  Icons.arrow_right_rounded,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Products",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Icon(
                  Icons.arrow_right_rounded,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Products",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Icon(
                  Icons.arrow_right_rounded,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Products",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Icon(
                  Icons.arrow_right_rounded,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Products",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Icon(
                  Icons.arrow_right_rounded,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
