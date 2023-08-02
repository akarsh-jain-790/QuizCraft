import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:quiz_craft/firebase/firebase_auth.dart';

class AuthController {
  final BuildContext context;
  final FirebaseAuthClass _firebaseAuthClass = FirebaseAuthClass();
  AuthController(this.context);

  Future<bool> handleSignUp(
      {required String name,
      required String email,
      required String password}) async {
    if (name.isEmpty) {
      MotionToast.info(
        description: const Text("Name can not be empty"),
        position: MotionToastPosition.top,
      ).show(context);
      return false;
    }

    if (email.isEmpty) {
      MotionToast.info(
        description: const Text("Email can not be empty"),
        position: MotionToastPosition.top,
      ).show(context);
      return false;
    }

    if (password.isEmpty) {
      MotionToast.info(
        description: const Text("Password can not be empty"),
        position: MotionToastPosition.top,
      ).show(context);
      return false;
    }

    try {
      final Map<String, dynamic> userData = {
        "email": email,
        "password": email,
      };
      _firebaseAuthClass.signUpWithEmailAndPassword(context, userData);
      return true;
    } catch (e) {
      MotionToast.error(
        title: const Text("Error"),
        description: const Text("Unable to Sign Up!"),
        position: MotionToastPosition.top,
      ).show(context);
      return false;
    }
  }
}
