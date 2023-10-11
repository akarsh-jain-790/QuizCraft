import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_craft/common_widgets/theme_button.dart';
import 'package:quiz_craft/common_widgets/theme_textfield.dart';
import 'package:quiz_craft/firebase/auth/controller/auth_controller.dart';
import 'package:quiz_craft/helper/strings.dart';
import 'package:quiz_craft/screens/home/home.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signUpWithEmailAndPassword(BuildContext context, WidgetRef ref) {
    Map<String, dynamic> userData = {
      "displayName": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text
    };

    ref
        .read(authControllerProvider.notifier)
        .signUpWithEmailAndPassword(context, userData);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Home()));
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
              : Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.nameText,
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
                            fieldName: Strings.namePlaceholder,
                            icon: Icons.person_2_outlined,
                            controllerName: _nameController,
                          ),
                        ],
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
                            controllerName: _emailController,
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
                            passwordField: true,
                            icon: Icons.lock_outline,
                            controllerName: _passwordController,
                          ),
                        ],
                      ),
                      ThemeButton(
                        name: Strings.signUpText,
                        onPressed: () =>
                            signUpWithEmailAndPassword(context, ref),
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
