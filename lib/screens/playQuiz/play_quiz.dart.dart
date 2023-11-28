import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_craft/common_widgets/custom_text_form_field.dart';
import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/firebase/quiz/controller/quiz_controller.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/helper/strings.dart';
import 'package:quiz_craft/models/quiz_model.dart';
import 'package:quiz_craft/screens/playQuiz/widgets/paginator.dart';
import 'package:quiz_craft/screens/playQuiz/widgets/theme_radio_textfield.dart';

final pageCountProvider = StateProvider<int>((ref) => 1);
final currentQuestionProvider = StateProvider<QuizModel?>((ref) => ref
    .read(quizProvider)![ref.read(pageCountProvider) - 1]
    ?.copyWith(correctOption: ""));

class PlayQuiz extends ConsumerStatefulWidget {
  const PlayQuiz({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GenerateQuizUIState();
}

class _GenerateQuizUIState extends ConsumerState<PlayQuiz> {
  TextEditingController questionController = TextEditingController();
  TextEditingController optionOneController = TextEditingController();
  TextEditingController optionTwoController = TextEditingController();
  TextEditingController optionThreeController = TextEditingController();
  TextEditingController optionFourController = TextEditingController();
  String answer = "";

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
        backgroundColor: const Color.fromARGB(0, 191, 189, 189),
        elevation: 0.0,
        title: Text(
          Strings.createQuizText,
        ),
        automaticallyImplyLeading: false,
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Paginator(
                paginatorEvent: (page) {
                  nextPageToggle(page);
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
              ThemeRadioButton(
                fieldName: Strings.option1Text,
                controllerName: optionOneController,
                icon: Icons.circle_outlined,
                enabled: false,
                border: true,
                groupValue: ref.read(currentQuestionProvider)!.correctOption,
                optionValue: ref.read(currentQuestionProvider)!.optionOne,
                radioFieldEvent: () {
                  answer = ref.read(currentQuestionProvider)!.optionOne;
                  ref.read(currentQuestionProvider.notifier).state = ref
                      .read(currentQuestionProvider.notifier)
                      .state
                      ?.copyWith(
                          correctOption:
                              ref.read(currentQuestionProvider)!.optionOne);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ThemeRadioButton(
                fieldName: Strings.option2Text,
                controllerName: optionTwoController,
                icon: Icons.circle_outlined,
                border: true,
                enabled: false,
                groupValue: ref.read(currentQuestionProvider)!.correctOption,
                optionValue: ref.read(currentQuestionProvider)!.optionTwo,
                radioFieldEvent: () {
                  answer = ref.read(currentQuestionProvider)!.optionTwo;
                  ref.read(currentQuestionProvider.notifier).state = ref
                      .read(currentQuestionProvider.notifier)
                      .state
                      ?.copyWith(
                          correctOption:
                              ref.read(currentQuestionProvider)!.optionTwo);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ThemeRadioButton(
                fieldName: Strings.option3Text,
                controllerName: optionThreeController,
                icon: Icons.circle_outlined,
                border: true,
                enabled: false,
                groupValue: ref.read(currentQuestionProvider)!.correctOption,
                optionValue: ref.read(currentQuestionProvider)!.optionThree,
                radioFieldEvent: () {
                  answer = ref.read(currentQuestionProvider)!.optionThree;
                  ref.read(currentQuestionProvider.notifier).state = ref
                      .read(currentQuestionProvider.notifier)
                      .state
                      ?.copyWith(
                          correctOption:
                              ref.read(currentQuestionProvider)!.optionThree);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ThemeRadioButton(
                fieldName: Strings.option4Text,
                controllerName: optionFourController,
                icon: Icons.circle_outlined,
                border: true,
                enabled: false,
                groupValue: ref.read(currentQuestionProvider)!.correctOption,
                optionValue: ref.read(currentQuestionProvider)!.optionFour,
                radioFieldEvent: () {
                  answer = ref.read(currentQuestionProvider)!.optionFour;
                  ref.read(currentQuestionProvider.notifier).state = ref
                      .read(currentQuestionProvider.notifier)
                      .state
                      ?.copyWith(
                          correctOption:
                              ref.read(currentQuestionProvider)!.optionFour);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ref.read(pageCountProvider) == 10
                  ? ThemeButton(
                      name: Strings.submitQuizText,
                      onPressed: () {
                        ref
                            .read(pageCountProvider.notifier)
                            .update((state) => 1);

                        ref.read(currentQuestionProvider.notifier).update(
                            (state) => ref
                                .read(quizProvider)![
                                    ref.read(pageCountProvider) - 1]
                                ?.copyWith(correctOption: ""));

                        ref
                            .read(quizControllerProvider.notifier)
                            .quizResult(context);
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void nextPageToggle(int page) {
    //? Adding answer to the answer option.
    Map<int, String> answers = ref.read(quizAnswerProvider);
    answers.update(
        ref.read(pageCountProvider), (value) => value != "" ? value : answer,
        ifAbsent: () => answer);

    ref.read(quizAnswerProvider.notifier).state = answers;

    //? Increase the page counter provider value.
    ref.read(pageCountProvider.notifier).state = page;

    //? Change the value of currentQuestionProvider with the new question data.
    ref.read(currentQuestionProvider.notifier).state = ref
        .read(quizProvider)![ref.read(pageCountProvider) - 1]
        ?.copyWith(
            correctOption:
                ref.read(quizAnswerProvider)[ref.read(pageCountProvider)] ??
                    "");

    answer = "";
  }
}
