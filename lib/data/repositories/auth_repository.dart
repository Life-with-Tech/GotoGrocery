import 'package:firebase_auth/firebase_auth.dart';
import 'package:tango/core/services/firebase_auth_service.dart';

class AuthRepository {
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Sign up using email and password
  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    return await _authService.signUpWithEmailAndPassword(
      email,
      password,
    );
  }

  // Login using email and password
  Future<User?> signIn(
      {required String email, required String password}) async {
    return await _authService.signInWithEmailAndPassword(email, password);
  }

  // Logout the current user
  Future<void> signOut() async {
    await _authService.signOut();
  }

  // Get the current logged-in user
  User? getCurrentUser() {
    return _authService.getCurrentUser();
  }

  // Send password reset email
  Future<void> resetPassword(String email) async {
    await _authService.sendPasswordResetEmail(email);
  }
}
