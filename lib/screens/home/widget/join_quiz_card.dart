import 'package:flutter/material.dart';
import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/common_widgets/theme_textfield.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/helper/strings.dart';

class JoinQuizCard extends StatelessWidget {
  const JoinQuizCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Card(
        color: Theme.of(context).canvasColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0.8,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                Strings.findQuizText,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                Strings.findQuizDescriptionText,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: ColorSys.kgrey),
                textAlign: TextAlign.center,
              ),
              ThemeTextField(
                fieldName: Strings.quizCodeText,
                fieldColor: ColorSys.ksecondary,
                icon: Icons.code,
              ),
              ThemeButton(
                name: Strings.findQuizButtonText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
