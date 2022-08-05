import 'package:bloc_pattern/bloc-note_app/bloc/actions.dart';
import 'package:bloc_pattern/bloc-note_app/bloc/app_bloc.dart';
import 'package:bloc_pattern/bloc-note_app/views/email_text_field.dart';
import 'package:bloc_pattern/bloc-note_app/views/login_button.dart';
import 'package:bloc_pattern/bloc-note_app/views/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoingView extends HookWidget {
  const LoingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmailTextField(emailController: emailController),
          PasswordTextField(passwordController: passwordController),

          LoginButton(
              emailController: emailController,
              passwordController: passwordController,
              
              onLoginPress: (email, password) {
                context.read<AppBloc>().add(LoginAction(email: email, password: password));
              })
        ],
      ),
    );
  }
}
