import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class LoadAction {
  const LoadAction();
}

class LoadUserAction extends LoadAction {}

class TestUserAction extends LoadAction{}