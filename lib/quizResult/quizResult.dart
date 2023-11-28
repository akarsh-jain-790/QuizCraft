import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/helper/strings.dart';
import 'package:quiz_craft/screens/home/home.dart';

class QuizResult extends StatefulWidget {
  final int quizScore;
  const QuizResult({super.key, required this.quizScore});

  @override
  State<QuizResult> createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('./assets/icons/trophy.json'),
                  Text(
                    Strings.congratulationText,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: ColorSys.kwhite, fontSize: 36.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    Strings.scoreText,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: ColorSys.kwhite, fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "${widget.quizScore}/10",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: ColorSys.kwhite, fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  ThemeButton(
                    name: Strings.doneText,
                    buttonColor: ColorSys.kwhite,
                    textColor: ColorSys.kblack,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
