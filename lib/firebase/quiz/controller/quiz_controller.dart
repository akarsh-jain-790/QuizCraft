import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_craft/firebase/quiz/api/generate_quiz.dart';
import 'package:quiz_craft/common_widgets/toast.dart';
import 'package:quiz_craft/firebase/quiz/repository/quiz_repository.dart';
import 'package:quiz_craft/models/quiz_model.dart';
import 'package:quiz_craft/screens/quizResult/quizResult.dart';
import 'package:quiz_craft/screens/findQuiz/find_quiz.dart';
import 'package:quiz_craft/screens/generateQuiz/generate_quiz.dart';
import 'package:quiz_craft/screens/saveQuiz/saved_quiz.dart';

final quizProvider = StateProvider<List<QuizModel?>?>((ref) => null);
final quizDataProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final quizAnswerProvider = StateProvider<Map<int, String>>((ref) => {});

final quizControllerProvider = StateNotifierProvider<QuizController, bool>(
  (ref) => QuizController(
      quizRepository: ref.read(quizRepositoryProvider),
      generateQuiz: ref.read(generateQuizProvider),
      ref: ref),
);

class QuizController extends StateNotifier<bool> {
  final QuizRepository _quizRepository;
  final GenerateQuiz _generateQuiz;
  final Ref _ref;

  QuizController({
    required QuizRepository quizRepository,
    required GenerateQuiz generateQuiz,
    required Ref ref,
  })  : _quizRepository = quizRepository,
        _generateQuiz = generateQuiz,
        _ref = ref,
        super(false);

  void generateQuiz(BuildContext context) async {
    //? state for butoon loading status.
    state = true;
    String isValid = "False";
    final validatePrompt =
        await _generateQuiz.validatePrompt(_ref.read(quizDataProvider));
    validatePrompt.fold(
        (l) => showToast(context, "Error", l.message, "warning"), (output) {
      isValid = output;
      if (isValid.contains("False")) {
        state = false;
        showToast(context, "Error", "Invalid prompt!", "warning");
      }
    });

    if (!isValid.contains("False")) {
      final generatedQuestions =
          await _generateQuiz.palmGenerateQuiz(_ref.read(quizDataProvider));
      state = false;

      generatedQuestions
          .fold((l) => showToast(context, "Error", l.message, "warning"),
              (questionList) {
        _ref.read(quizProvider.notifier).update((state) => questionList);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GenerateQuizUI()));
      });
    }
  }

  void generateSingleQuestion(BuildContext context) async {
    //? state for butoon loading status.
    state = true;
    final generatedQuestions =
        await _generateQuiz.generateSingleQuestion(_ref.read(quizDataProvider));
    state = false;

    //? checking if signed up successfully or not.
    generatedQuestions.fold(
        (l) => showToast(context, "Error", l.message, "warning"), (question) {
      _ref.read(currentQuestionProvider.notifier).update((state) => question);
    });
  }

  void saveQuizController(
      BuildContext context, Map<String, dynamic> quizData) async {
    //? state for butoon loading status.
    state = true;
    final saveQuiz = await _quizRepository.saveQuiz(quizData);
    state = false;

    //? checking if signed up successfully or not.
    saveQuiz.fold((l) => showToast(context, "Error", l.message, "warning"),
        (quizURL) {
      _ref.read(quizProvider.notifier).dispose();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SavedQuiz(quizURL: quizURL)));
    });
  }

  Future<String> saveImageController(BuildContext context, File image) async {
    //? state for butoon loading status.
    state = true;
    final saveImage = await _quizRepository.saveImage(image);
    state = false;
    String url = "";

    //? checking if signed up successfully or not.
    saveImage.fold((l) => showToast(context, "Error", l.message, "warning"),
        (imageURL) {
      url = imageURL;
    });

    return url;
  }

  void findQuizController(BuildContext context, String quizCode) async {
    //? state for butoon loading status.
    final findQuiz = await _quizRepository.findQuiz(quizCode);

    //? checking if signed up successfully or not.
    findQuiz.fold((l) => showToast(context, "Error", l.message, "warning"),
        (quizData) {
      if (quizData.isNotEmpty) {
        List<QuizModel?> quizDataList = [];
        for (Map<String, dynamic> map in quizData["quizData"]) {
          quizDataList.add(QuizModel.fromMap(map));
        }

        _ref.read(quizProvider.notifier).update((state) => quizDataList);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FindQuiz(
              quizName: quizData["quizName"],
              quizDescription: quizData["quizDescription"],
              banner: quizData["banner"],
            ),
          ),
        );
      }
    });
  }

  void quizResult(BuildContext context) {
    final answers = _ref.read(quizAnswerProvider);
    final quizAnwers = _ref.read(quizProvider);
    int score = 0;

    for (int i = 0; i < quizAnwers!.length; i++) {
      if (quizAnwers[i]?.correctOption == answers[i + 1]) {
        score++;
      }
    }

    _ref.read(quizAnswerProvider.notifier).update((state) => {});

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => QuizResult(quizScore: score)));
  }
}
