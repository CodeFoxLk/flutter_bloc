import 'package:flutter/material.dart';
import '../dialogs/generic_dialog.dart';

typedef OnLoginPress = void Function(String email, String password);

class LoginButton extends StatelessWidget {
  const LoginButton(
      {Key? key,
      required this.emailController,
      required this.passwordController,
      required this.onLoginPress})
      : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final OnLoginPress onLoginPress;

  @override
  Widget build(BuildContext context) {
    
    return ElevatedButton(onPressed: () {

       final email = emailController.text ;
       final password =  passwordController.text;
       
      if(emailController.text.isEmpty || passwordController.text.isEmpty){
        showGenericDialog(context: context, title: 'Please fill both email and password fields', content: '', optionsBuilder: () => {
          'Ok' : true
        });
        
      }else{
        onLoginPress(email, password);
      }
    }, child: const Text('Login'));
  }
}
