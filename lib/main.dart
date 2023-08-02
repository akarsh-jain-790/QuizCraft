import 'package:flutter/material.dart';
import 'package:quiz_craft/screens/onboarding/onboarding.dart';
import 'package:quiz_craft/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      title: "QuizCraft",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const Onboarding(),
    ),
  );
}
