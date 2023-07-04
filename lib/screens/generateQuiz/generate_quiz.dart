import 'package:flutter/material.dart';
import 'package:quiz_craft/common_widgets/custom_text_form_field.dart';
import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/common_widgets/theme_textfield.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/helper/strings.dart';
import 'package:quiz_craft/screens/generateQuiz/widgets/paginator.dart';

class GenerateQuiz extends StatefulWidget {
  const GenerateQuiz({super.key});

  @override
  State<GenerateQuiz> createState() => _GenerateQuizState();
}

class _GenerateQuizState extends State<GenerateQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          Strings.createQuizText,
        ),
        titleTextStyle: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: ColorSys.kwhite),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(Radius.circular(48)),
        ),
        child: Column(
          children: [
            const Paginator(),
            const SizedBox(
              height: 40.0,
            ),
            CustomTextFormField(
              fieldName: Strings.questionText,
              fieldHeight: 200.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ThemeTextField(
              fieldName: Strings.option1Text,
              icon: Icons.circle_outlined,
              border: true,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ThemeTextField(
              fieldName: Strings.option2Text,
              icon: Icons.circle_outlined,
              border: true,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ThemeTextField(
              fieldName: Strings.option3Text,
              icon: Icons.circle_outlined,
              border: true,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ThemeTextField(
              fieldName: Strings.option4Text,
              icon: Icons.circle_outlined,
              border: true,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ThemeButton(
              name: Strings.regenerateButtonText,
            ),
          ],
        ),
      ),
    );
  }
}
