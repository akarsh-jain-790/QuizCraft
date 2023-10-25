import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_craft/helper/failure.dart';
import 'package:quiz_craft/helper/type_deft.dart';
import 'package:quiz_craft/models/quiz_model.dart';

//? We don't want to create Instance of the class everytime so creating a Provider for it.
final generateQuizProvider = Provider(
  (ref) => GenerateQuiz(),
);

class GenerateQuiz {
  FutureEither<String> validatePrompt(Map<String, dynamic> quizData) async {
    const String apiUrl =
        'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText?key=AIzaSyDSAfh6Wihy4EsD3G-B72W6hPecubAOq5s';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      "prompt": {
        "text":
            "Verify the validity of the provided quiz title [$quizData['topic']]  and description [$quizData['description']]; return True if they meet the criteria, otherwise return False. Output should be a Single word no other word.",
      }
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Parse the response JSON
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      // Extract the 'output' field
      String output = responseData['candidates'][0]['output'];

      return right(output);
    } else {
      //? returns the error to the controller.
      return left(
          Failure('Error: ${response.statusCode} - ${response.reasonPhrase}'));
    }
  }

  FutureEither<List<QuizModel?>> palmGenerateQuiz(
      Map<String, dynamic> quizData) async {
    const String apiUrl =
        'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText?key=AIzaSyDSAfh6Wihy4EsD3G-B72W6hPecubAOq5s';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      "prompt": {
        "text":
            "Generate 10 questions about the topic ${quizData["topic"]} and its description ${quizData["description"]}. Each question should have 4 options, and the correct answer should be one of the options. The output should be a JSON object with the following keys question, options, correct_answer",
      }
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Parse the response JSON
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      // Extract the 'output' field
      String output =
          responseData['candidates'][0]['output'].replaceFirst("```json", "");
      output = output.replaceFirst("```", "");

      List outputList = json.decode(output);
      List<QuizModel?> questionsList = [];

      for (Map<String, dynamic> map in outputList) {
        QuizModel quizModel = QuizModel(
          map["question"].replaceAll('"', ''),
          map["options"][0],
          map["options"][1],
          map["options"][2],
          map["options"][3],
          map["correct_answer"],
        );
        questionsList.add(quizModel);
      }
      return right(questionsList);
    } else {
      //? returns the error to the controller.
      return left(
          Failure('Error: ${response.statusCode} - ${response.reasonPhrase}'));
    }
  }

  FutureEither<QuizModel?> generateSingleQuestion(
      Map<String, dynamic> quizData) async {
    const String apiUrl =
        'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText?key=AIzaSyDSAfh6Wihy4EsD3G-B72W6hPecubAOq5s';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      "prompt": {
        "text":
            "Generate 1 questions about the topic ${quizData["topic"]} and its description ${quizData["description"]}. Each question should have 4 options, and the correct answer should be one of the options. The output should be a JSON object with the following keys question, options, correct_answer",
      }
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Parse the response JSON
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      // Extract the 'output' field
      String output =
          responseData['candidates'][0]['output'].replaceFirst("```json", "");
      output = output.replaceFirst("```", "");

      Map<String, dynamic> map = json.decode(output);

      QuizModel quizModel = QuizModel(
        map["question"].replaceAll('"', ''),
        map["options"][0],
        map["options"][1],
        map["options"][2],
        map["options"][3],
        map["correct_answer"],
      );

      return right(quizModel);
    } else {
      //? returns the error to the controller.
      return left(
          Failure('Error: ${response.statusCode} - ${response.reasonPhrase}'));
    }
  }
}
