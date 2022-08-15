import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordInputStatus { invalid, valid }

// Extend FormzInput and provide the input type and error type.
class PasswordInput extends FormzInput<String, PasswordInputStatus> {
  // Call super.pure to represent an unmodified form input.
  const PasswordInput.pure({String value = ''}) : super.pure(value);

  // Call super.dirty to represent a modified form input.
  const PasswordInput.dirty({String value = ''}) : super.dirty(value);


  // Override validator to handle validating a given input value.
  @override
  PasswordInputStatus? validator(String? value) {
    
    final isValid = value != null && value.length > 8;
    return isValid ? null : PasswordInputStatus.invalid;
  }
}
