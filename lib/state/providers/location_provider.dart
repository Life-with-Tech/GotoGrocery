import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

LocationProvider locationProvider = LocationProvider();

class LocationProvider extends ChangeNotifier {
  Map<String, dynamic> _deviceData = {};
  Map<String, dynamic> get deviceData => _deviceData;
  Future checkPermissionsAndGetLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        await openAppSettings();
        return;
      }

      Position position = await Geolocator.getCurrentPosition();

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark placemark = placemarks[0];

      _deviceData = {
        "pincode": placemark.postalCode.toString(),
        "latitude": position.latitude.toString(),
        "longitude": position.longitude.toString(),
        "country": placemark.country.toString(),
        "state": placemark.locality.toString(),
        "district": placemark.subLocality.toString(),
        "city": placemark.name.toString(),
        "Area": placemark.administrativeArea.toString(),
      };
    } catch (e) {
      log("location$e");
    }
    log(_deviceData.toString());
    notifyListeners();
  }
}
