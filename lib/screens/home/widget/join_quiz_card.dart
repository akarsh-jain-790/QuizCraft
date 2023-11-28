import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/common_widgets/theme_textfield.dart';
import 'package:quiz_craft/firebase/quiz/controller/quiz_controller.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/helper/strings.dart';

class JoinQuizCard extends StatefulWidget {
  const JoinQuizCard({super.key});

  @override
  State<JoinQuizCard> createState() => _JoinQuizCardState();
}

class _JoinQuizCardState extends State<JoinQuizCard> {
  late TextEditingController _quizCodeController;

  @override
  void initState() {
    _quizCodeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _quizCodeController.dispose();
    super.dispose();
  }

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
                controllerName: _quizCodeController,
                icon: Icons.code,
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return ThemeButton(
                    name: Strings.findQuizButtonText,
                    onPressed: () {
                      ref
                          .read(quizControllerProvider.notifier)
                          .findQuizController(
                              context, _quizCodeController.text);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
