import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:tango/state/providers/app_provider.dart';
import '../../edit_screen.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.surface,
            fontSize: 18,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            icon: Icon(
              color: AppColors.surface,
              Icons.language,
            ),
            itemBuilder: (context) => [
              // PopupMenuItem 1
              const PopupMenuItem(
                value: 1,
                // row with 2 children
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.abc,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("English")
                  ],
                ),
              ),
              // PopupMenuItem 2
              const PopupMenuItem(
                value: 2,
                // row with two children
                child: Row(
                  children: [
                    Icon(Icons.nearby_off),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Hindi")
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 3,
                // row with two children
                child: Row(
                  children: [
                    Icon(Icons.nearby_off),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Bengali")
                  ],
                ),
              ),
            ],
            elevation: 2,
            onSelected: (value) async {
              if (value == 1) {
                await appDataProvider.setLocale(const Locale("en"));
              } else if (value == 2) {
                await appDataProvider.setLocale(const Locale("hi"));
              } else if (value == 3) {
                await appDataProvider.setLocale(const Locale("bn"));
              }
            },
          ),
        ],
      ),
      backgroundColor: AppColors.primary,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: Icon(
              Icons.settings,
              color: AppColors.surface,
            ),
            title: Text(
              L10n().getValue()!.login,
              style: TextStyle(
                color: AppColors.surface,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen(),));
              // RoutingService().pushNamed(
              //   Routes.editScreen.name,
              // );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: AppColors.surface,
            ),
            title: Text(
              'About',
              style: TextStyle(
                color: AppColors.surface,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
