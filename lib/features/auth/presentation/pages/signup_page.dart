import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/theme/appColors.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/presentation/widgets/auth_gradient_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up.',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const AuthField(
              hintText: 'Name',
            ),
            const SizedBox(
              height: 15,
            ),
            const AuthField(
              hintText: 'Email',
            ),
            const SizedBox(
              height: 15,
            ),
            const AuthField(
              hintText: 'Password',
            ),
            const SizedBox(
              height: 20,
            ),
            const AuthGradientButton(),
            const SizedBox(
              height: 20,
            ),
            RichText(
                text: TextSpan(
              text: 'Don\'t have an account?\t\t',
              style: Theme.of(context).textTheme.titleMedium,
              children: [
                TextSpan(
                  text: 'Sign In',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.gradient2,
                        fontWeight: FontWeight.bold,
                      ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
