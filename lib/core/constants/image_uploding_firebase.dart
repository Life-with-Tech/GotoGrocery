import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:tango/core/constants/data_loding.dart';
import 'package:tango/router/routing_service.dart';

class ImageUploadHelper {
  static Future uploadImageAndGetUrl(File imageFile) async {
    GlobalLoading.showLoadingDialog();
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String fileName = basename(imageFile.path);
      Reference storageRef = storage.ref().child('images/$fileName');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      RoutingService().goBack();
      return downloadUrl;
    } catch (e) {
      log("Error uploading image: $e");
      RoutingService().goBack();
    }
  }
}
