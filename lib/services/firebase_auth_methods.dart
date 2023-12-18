import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_share/utils/showSnackBar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //state persistance

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  // email login
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!_auth.currentUser!.emailVerified) {
        sendEmailVerification(context);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // email verification
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, "email verification sent!");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //sign out
  Future<void> signOut(context) async {
    try {
      _auth.signOut();
      showSnackBar(context, "signed out successfully");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //delete account
  Future<void> deleteAccount(context) async {
    try {
      await _auth.currentUser!.delete();
      showSnackBar(context, "account deleted successfully");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //reset password
  Future<void> passwordReset({
    required String email,
    required context,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showSnackBar(context, "Password reset link sent! Check your email");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
