import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/theme/appColors.dart';

class AuthGradientButton extends StatelessWidget {
  final btnText;
  const AuthGradientButton({super.key, required this.btnText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        gradient: const LinearGradient(
            colors: [
          AppColors.gradient1,
          AppColors.gradient2,
        ],
          begin: Alignment.bottomLeft, end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
          onPressed: () {},
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: AppColors.transparentColor,
          shadowColor: AppColors.transparentColor,
        ),
        child: Text(btnText, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),

      ),
    );
  }
}
