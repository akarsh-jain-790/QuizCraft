import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_craft/common_widgets/social_button.dart';
import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/common_widgets/theme_textfield.dart';
import 'package:quiz_craft/firebase/auth/controller/auth_controller.dart';
import 'package:quiz_craft/helper/strings.dart';
import 'package:quiz_craft/screens/authentication/widgets/horizontal_or_line.dart';

class Authentication extends ConsumerStatefulWidget {
  const Authentication({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthenticationState();
}

class _AuthenticationState extends ConsumerState<Authentication> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late bool loginButtonState;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    loginButtonState = false;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      SocialButton(
                        name: Strings.loginWithGoogle,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        logo: 'assets/icons/google.svg',
                        onPressed: () => signInWithGoogle(),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SocialButton(
                        name: Strings.loginWithFacebook,
                        color: const Color.fromRGBO(66, 103, 178, 1),
                        logo: 'assets/icons/facebook.svg',
                        logoColor: true,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      HorizontalOrLine(
                        height: 0.0,
                        label: Strings.horizontalOrLineText,
                      ),
                      const SizedBox(
                        height: 20.0,
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
                            controllerName: _emailController,
                            textFieldEvent: (value) => toggleButtton(),
                            icon: Icons.mail_outline,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
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
                            controllerName: _passwordController,
                            passwordField: true,
                            textFieldEvent: (value) => toggleButtton(),
                            icon: Icons.lock_outline,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      ThemeButton(
                        name: Strings.loginText,
                        onPressed: loginButtonState
                            ? signInWithEmailAndPassword
                            : null,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        Strings.forgotPasswordText,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        Strings.termsAndConditionText,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void signInWithGoogle() {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  void signInWithEmailAndPassword() {
    Map<String, dynamic> userData = {
      "email": _emailController.text,
      "password": _passwordController.text
    };
    ref
        .read(authControllerProvider.notifier)
        .signInWithEmailAndPassword(context, userData);
  }

  void toggleButtton() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        loginButtonState = true;
      });
    } else {
      setState(() {
        loginButtonState = false;
      });
    }
  }
}
