import 'package:gap/gap.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/core/utils/string_utils.dart';
import 'package:tango/core/constants/photo_type.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'package:tango/state/providers/app_provider.dart';
import 'package:tango/state/providers/user_provider.dart';
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
          Container(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            height: fullHeight(context) / 6,
            width: fullWidth(context),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              border: Border.all(
                color: AppColors.black,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
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
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: AppColors.surface,
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        capitalizeFirstLetter(
                            userProvider.currentUser?.name ?? ""),
                        style: TextStyle(
                          color: AppColors.surface,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        capitalizeFirstLetter(
                            userProvider.currentUser?.email ?? ""),
                        style: TextStyle(
                          color: AppColors.surface,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // const Gap(5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
