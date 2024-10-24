//! User Config
import 'dart:convert';
import 'dart:developer';

import 'package:tango/data/models/user_model.dart';
import 'package:tango/main.dart';
import 'package:tango/state/providers/user_provider.dart';

const String userKey = "KV_CURRENT_USER";
Future setUserData(dynamic data) async {
  await preferences.setString(userKey, jsonEncode(data));
}

Future getCurrentUser() async {
  try {
    var data = await jsonDecode(preferences.getString(userKey) ?? '');
    log("KV_CURRENT_USER$data");
    if (data != null) {
      userProvider.setCurrentUser(UserModel.fromJson(data));
    }
  } catch (e) {
    log(e.toString());
  }
}
