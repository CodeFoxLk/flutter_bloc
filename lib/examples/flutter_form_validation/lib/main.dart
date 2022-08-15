import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_validation/bloc/login_bloc.dart';
import 'package:flutter_form_validation/views/login.dart';

void main(List<String> args) {
  runApp(const FormApp());
}

class FormApp extends StatelessWidget {
  const FormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(create: (_) => LoginBloc(), child: const LoginView(),),
    );
  }
}
