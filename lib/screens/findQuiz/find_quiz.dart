import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/helper/strings.dart';

class FindQuiz extends StatelessWidget {
  const FindQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          Strings.joinQuizText,
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
                  "assets/icons/find_quiz.svg",
                  height: 300.0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                Strings.quizNameText,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 28.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: ColorSys.ksecondary,
                  borderRadius: const BorderRadius.all(Radius.circular(48)),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/question_mark.svg",
                      height: 20.0,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColor, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      Strings.numberOfQuestionsText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    SvgPicture.asset(
                      "assets/icons/timer.svg",
                      height: 20.0,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColor, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      Strings.timeText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
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
              Text(
                "Lorem ipsum dolor sit amet consectetur adipisicing elit. Nobis, eligendi corrupti, iste dolore ipsa officia eaque cupiditate deserunt et distinctio similique fugit! Commodi ad cupiditate eligendi deleniti amet vero inventore.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 40,
              ),
              ThemeButton(
                name: Strings.startQuizText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
