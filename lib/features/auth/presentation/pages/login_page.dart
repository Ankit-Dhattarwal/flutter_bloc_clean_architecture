import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/theme/appColors.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/widgets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In.',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              AuthField(
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(
                height: 15,
              ),
              AuthField(
                hintText: 'Password',
                controller: passwordController,
                isObscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
               AuthGradientButton(btnText: 'Sign In', onPressedCallback: () {  },),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    SignupPage.route(),
                  );
                },
                child: RichText(
                    text: TextSpan(
                  text: 'Don\'t have an account?\t\t',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.gradient2,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
