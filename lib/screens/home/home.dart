import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/helper/strings.dart';
import 'package:quiz_craft/screens/home/widget/join_quiz_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset("assets/icons/logo.svg"),
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: JoinQuizCard(),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ThemeButton(
                name: Strings.createQuizButtonText,
                buttonColor: ColorSys.kwhite,
                textColor: ColorSys.kblack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
