import 'package:formz/formz.dart';

// Define input validation errors
enum EmailInputStatus { invalid, valid }

// Extend FormzInput and provide the input type and error type.
class EmailInput extends FormzInput<String, EmailInputStatus> {
  // Call super.pure to represent an unmodified form input.
  const EmailInput.pure({String value = ''}) : super.pure(value);

  // Call super.dirty to represent a modified form input.
  const EmailInput.dirty({String value = ''}) : super.dirty(value);


   static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );


  // Override validator to handle validating a given input value.
  @override
  EmailInputStatus? validator(String? value) {
    return _emailRegex.hasMatch(value ?? '')
        ?  null
        : EmailInputStatus.invalid;
  }
}