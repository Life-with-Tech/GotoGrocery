import 'dart:io';
import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';

class ImageStorageHelper {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String?> uploadImage(File? imageFile,
      {String folderPath = 'uploads'}) async {
    if (imageFile == null) {
      return null;
    }
    try {
      Reference storageRef = _storage.ref().child('$folderPath/.jpg');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      log('Image uploaded successfully. Download URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  Future<void> deleteImage(String imageUrl) async {
    try {
      Reference storageRef = _storage.refFromURL(imageUrl);
      await storageRef.delete();
      log('Image deleted successfully');
    } catch (e) {
      log('Error deleting image: $e');
    }
  }
}
