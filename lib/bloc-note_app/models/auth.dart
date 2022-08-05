//login handle
enum LoginErrors {
  authError(errorMessage: 'Token expired');

  final String errorMessage;

  const LoginErrors({required this.errorMessage});
}

class LoginHandler {
  final String token;
  const LoginHandler({required this.token});
  
  const LoginHandler.fooBar() : token = 'foobar';

  @override
  bool operator == (covariant LoginHandler other) => token == other.token;

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() {
    return 'Instance of Auth and the auth token is $token';
  }
}


