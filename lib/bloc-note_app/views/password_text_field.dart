import 'package:flutter/material.dart';


class PasswordTextField extends StatelessWidget {
  const PasswordTextField({Key? key, required this.passwordController}) : super(key: key);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      obscuringCharacter:'⁙',
      obscureText: true,
      autocorrect: false,
      decoration: const InputDecoration(
        hintText: 'Enter your password here' 
      ),
    );
  }
}