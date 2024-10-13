import 'dart:io';
import 'package:flutter/material.dart';

ImageProvider loadImage(String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return const AssetImage(
      'assets/icons/friendship.png',
    );
  }
  final Uri? uri = Uri.tryParse(imageUrl);
  if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
    return NetworkImage(imageUrl);
  } else {
    return FileImage(File(imageUrl));
  }
}
