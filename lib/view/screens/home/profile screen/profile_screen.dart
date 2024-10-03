import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/l10n/l10n.dart';
import 'package:tango/state/providers/app_provider.dart';
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
      body: Container(
        alignment: Alignment.center,
        child: Icon(
          Icons.bookmark_rounded,
          size: 56,
          color: AppColors.onSecondary,
        ),
      ),
    );
  }
}
