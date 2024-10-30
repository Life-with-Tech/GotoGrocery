import 'package:gap/gap.dart';
import '../../edit_screen.dart';
import 'package:tango/main.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/state/providers/app_provider.dart';
import 'package:tango/state/providers/theme_provider.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(
              Icons.language,
            ),
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.black,
                        ),
                      ),
                      child: Image.asset(
                        "assets/icons/language/english.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      L10n().getValue()!.english,
                      style: const TextStyle(
                        color: AppColors.surface,
                      ),
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.black,
                        ),
                      ),
                      child: Image.asset(
                        "assets/icons/language/hindi.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      L10n().getValue()!.hindi,
                      style: const TextStyle(
                        color: AppColors.surface,
                      ),
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.black,
                        ),
                      ),
                      child: Image.asset(
                        "assets/icons/language/bangla.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      L10n().getValue()!.bangla,
                      style: const TextStyle(
                        color: AppColors.surface,
                      ),
                    )
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
      backgroundColor:
          themeProvider.isDark ? AppColors.lightPrimary : AppColors.darkPrimary,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: Icon(
              Icons.info,
              color: AppColors.white,
            ),
            title: Text(
              'About',
              style: TextStyle(
                color: AppColors.white,
              ),
            ),
            onTap: () {},
          ),
          SwitchListTile(
            title: Text(
              'Theme',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                fontSize: 18,
              ),
            ),
            value: themeProvider.isDark,
            onChanged: (value) {
              themeProvider.toggleThemeMode(value);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: AppColors.white,
            ),
            title: Text(
              L10n().getValue()!.log_out,
              style: TextStyle(
                color: AppColors.white,
              ),
            ),
            onTap: () {
              preferences.clear();
              RoutingService().goName(
                Routes.loginScreen.name,
              );
            },
          ),
        ],
      ),
    );
  }
}
