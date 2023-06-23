import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_craft/screens/widgets/login_card.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(alignment: AlignmentDirectional.center, children: [
        SvgPicture.asset(
          "assets/images/onboardingBg.svg",
          width: 500,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 150.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                "assets/icons/onboarding.svg",
              ),
              const LoginCard(),
            ],
          ),
        )
      ]),
    );
  }
}
