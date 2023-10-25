import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/common_widgets/theme_textfield.dart';
import 'package:quiz_craft/firebase/quiz/controller/quiz_controller.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/helper/strings.dart';
import 'package:quiz_craft/screens/createQuiz/widgets/banner_image_picker.dart';
import 'package:quiz_craft/common_widgets/custom_text_form_field.dart';

class CreateQuiz extends ConsumerStatefulWidget {
  const CreateQuiz({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateQuizState();
}

class _CreateQuizState extends ConsumerState<CreateQuiz> {
  late TextEditingController _topicController;
  late TextEditingController _descriptionController;
  late bool generateQuizButtonState;

  @override
  void initState() {
    _topicController = TextEditingController();
    _descriptionController = TextEditingController();
    generateQuizButtonState = false;
    super.initState();
  }

  @override
  void dispose() {
    _topicController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(quizControllerProvider);

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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).canvasColor,
            ))
          : SingleChildScrollView(
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
                      controllerName: _topicController,
                      textFieldEvent: (value) => toggleButtton(),
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
                      controllerName: _descriptionController,
                      textFieldEvent: (value) => toggleButtton(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ThemeButton(
                      name: Strings.generateQuiz,
                      onPressed: generateQuizButtonState ? generateQuiz : null,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void generateQuiz() {
    Map<String, dynamic> map = {
      "topic": _topicController.text,
      "description": _descriptionController.text,
      "banner": ref.read(quizDataProvider)["banner"],
    };
    ref.read(quizDataProvider.notifier).state = map;
    ref.read(quizControllerProvider.notifier).generateQuiz(context);
  }

  void toggleButtton() {
    if (_topicController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      setState(() {
        generateQuizButtonState = true;
      });
    } else {
      setState(() {
        generateQuizButtonState = false;
      });
    }
  }
}
