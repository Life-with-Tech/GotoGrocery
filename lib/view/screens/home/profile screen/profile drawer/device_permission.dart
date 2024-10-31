import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/state/providers/theme_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsScreen extends StatefulWidget {
  @override
  _PermissionsScreenState createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  Map<Permission, PermissionStatus> _permissions = {};

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.location,
      Permission.microphone,
      Permission.storage,
    ].request();
    setState(() => _permissions = statuses);
  }

  Future<void> _requestPermission(Permission permission) async {
    final status = await permission.request();
    setState(() {
      _permissions[permission] = status;
    });
  }

  Widget _buildPermissionTile(Permission permission, String title) {
    log(_permissions[permission].toString());
    final status = _permissions[permission] ?? PermissionStatus.denied;
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(),
      ),
      subtitle: Text(
        "Status: ${status.toString().split('.')[1]}",
        style: const TextStyle(),
      ),
      trailing: ElevatedButton(
        onPressed: () => _requestPermission(permission),
        child: Text(
          "Request",
          style: TextStyle(
            color: themeProvider.isDark
                ? AppColors.darkSurface
                : AppColors.lightSurface,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Permissions"),
      ),
      body: ListView(
        children: [
          _buildPermissionTile(Permission.camera, "Camera"),
          _buildPermissionTile(Permission.location, "Location"),
          _buildPermissionTile(Permission.microphone, "Microphone"),
          _buildPermissionTile(Permission.storage, "Storage"),
        ],
      ),
    );
  }
}
