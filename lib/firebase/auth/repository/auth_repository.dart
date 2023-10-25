import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_craft/helper/failure.dart';
import 'package:quiz_craft/helper/firebase_constants.dart';
import 'package:quiz_craft/helper/type_deft.dart';
import 'package:quiz_craft/models/user_model.dart';
import 'package:quiz_craft/providers/firebase_provider.dart';

//? We don't want to create Instance of the class everytime so creating a Provider for it.
final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firebaseAuth: ref.read(authProvider),
    firebaseFirestore: ref.read(firestoreProvider),
    googleSignIn: ref.read(googleProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
    required GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _firebaseFirestore = firebaseFirestore;

  CollectionReference get _user =>
      _firebaseFirestore.collection(FirebaseConstants.userCollection);

  //? It will be used to check if the user is logged in or not.
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  FutureEither<UserModel> signUpWithEmailAndPassword(
      Map<String, dynamic> userData) async {
    try {
      //? Creating a new User using Email and Password.
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: userData["password"],
      );

      //? Storing the user data in firestore.
      UserModel userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        await userCredential.user?.updateDisplayName(userData["displayName"]);
        await userCredential.user?.reload();

        userModel = UserModel(
            name: userCredential.user!.displayName ?? "No name",
            email: userCredential.user!.email ?? "No email",
            uid: userCredential.user!.uid,
            isAuthenticated: true);

        await _user.doc(userCredential.user!.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }

      //? In case of success we are returning the userModel to the controller.
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      //? Throws the error to the next catch block.
      return left(Failure(e.message!));
    } catch (e) {
      //? returns the error to the controller.
      return left(Failure("Authentication failed!"));
    }
  }

  FutureEither<UserModel> signUpWithGoogle() async {
    try {
      //? Sign in with Google.
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final googleAuth = await googleSignInAccount?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      //? Storing the user data in firestore.
      UserModel userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
            name: userCredential.user!.displayName ?? "No name",
            email: userCredential.user!.email ?? "No email",
            uid: userCredential.user!.uid,
            isAuthenticated: true);
        await _user.doc(userCredential.user!.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }

      //? In case of success we are returning the userModel to the controller.
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      //? Throws the error to the next catch block.
      throw e.message!;
    } catch (e) {
      //? returns the error to the controller.
      return left(Failure("Authentication failed!"));
    }
  }

  FutureEither<UserModel> signInWithEmailAndPassword(
      Map<String, dynamic> userData) async {
    try {
      //? Creating a new User using Email and Password.
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: userData["email"],
        password: userData["password"],
      );

      //? Storing the user data in firestore.
      UserModel userModel;
      userModel = await getUserData(userCredential.user!.uid).first;

      //? In case of success we are returning the userModel to the controller.
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      //? Throws the error to the next catch block.
      return left(Failure(e.message!));
    } catch (e) {
      //? returns the error to the controller.
      return left(Failure("Authentication failed!"));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _user.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
