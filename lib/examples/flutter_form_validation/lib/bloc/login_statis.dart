import 'package:equatable/equatable.dart';
import 'package:flutter_form_validation/models/email.dart';
import 'package:flutter_form_validation/models/password.dart';
import 'package:formz/formz.dart';

class LoginStatus extends Equatable{
   const LoginStatus({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.status = FormzStatus.invalid,
  });

  
 
  final EmailInput email;
  final PasswordInput password;
  final FormzStatus status;

  LoginStatus copyWith({
    EmailInput? email,
    PasswordInput? password,
    FormzStatus? status,
  }) {
    return LoginStatus(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}