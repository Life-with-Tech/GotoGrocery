import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:tango/data/local/user_local.dart';
import 'package:tango/data/models/user_model.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/core/utils/error_handler.dart';
import 'package:tango/view/widgets/other_widget.dart';
import 'package:tango/core/constants/data_loding.dart';
import 'package:tango/router/app_routes_constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tango/state/providers/location_provider.dart';
import 'package:tango/data/repositories/auth_repository.dart';
import 'package:tango/data/repositories/user_repository.dart';

UserProvider userProvider = UserProvider();

class UserProvider extends ChangeNotifier {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  String? _token;
  String? get token => _token;
  Future getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((onValue) {
      _token = onValue;
    }).catchError((onError) {
      log("getToken $onError");
    });
    notifyListeners();
  }

  Future signIn({required String email, required String password}) async {
    GlobalLoading.showLoadingDialog();
    await AuthRepository()
        .signIn(email: email, password: password)
        .then((onValue) async {
      await setUser(userId: onValue!.uid);
    }).catchError((onError) {
      ErrorHandler.handleSignUpError(onError);
    });
    RoutingService().goBack();
  }

  Future signUp(
      {required String email,
      required String password,
      required String displayName}) async {
    GlobalLoading.showLoadingDialog();
    await AuthRepository()
        .signUp(email: email, password: password)
        .then((onValue) async {
      log("signUp $onValue");
      if (onValue != null) {
        Map<String, dynamic> deviceData = await getDeviceData();
        Map<String, dynamic> location = locationProvider.deviceData;
        await createUser(
          userId: onValue.uid,
          userData: {
            "uid": onValue.uid,
            "email": onValue.email,
            "name": displayName,
            "location": location,
            "platform": deviceData,
            "fcm": token,
            "createdAt": DateTime.now().toString(),
            "updatedAt": "",
          },
        );
      }
    }).catchError((onError) {
      ErrorHandler.handleSignUpError(onError);
    });
    RoutingService().goBack();
  }

  Future setUser({required String userId}) async {
    GlobalLoading.showLoadingDialog();
    await UserRepository().getUser(userId: userId).then(
      (onValue) async {
        if (onValue is Map<String, dynamic>) {
          _currentUser = UserModel.fromJson(onValue);
          await setUserData(onValue);
          RoutingService().goName(Routes.home.name);
        }
      },
    ).catchError((onError) {
      log("setUser catchError ${onError.toString()}");
    });
    log("currentUser ${currentUser?.toJson()}");
    RoutingService().goBack();
    notifyListeners();
  }

  Future createUser(
      {required String userId, required Map<String, dynamic> userData}) async {
    GlobalLoading.showLoadingDialog();
    await UserRepository()
        .createUser(userData: userData, userId: userId)
        .then((onValue) async {
      await setUser(userId: userId);
      log("setUser$onValue");
    }).catchError((onError) {
      ErrorHandler.handleSignUpError(onError);
    });
    RoutingService().goBack();
  }

  void setCurrentUser(UserModel userModel) {
    _currentUser = userModel;
    notifyListeners();
  }
}
