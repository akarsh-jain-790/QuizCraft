import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_craft/firebase/auth/controller/auth_controller.dart';
import 'package:quiz_craft/models/user_model.dart';
import 'package:quiz_craft/screens/home/home.dart';
import 'package:quiz_craft/screens/onboarding/onboarding.dart';
import 'package:quiz_craft/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: ".env");

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  Widget route(data) {
    if (data != null) {
      getData(ref, data);
      if (userModel != null) {
        return const Home();
      }
    }
    return const Onboarding();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) => MaterialApp(
            title: "QuizCraft",
            debugShowCheckedModeBanner: false,
            theme: AppTheme.theme,
            home: route(data),
          ),
          error: (error, stackTrace) => const Text("Error"),
          loading: () => const CircularProgressIndicator(),
        );
  }
}
