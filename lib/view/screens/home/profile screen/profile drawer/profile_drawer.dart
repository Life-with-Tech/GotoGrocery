import 'package:gap/gap.dart';
import 'package:tango/main.dart';
import '../../../edit_screen.dart';
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
                          color: themeProvider.isDark
                              ? AppColors.lightSurface
                              : AppColors.darkSurface,
                        ),
                      ),
                      child: Image.asset(
                        "assets/icons/language/english.png",
                        color: themeProvider.isDark
                            ? AppColors.lightSurface
                            : AppColors.darkSurface,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      L10n().getValue()!.english,
                      style: TextStyle(
                        color: themeProvider.isDark
                            ? AppColors.lightSurface
                            : AppColors.darkSurface,
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
                          color: themeProvider.isDark
                              ? AppColors.lightSurface
                              : AppColors.darkSurface,
                        ),
                      ),
                      child: Image.asset(
                        "assets/icons/language/hindi.png",
                        fit: BoxFit.cover,
                        color: themeProvider.isDark
                            ? AppColors.lightSurface
                            : AppColors.darkSurface,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      L10n().getValue()!.hindi,
                      style: TextStyle(
                        color: themeProvider.isDark
                            ? AppColors.lightSurface
                            : AppColors.darkSurface,
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
                          color: themeProvider.isDark
                              ? AppColors.lightSurface
                              : AppColors.darkSurface,
                        ),
                      ),
                      child: Image.asset(
                        "assets/icons/language/bangla.png",
                        fit: BoxFit.cover,
                        color: themeProvider.isDark
                            ? AppColors.lightSurface
                            : AppColors.darkSurface,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      L10n().getValue()!.bangla,
                      style: TextStyle(
                        color: themeProvider.isDark
                            ? AppColors.lightSurface
                            : AppColors.darkSurface,
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
          themeProvider.isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SwitchListTile(
            secondary: Icon(
              themeProvider.isDark ? Icons.dark_mode : Icons.light_mode,
              color: themeProvider.isDark
                  ? AppColors.darkSurface
                  : AppColors.lightSurface,
              size: 18,
            ),
            activeColor: AppColors.darkSurface,
            title: Text(
              themeProvider.isDark
                  ? L10n().getValue()!.dark_theme
                  : L10n().getValue()!.light_theme,
              style: TextStyle(
                color: themeProvider.isDark
                    ? AppColors.darkSurface
                    : AppColors.lightSurface,
                fontSize: 15,
              ),
            ),
            value: themeProvider.isDark,
            onChanged: (value) {
              themeProvider.toggleThemeMode(value);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.smartphone_sharp,
              color: themeProvider.isDark
                  ? AppColors.darkSurface
                  : AppColors.lightSurface,
              size: 18,
            ),
            title: Text(
              L10n().getValue()!.device_permission,
              style: TextStyle(
                color: themeProvider.isDark
                    ? AppColors.darkSurface
                    : AppColors.lightSurface,
                fontSize: 15,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: themeProvider.isDark
                  ? AppColors.darkSurface
                  : AppColors.lightSurface,
              size: 15,
            ),
            onTap: () {
              RoutingService().pushNamed(
                Routes.devicePermissionScreen.name,
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: themeProvider.isDark
                  ? AppColors.darkSurface
                  : AppColors.lightSurface,
              size: 18,
            ),
            title: Text(
              L10n().getValue()!.log_out,
              style: TextStyle(
                color: themeProvider.isDark
                    ? AppColors.darkSurface
                    : AppColors.lightSurface,
                fontSize: 15,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: themeProvider.isDark
                  ? AppColors.darkSurface
                  : AppColors.lightSurface,
              size: 15,
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
