import 'package:flutter/material.dart';
import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/common_widgets/theme_textfield.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/helper/strings.dart';
import 'package:quiz_craft/screens/createQuiz/widgets/banner_image_picker.dart';
import 'package:quiz_craft/screens/createQuiz/widgets/custom_text_form_field.dart';

class CreateQuiz extends StatelessWidget {
  const CreateQuiz({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BannerImagePicker(),
            const SizedBox(
              height: 20,
            ),
            Text(
              Strings.topicText,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 10,
            ),
            ThemeTextField(
              fieldName: Strings.topicPlaceholderText,
              icon: Icons.code_outlined,
              border: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              Strings.describeTopicText,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              fieldName: Strings.describePlaceholderText,
            ),
            const SizedBox(
              height: 20,
            ),
            ThemeButton(
              name: Strings.generateQuiz,
            ),
          ],
        ),
      ),
    );
  }
}
