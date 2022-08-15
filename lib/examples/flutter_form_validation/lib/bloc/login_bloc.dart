import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_validation/bloc/login_events.dart';
import 'package:flutter_form_validation/bloc/login_statis.dart';
import 'package:flutter_form_validation/models/email.dart';
import 'package:flutter_form_validation/models/password.dart';
import 'package:formz/formz.dart';

class LoginBloc extends Bloc<LoginFormEvents, LoginStatus> {

  LoginBloc() : super(const LoginStatus()) {
    on<EmailChangeEvent>(_onEmailChange);
    on<PasswordChangeEvent>(_onPasswordChange);
    on<EmailInputUnfocusEvent>(_onEmailUnfocused);
    on<PasswordInputUnfocusEvents>(_onPasswordUnfocused);
    on<SubmitEvent>(_onSubmit);
  }

  void _onEmailChange(EmailChangeEvent event, Emitter<LoginStatus> emit) {
    final email = EmailInput.dirty(value: event.email);

    emit(
      state.copyWith(
        email: email.valid ? email : EmailInput.pure(value: event.email),
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void _onPasswordChange(
    PasswordChangeEvent event,
    Emitter<LoginStatus> emit,
  ) {
    final password = PasswordInput.dirty(value: event.password);
    emit(
      state.copyWith(
        password: password.valid
            ? password
            : PasswordInput.pure(value: event.password),
        status: Formz.validate([password, state.password]),
      ),
    );
  }

  //for copy paste validations
  void _onEmailUnfocused(
    EmailInputUnfocusEvent event,
    Emitter<LoginStatus> emit,
  ) {
    final email = EmailInput.dirty(value: state.email.value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  //for copy paste validations
  void _onPasswordUnfocused(
    PasswordInputUnfocusEvents event,
    Emitter<LoginStatus> emit,
  ) {
    final password = PasswordInput.dirty(value: state.password.value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  void _onSubmit(
    SubmitEvent event,
    Emitter<LoginStatus> emit,
  ) {
    
    if (!state.status.isInvalid) {
        print('xxxx');
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
        ),
      );
    }
  }
}
