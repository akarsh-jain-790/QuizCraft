import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_craft/common_widgets/toast.dart';
import 'package:quiz_craft/firebase/auth/repository/auth_repository.dart';
import 'package:quiz_craft/models/user_model.dart';
import 'package:quiz_craft/screens/home/home.dart';

//? User provider for the current user.
final userProvider = StateProvider<UserModel?>((ref) => null);

//? authControllerProvider StateNotifierProvider
final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

//? It will be used for everyuser to get there data using uid.
//? .family allows us to use parameter in the Provider.
final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  //? get data of current user.
  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void signUpWithEmailAndPassword(
      BuildContext context, Map<String, dynamic> userData) async {
    //? state for butoon loading status.
    state = true;
    final user = await _authRepository.signUpWithEmailAndPassword(userData);
    state = false;

    //? checking if signed up successfully or not.
    user.fold(
      (l) => showToast(context, "Error", l.message, "warning"),
      (userModel) {
        _ref.read(userProvider.notifier).update((state) => userModel);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Home()));
      },
    );
  }

  void signInWithGoogle(BuildContext context) async {
    //? state for butoon loading status.
    state = true;
    final user = await _authRepository.signUpWithGoogle();
    state = false;

    //? checking if signed up successfully or not.
    user.fold(
        (l) => showToast(context, "Error", l.message, "warning"),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }

  void signInWithEmailAndPassword(
      BuildContext context, Map<String, dynamic> userData) async {
    //? state for butoon loading status.
    state = true;
    final user = await _authRepository.signInWithEmailAndPassword(userData);
    state = false;

    //? checking if signed up successfully or not.
    user.fold(
      (l) => showToast(context, "Error", l.message, "warning"),
      (userModel) {
        _ref.read(userProvider.notifier).update((state) => userModel);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Home()));
      },
    );
  }
}
