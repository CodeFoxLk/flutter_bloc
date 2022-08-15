import 'package:equatable/equatable.dart';

abstract class LoginFormEvents extends Equatable {
  const LoginFormEvents();

  @override
  List<Object> get props => [];
}

class EmailChangeEvent extends LoginFormEvents {
  const EmailChangeEvent(this.email);

  final String email;
}

//for copy paste validations
class EmailInputUnfocusEvent extends LoginFormEvents {
  const EmailInputUnfocusEvent();
}

class PasswordChangeEvent extends LoginFormEvents {
  const PasswordChangeEvent(this.password);
  final String password;
}

//for copy paste validations
class PasswordInputUnfocusEvents extends LoginFormEvents {
  const PasswordInputUnfocusEvents();
}

class SubmitEvent extends LoginFormEvents{
  const SubmitEvent();
}