import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:tango/data/models/user_model.dart';
import 'package:tango/core/utils/error_handler.dart';
import 'package:tango/data/repositories/auth_repository.dart';
import 'package:tango/data/repositories/user_repository.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/view/widgets/other_widget.dart';

UserProvider userProvider = UserProvider();

class UserProvider extends ChangeNotifier {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  String? _token;
  String? get token => _token;
  Future getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((onValue) {
      log("getToken $onValue");
      _token = onValue;
    }).catchError((onError) {});
    notifyListeners();
  }

  Future signIn({required String email, required String password}) async {
    await AuthRepository()
        .signIn(email: email, password: password)
        .then((onValue) async {
      await setUser(userId: onValue!.uid);
    }).catchError((onError) {
      ErrorHandler.handleSignUpError(onError);
    });
  }

  Future signUp(
      {required String email,
      required String password,
      required String displayName}) async {
    await AuthRepository()
        .signUp(email: email, password: password)
        .then((onValue) async {
      log("signUp $onValue");
      if (onValue != null) {
        Map<String, dynamic> deviceData = await getDeviceData();
        await createUser(
          userId: onValue.uid,
          userData: {
            "uid": onValue.uid,
            "email": onValue.email,
            "name": displayName,
            "state": "Bihar",
            "district": "Chapra",
            "city": "Amnour",
            "pincode": "841418",
            "latitude": "-12.451585",
            "longitude": "74.5571242",
            "createdAt": "02-24-2024",
            "platform": deviceData,
            "fcm": token,
            "updatedAt": "",
          },
        );
      }
    }).catchError((onError) {
      ErrorHandler.handleSignUpError(onError);
    });
  }

  Future setUser({required String userId}) async {
    await UserRepository().getUser(userId: userId).then(
      (onValue) {
        if (onValue is Map<String, dynamic>) {
          _currentUser = UserModel.fromJson(onValue);

          RoutingService().pushNamed(Routes.homeScreen.name);
        }
      },
    ).catchError((onError) {
      log("setUser catchError ${onError.toString()}");
    });
    log("currentUser ${currentUser?.toJson()}");
    notifyListeners();
  }

  Future createUser(
      {required String userId, required Map<String, dynamic> userData}) async {
    await UserRepository()
        .createUser(userData: userData, userId: userId)
        .then((onValue) async {
      await setUser(userId: userId);
      log("setUser$onValue");
    }).catchError((onError) {
      ErrorHandler.handleSignUpError(onError);
    });
  }
}
