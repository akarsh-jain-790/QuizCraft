import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_craft/common_widgets/custom_text_form_field.dart';
import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/common_widgets/theme_textfield.dart';
import 'package:quiz_craft/firebase/quiz/controller/quiz_controller.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/helper/strings.dart';

class ReviewAndSave extends ConsumerStatefulWidget {
  const ReviewAndSave({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReviewAndSaveState();
}

class _ReviewAndSaveState extends ConsumerState<ReviewAndSave> {
  late TextEditingController quizNameController;
  late TextEditingController quizDescriptionController;
  late bool saveButtonState;

  @override
  void initState() {
    saveButtonState = false;
    quizNameController = TextEditingController();
    quizDescriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    quizNameController.dispose();
    quizDescriptionController.dispose();
    super.dispose();
  }

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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.all(Radius.circular(48)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/icons/quiz.svg",
                  height: 300.0,
                ),
              ),
              Text(
                Strings.quizNameText,
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
                fieldName: Strings.quizNamePlaceholderText,
                controllerName: quizNameController,
                textFieldEvent: (value) => toggleButtton(),
                icon: Icons.code_outlined,
                border: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                Strings.quizDescriptionText,
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
                fieldName: Strings.quizDescriptionPlaceholderText,
                controllerName: quizDescriptionController,
                textFieldEvent: (value) => toggleButtton(),
                fieldHeight: 200.0,
              ),
              const SizedBox(
                height: 20,
              ),
              ThemeButton(
                name: Strings.saveButtonText,
                onPressed: saveButtonState ? saveQuiz : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveQuiz() async {
    List list = [];

    for (var i = 0; i < ref.read(quizProvider)!.length; i++) {
      list.add(ref.read(quizProvider)?[i]?.toMap());
    }

    Map<String, dynamic> quizData = {
      "quizName": quizNameController.text,
      "quizDescription": quizDescriptionController.text,
      "banner": await ref
          .read(quizControllerProvider.notifier)
          .saveImageController(
              context,
              ref.read(quizDataProvider)["banner"] ??
                  File("assets/images/placeholder.png")),
      "quizData": list,
    };

    ref
        .read(quizControllerProvider.notifier)
        .saveQuizController(context, quizData);
  }

  void toggleButtton() {
    if (quizNameController.text.isNotEmpty &&
        quizDescriptionController.text.isNotEmpty) {
      setState(() {
        saveButtonState = true;
      });
    } else {
      setState(() {
        saveButtonState = false;
      });
    }
  }
}
