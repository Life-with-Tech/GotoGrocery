import 'package:gap/gap.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/state/providers/theme_provider.dart';

class AccountBlockedScreen extends StatelessWidget {
  const AccountBlockedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Blocked'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.block,
                color: Colors.red,
                size: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                'Your account has been blocked',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(10),
              const Text(
                'Please contact support for more information.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Contact Support'),
              ),
              const Gap(10),
              ElevatedButton(
                onPressed: () {
                  RoutingService().goName(Routes.loginScreen.name);
                },
                style: ElevatedButton.styleFrom(),
                child: Text(
                  'Back To Login',
                  style: TextStyle(
                    color: themeProvider.isDark
                        ? AppColors.darkSurface
                        : AppColors.lightSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
