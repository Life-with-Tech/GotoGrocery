import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path; // Import path package

class GlobalImageCropper {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> pickAndCropImage({
    required ImageSource source,
    CropAspectRatio? aspectRatio,
    CropStyle cropStyle = CropStyle.rectangle,
    int quality = 100, // Default image quality
  }) async {
    // Pick image from the specified source
    final pickedFile = await _imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      // Check the original file extension
      String originalExtension = path.extension(pickedFile.path);

      // Crop the image and get the cropped file
      File? croppedFile = await _cropImage(
          File(pickedFile.path), aspectRatio, quality, cropStyle);

      if (croppedFile != null) {
        // If the original format is GIF, you can save it as GIF here if needed
        if (originalExtension.toLowerCase() == '.gif') {
          // Handle GIF saving or conversion as needed
          // You can copy the cropped file to a new GIF path if needed
          // For example:
          return await croppedFile
              .copy(croppedFile.path.replaceAll('.jpg', '.gif'));
        }

        return croppedFile; // Return the cropped file
      }
    }
    return null; // Return null if no image is selected
  }

  // Method to crop the picked image
  static Future<File?> _cropImage(
    File imageFile,
    CropAspectRatio? aspectRatio,
    int quality,
    CropStyle cropStyle,
  ) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: aspectRatio,
      compressQuality: quality,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          cropStyle: cropStyle,
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: Colors.blue,
          lockAspectRatio: aspectRatio != null,
        ),
        IOSUiSettings(
          title: 'Crop Image',
          cropStyle: cropStyle,
          aspectRatioLockEnabled: aspectRatio != null,
        ),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path); // Return the cropped file
    }
    return null; // Return null if cropping was canceled
  }
}
