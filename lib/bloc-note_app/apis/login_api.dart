import 'package:bloc_pattern/bloc-note_app/models/auth.dart';


abstract class LoginApiProtocol {
  const LoginApiProtocol();
  Future<LoginHandler?> login({required String email, required String password});
}

class LoginHandlerApi extends LoginApiProtocol {

  // LoginHandlerApi._singleton();
  // static get getInstance => LoginHandlerApi._singleton();
  // factory LoginHandlerApi.instance() => getInstance;

  @override
  Future<LoginHandler?> login({required String email, required String password}) {
    final foo = Future.delayed(const Duration(seconds: 2), () => email == 'foo@bar.com' && password == 'foobar')
        .then((isLoggedIn) => isLoggedIn ? const LoginHandler.fooBar() : null);

    return foo;
  }
}
