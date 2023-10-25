import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/common_widgets/theme_textfield.dart';
import 'package:quiz_craft/firebase/auth/controller/auth_controller.dart';
import 'package:quiz_craft/helper/strings.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late bool signUpButtonState;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    signUpButtonState = false;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
        title: Text(Strings.signUpText),
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
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 40.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Strings.nameText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ThemeTextField(
                        fieldName: Strings.namePlaceholder,
                        icon: Icons.person_2_outlined,
                        controllerName: _nameController,
                        textFieldEvent: (value) => toggleButtton(),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Strings.emailText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ThemeTextField(
                        fieldName: Strings.emailPlaceholder,
                        icon: Icons.mail_outline,
                        controllerName: _emailController,
                        textFieldEvent: (value) => toggleButtton(),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Strings.passwordText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ThemeTextField(
                        fieldName: Strings.passwordPlaceholder,
                        passwordField: true,
                        icon: Icons.lock_outline,
                        controllerName: _passwordController,
                        textFieldEvent: (value) => toggleButtton(),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      ThemeButton(
                        name: Strings.signUpText,
                        onPressed: signUpButtonState
                            ? signUpWithEmailAndPassword
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

  void signUpWithEmailAndPassword() {
    Map<String, dynamic> userData = {
      "displayName": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text
    };

    ref
        .read(authControllerProvider.notifier)
        .signUpWithEmailAndPassword(context, userData);
  }

  void toggleButtton() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        signUpButtonState = true;
      });
    } else {
      setState(() {
        signUpButtonState = false;
      });
    }
  }
}
