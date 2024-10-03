import "dart:io";
import "dart:async";
import "dart:developer";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:connectivity_plus/connectivity_plus.dart";
// ignore_for_file: type_annotate_public_apis

ConnectivityProvider connectivityProvider = ConnectivityProvider();

class ConnectivityProvider with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _internetState;
  bool _isOnline = false;
  bool get isOnline => _isOnline;

  Future<void> startMonitoring() async {
    await initConnectivity();
    _internetState = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) async {
      if (result.contains(ConnectivityResult.none)) {
        _isOnline = false;
        notifyListeners();
      } else {
        await _updateConnectionStatus().then((bool isConnected) {
          _isOnline = isConnected;
          notifyListeners();
        });
      }
    });
  }

  Future<void> initConnectivity() async {
    try {
      final status = await _connectivity.checkConnectivity();

      if (status.contains(ConnectivityResult.none)) {
        _isOnline = false;
        notifyListeners();
      } else {
        _isOnline = true;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      log(
        e.toString(),
      );
    }
  }

  Future<bool> _updateConnectionStatus() async {
    bool isConnected = false;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
      //return false;
    }
    return isConnected;
  }

  Future<void> cancel() async {
    await _internetState?.cancel();
    notifyListeners();
  }
}
