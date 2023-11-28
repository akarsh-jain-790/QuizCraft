import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quiz_craft/helper/failure.dart';
import 'package:quiz_craft/helper/firebase_constants.dart';
import 'package:quiz_craft/helper/type_deft.dart';
import 'package:quiz_craft/providers/firebase_provider.dart';

//? We don't want to create Instance of the class everytime so creating a Provider for it.
final quizRepositoryProvider = Provider(
  (ref) => QuizRepository(
    firebaseFirestore: ref.read(firestoreProvider),
    firebaseStorage: ref.read(firebaseStorage),
  ),
);

class QuizRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  CollectionReference get _quizzes =>
      _firebaseFirestore.collection(FirebaseConstants.quizCollection);

  QuizRepository({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseStorage firebaseStorage,
  })  : _firebaseFirestore = firebaseFirestore,
        _firebaseStorage = firebaseStorage;

  FutureEither<String> saveQuiz(Map<String, dynamic> quizData) async {
    try {
      String quizURL = generateRandomString();
      await _quizzes.doc(quizURL).set(quizData);

      //? In case of success we are returning the quiz url to the controller.
      return right(quizURL);
    } on FirebaseAuthException catch (e) {
      //? Throws the error to the next catch block.
      return left(Failure(e.message!));
    } catch (e) {
      //? returns the error to the controller.
      return left(Failure("Unable to Save Quiz!"));
    }
  }

  FutureEither<String> saveImage(File image) async {
    try {
      Reference reference = _firebaseStorage.ref();
      UploadTask uploadTask = reference.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      //? In case of success we are returning the quiz url to the controller.
      return right(imageUrl);
    } on FirebaseAuthException catch (e) {
      //? Throws the error to the next catch block.
      return left(Failure(e.message!));
    } catch (e) {
      //? returns the error to the controller.
      return left(Failure("Unable to upload File!"));
    }
  }

  FutureEither<Map<String, dynamic>> findQuiz(String quizCode) async {
    try {
      final QuerySnapshot result = await _quizzes.get();
      final List<DocumentSnapshot> documents = result.docs;
      bool isExist = false;
      late DocumentSnapshot documentSnapshot;

      for (var doc in documents) {
        if (doc.id == quizCode) {
          isExist = true;
          documentSnapshot = doc;
        }
      }

      if (!isExist) {
        throw Exception();
      }

      Map<String, dynamic> quizData = {
        "quizName": documentSnapshot.get("quizName"),
        "quizDescription": documentSnapshot.get("quizDescription"),
        "banner": documentSnapshot.get("banner"),
        "quizData": documentSnapshot.get("quizData"),
      };

      //? In case of success we are returning the quiz url to the controller.
      return right(quizData);
    } on FirebaseAuthException catch (e) {
      //? Throws the error to the next catch block.
      return left(Failure(e.message!));
    } catch (e) {
      //? returns the error to the controller.
      return left(Failure("Quiz not found!"));
    }
  }

  String generateRandomString() {
    var r = Random();
    return String.fromCharCodes(
        List.generate(6, (index) => r.nextInt(33) + 89));
  }
}
