import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_validation/bloc/login_bloc.dart';
import 'package:flutter_form_validation/bloc/login_events.dart';
import 'package:flutter_form_validation/bloc/login_statis.dart';
import 'package:formz/formz.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<LoginBloc>().add(const EmailInputUnfocusEvent());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<LoginBloc>().add(const PasswordInputUnfocusEvents());
      }
    });
  }

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          BlocBuilder<LoginBloc, LoginStatus>(
            builder: (context, state) => Column(
              children: [
                TextField(
                  focusNode: _emailFocusNode,
                  decoration: InputDecoration(
                    helperText: 'Email',
                    errorText: state.email.invalid ? 'Invalid email' : null,
                  ),
                  onChanged: (email) => context.read<LoginBloc>().add(
                        EmailChangeEvent(email),
                      ),
                ),
                TextField(
                  focusNode: _passwordFocusNode,
                  decoration: InputDecoration(
                    helperText: 'Password',
                    errorText: state.password.invalid
                        ? 'Invalid password - min 8 characters'
                        : null,
                  ),
                  onChanged: (password) => context.read<LoginBloc>().add(
                        PasswordChangeEvent(password),
                      ),
                )
              ],
            ),
          ),
          BlocConsumer<LoginBloc, LoginStatus>(
            buildWhen: (previous, current) => previous.status != current.status,
            listenWhen : (previous, current) => current.status.isSubmissionSuccess,
            listener: (_, status) {
                print('ssss');
              const snackBar =  SnackBar(
                content: Text('Login success'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },

            builder: (context, state) => ElevatedButton(
              onPressed: state.status.isInvalid ? null : () {
                context.read<LoginBloc>().add(const SubmitEvent());
              },
              child: const Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}
