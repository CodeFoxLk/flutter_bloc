abstract class AppActions {
  const AppActions();
}

class LoginAction extends AppActions {
  final String email;
  final String password;

  const LoginAction({required this.email, required this.password});
}

class LoadNoteAction extends AppActions{
  const LoadNoteAction();
}