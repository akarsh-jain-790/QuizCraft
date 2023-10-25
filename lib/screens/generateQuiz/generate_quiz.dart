import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_craft/common_widgets/custom_text_form_field.dart';
import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/firebase/quiz/controller/quiz_controller.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/helper/strings.dart';
import 'package:quiz_craft/models/quiz_model.dart';
import 'package:quiz_craft/screens/generateQuiz/widgets/paginator.dart';
import 'package:quiz_craft/screens/generateQuiz/widgets/theme_radio_textfield.dart';
import 'package:quiz_craft/screens/reviewAndSave/review_and_save.dart';

final pageCountProvider = StateProvider<int>((ref) => 1);
final currentQuestionProvider = StateProvider<QuizModel?>(
    (ref) => ref.read(quizProvider)![ref.read(pageCountProvider) - 1]);

class GenerateQuizUI extends ConsumerStatefulWidget {
  const GenerateQuizUI({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GenerateQuizUIState();
}

class _GenerateQuizUIState extends ConsumerState<GenerateQuizUI> {
  TextEditingController questionController = TextEditingController();
  TextEditingController optionOneController = TextEditingController();
  TextEditingController optionTwoController = TextEditingController();
  TextEditingController optionThreeController = TextEditingController();
  TextEditingController optionFourController = TextEditingController();

  @override
  void initState() {
    questionController = TextEditingController();
    optionOneController = TextEditingController();
    optionTwoController = TextEditingController();
    optionThreeController = TextEditingController();
    optionFourController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    questionController.dispose();
    optionOneController.dispose();
    optionTwoController.dispose();
    optionThreeController.dispose();
    optionFourController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    questionController.text = ref.watch(currentQuestionProvider)!.question;
    optionOneController.text = ref.watch(currentQuestionProvider)!.optionOne;
    optionTwoController.text = ref.watch(currentQuestionProvider)!.optionTwo;
    optionThreeController.text =
        ref.watch(currentQuestionProvider)!.optionThree;
    optionFourController.text = ref.watch(currentQuestionProvider)!.optionFour;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          Strings.createQuizText,
        ),
        actions: [
          GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReviewAndSave()),
              ),
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                Strings.saveButtonText,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: ColorSys.kwhite, fontSize: 18),
              ),
            ),
          ),
        ],
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
            children: [
              Paginator(
                paginatorEvent: (page) {
                  //? Updating the value of current question.
                  ref.read(currentQuestionProvider.notifier).state = ref
                      .read(currentQuestionProvider.notifier)
                      .state
                      ?.copyWith(
                        question: questionController.text,
                        optionOne: optionOneController.text,
                        optionTwo: optionTwoController.text,
                        optionThree: optionThreeController.text,
                        optionFour: optionFourController.text,
                      );

                  //? Updating the value of the global Quiz Provider with the current question.
                  ref
                          .read(quizProvider.notifier)
                          .state![ref.read(pageCountProvider) - 1] =
                      ref.read(currentQuestionProvider);

                  //? Increase the page counter provider value.
                  ref.read(pageCountProvider.notifier).state = page;

                  //? Change the value of currentQuestionProvider with the new question data.
                  ref.read(currentQuestionProvider.notifier).state =
                      ref.read(quizProvider)![ref.read(pageCountProvider) - 1];
                },
              ),
              const SizedBox(
                height: 40.0,
              ),
              CustomTextFormField(
                fieldName: Strings.questionText,
                controllerName: questionController,
                fieldHeight: 200.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              ThemeRadioTextField(
                fieldName: Strings.option1Text,
                controllerName: optionOneController,
                icon: Icons.circle_outlined,
                border: true,
                groupValue: ref.read(currentQuestionProvider)!.correctOption,
                optionValue: ref.read(currentQuestionProvider)!.optionOne,
                radioFieldEvent: (String value) {
                  ref.read(currentQuestionProvider.notifier).state = ref
                      .read(currentQuestionProvider.notifier)
                      .state
                      ?.copyWith(correctOption: value);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ThemeRadioTextField(
                fieldName: Strings.option2Text,
                controllerName: optionTwoController,
                icon: Icons.circle_outlined,
                border: true,
                groupValue: ref.read(currentQuestionProvider)!.correctOption,
                optionValue: ref.read(currentQuestionProvider)!.optionTwo,
                radioFieldEvent: (String value) {
                  ref.read(currentQuestionProvider.notifier).state = ref
                      .read(currentQuestionProvider.notifier)
                      .state
                      ?.copyWith(correctOption: value);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ThemeRadioTextField(
                fieldName: Strings.option3Text,
                controllerName: optionThreeController,
                icon: Icons.circle_outlined,
                border: true,
                groupValue: ref.read(currentQuestionProvider)!.correctOption,
                optionValue: ref.read(currentQuestionProvider)!.optionThree,
                radioFieldEvent: (String value) {
                  ref.read(currentQuestionProvider.notifier).state = ref
                      .read(currentQuestionProvider.notifier)
                      .state
                      ?.copyWith(correctOption: value);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ThemeRadioTextField(
                fieldName: Strings.option4Text,
                controllerName: optionFourController,
                icon: Icons.circle_outlined,
                border: true,
                groupValue: ref.read(currentQuestionProvider)!.correctOption,
                optionValue: ref.read(currentQuestionProvider)!.optionFour,
                radioFieldEvent: (String value) {
                  ref.read(currentQuestionProvider.notifier).state = ref
                      .read(currentQuestionProvider.notifier)
                      .state
                      ?.copyWith(correctOption: value);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ThemeButton(
                name: Strings.regenerateButtonText,
                onPressed: () => regenerateQuestion(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void regenerateQuestion() {
    ref.read(quizControllerProvider.notifier).generateSingleQuestion(context);
  }
}
