import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tango/router/routing_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tango/core/constants/data_loding.dart';
import 'package:tango/state/providers/user_provider.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  static Future<void> updateUserStatus() async {
    GlobalLoading.showLoadingDialog();
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userProvider.currentUser?.uid)
          .update(
        {
          'status': false,
        },
      );

      log("User status updated successfully.");
    } catch (e) {
      log("Error updating user status: $e");
    }
    RoutingService().goBack();
  }
}
