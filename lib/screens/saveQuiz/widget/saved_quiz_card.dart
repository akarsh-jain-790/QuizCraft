// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motion_toast/motion_toast.dart';

import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/common_widgets/theme_textfield.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/helper/strings.dart';

class SavedQuizCard extends StatelessWidget {
  final String quizURL;
  const SavedQuizCard({
    Key? key,
    required this.quizURL,
  }) : super(key: key);

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
                Strings.saveQuizText,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                Strings.urlText,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: ColorSys.kgrey),
                textAlign: TextAlign.center,
              ),
              ThemeTextField(
                fieldName: Strings.quizCodeText,
                fieldColor: ColorSys.ksecondary,
                controllerName: TextEditingController(text: quizURL),
                icon: Icons.code,
                isEnabled: false,
              ),
              ThemeButton(
                name: Strings.copyURLText,
                onPressed: () =>
                    Clipboard.setData(ClipboardData(text: quizURL)).then((_) {
                  MotionToast.success(
                    description: const Text('Copied URL to clipboard!'),
                  ).show(context);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
