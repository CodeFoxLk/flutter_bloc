import 'package:bloc_pattern/bloc-note_app/models/auth.dart';
import 'package:bloc_pattern/bloc-note_app/models/notes.dart';
import 'package:collection/collection.dart';

class AppState {
  final bool isLoading;
  final LoginErrors? loginErrors;
  final LoginHandler? loginHandler;
  final Iterable<Note>? fetchedNotes;

  const AppState.empty()
      : isLoading = false,
        loginErrors = null,
        loginHandler = null,
        fetchedNotes = null;

 const AppState({
    required this.isLoading,
    required this.loginErrors,
    required this.loginHandler,
    required this.fetchedNotes,
  });

  @override
  String toString() => {
        'isLoading': isLoading,
        'loginError': loginErrors,
        'loginHandle': loginHandler
      }.toString();

  @override
  bool operator == (covariant AppState other) {
    final otherPropertiesAreEquals = isLoading == other.isLoading && loginErrors == other.loginErrors &&  loginHandler == other.loginHandler;
    
    if (fetchedNotes == null && other.fetchedNotes == null) {
      return otherPropertiesAreEquals;
    } else {
      return (otherPropertiesAreEquals && (fetchedNotes?.isEqualTo(other.fetchedNotes) ?? false));
    }
  }

  @override
  int get hashCode => Object.hash(isLoading, loginErrors, loginHandler, fetchedNotes);
}

extension UnorderedEquality on Object {
  bool isEqualTo(other) =>
      const DeepCollectionEquality.unordered().equals(this, other);
}
