import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_craft/common_widgets/social_button.dart';
import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/common_widgets/theme_textfield.dart';
import 'package:quiz_craft/firebase/auth/controller/auth_controller.dart';
import 'package:quiz_craft/helper/strings.dart';
import 'package:quiz_craft/screens/authentication/widgets/horizontal_or_line.dart';
import 'package:quiz_craft/screens/home/home.dart';

class Authentication extends ConsumerWidget {
  const Authentication({super.key});

  void signInWithGoogle(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(Strings.loginText),
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onSurface),
      ),
      body: SafeArea(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SocialButton(
                        name: Strings.loginWithGoogle,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        logo: 'assets/icons/google.svg',
                        onPressed: () => signInWithGoogle(context, ref),
                      ),
                      SocialButton(
                        name: Strings.loginWithFacebook,
                        color: const Color.fromRGBO(66, 103, 178, 1),
                        logo: 'assets/icons/facebook.svg',
                        logoColor: true,
                      ),
                      HorizontalOrLine(
                        height: 0.0,
                        label: Strings.horizontalOrLineText,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.emailText,
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
                            fieldName: Strings.emailPlaceholder,
                            icon: Icons.mail_outline,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.passwordText,
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
                            fieldName: Strings.passwordPlaceholder,
                            icon: Icons.lock_outline,
                          ),
                        ],
                      ),
                      ThemeButton(
                        name: Strings.loginText,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home())),
                      ),
                      Text(
                        Strings.forgotPasswordText,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        Strings.termsAndConditionText,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )),
    );
  }
}
