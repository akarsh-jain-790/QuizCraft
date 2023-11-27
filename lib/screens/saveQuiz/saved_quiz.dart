import 'package:flutter/material.dart';

import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/helper/strings.dart';
import 'package:quiz_craft/screens/home/home.dart';
import 'package:quiz_craft/screens/saveQuiz/widget/saved_quiz_card.dart';

class SavedQuiz extends StatelessWidget {
  final String quizURL;
  const SavedQuiz({
    Key? key,
    required this.quizURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: SavedQuizCard(quizURL: quizURL),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ThemeButton(
                    name: Strings.createAnotherQuizText,
                    buttonColor: ColorSys.kwhite,
                    textColor: ColorSys.kblack,
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                      (Route<dynamic> route) => false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
