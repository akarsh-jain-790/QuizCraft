import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:quiz_craft/screens/home/home.dart';

class FirebaseAuthClass {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void signUpWithEmailAndPassword(
      BuildContext context, Map<String, dynamic> userData) async {
    try {
      // Creating a new User using Email and Password.
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userData["email"],
        password: userData["password"],
      );
      // Adding User data to Firestore.
      _firebaseFirestore.collection("Users").add(userData).then((_) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }).catchError((error) {
        MotionToast.error(
          title: const Text("Error"),
          description: const Text("Unable to Register!"),
          position: MotionToastPosition.bottom,
        ).show(context);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        MotionToast.error(
          title: const Text("Weak Password"),
          description: const Text("The password provided is too weak."),
          position: MotionToastPosition.bottom,
        ).show(context);
      } else if (e.code == 'email-already-in-use') {
        MotionToast.error(
          title: const Text("Email already in use"),
          description: const Text("The account already exists for that email."),
          position: MotionToastPosition.bottom,
        ).show(context);
      } else if (e.code == 'invalid-email') {
        MotionToast.error(
          description: const Text("The email address is badly formatted."),
          position: MotionToastPosition.bottom,
        ).show(context);
      } else {
        MotionToast.error(
          title: const Text("Error"),
          description: const Text("Unable to Register!"),
          position: MotionToastPosition.bottom,
        ).show(context);
      }
    }
  }

  Future<String?> getCurrentUID() async {
    final User? user = _firebaseAuth.currentUser;
    final String? uid = user?.uid;
    return uid;
  }
}
