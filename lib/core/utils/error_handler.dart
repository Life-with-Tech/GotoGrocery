import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'toast_utils.dart'; // Ensure to import your ToastUtils class
// utils/error_handler.dart

class ErrorHandler {
  static void handleSignUpError(dynamic error) {
    log("signUp catchError: ${error.toString()}");

    // Check if the error is a FirebaseAuthException
    if (error is FirebaseAuthException) {
      // Handle specific error codes
      switch (error.code) {
        case 'email-already-in-use':
          ToastUtils.showToast(
            msg: "The email address is already in use by another account.",
            backgroundColor: Colors.red,
          );
          break;
        case 'weak-password':
          ToastUtils.showToast(
            msg: "The password provided is too weak.",
            backgroundColor: Colors.red,
          );
          break;
        case 'invalid-email':
          ToastUtils.showToast(
            msg: "The email address is not valid.",
            backgroundColor: Colors.red,
          );
          break;
        default:
          ToastUtils.showToast(
            msg: error.message ?? "An unknown error occurred.",
            backgroundColor: Colors.red,
          );
      }
    } else {
      // Handle non-Firebase errors
      ToastUtils.showToast(
        msg: "Error: ${error.toString()}",
        backgroundColor: Colors.red,
      );
    }
  }
}
