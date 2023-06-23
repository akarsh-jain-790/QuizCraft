import 'package:flutter/material.dart';
import 'package:quiz_craft/screens/onboarding/onboarding.dart';
import 'package:quiz_craft/theme/app_theme.dart';

void main() {
  runApp(
    MaterialApp(
      title: "QuizCraft",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const Onboarding(),
    ),
  );
}
