import 'package:flutter/material.dart';
import 'package:quiz_craft/helper/colors_sys.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
    primaryColor: ColorSys.kprimary,
    scaffoldBackgroundColor: ColorSys.ksecondary,
    fontFamily: 'Rubik',
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: ColorSys.kblack,
        fontSize: 24,
        fontFamily: "Rubik",
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: ColorSys.kblack,
        fontSize: 16,
        fontFamily: "Rubik",
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        color: ColorSys.kblack,
        fontSize: 16,
        fontFamily: "Rubik",
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
