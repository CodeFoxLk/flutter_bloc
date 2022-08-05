import 'package:bloc_pattern/bloc-note_app/models/auth.dart';
import 'package:bloc_pattern/bloc-note_app/models/notes.dart';

abstract class NoteApiProtocol {
  const NoteApiProtocol();
  Future<Iterable<Note>?> getNotes({required LoginHandler loginHandler});
}

class NoteApi implements NoteApiProtocol {
  const NoteApi();
  @override
  Future<List<Note>?> getNotes({required LoginHandler loginHandler}) {
    final notes = Future.delayed(const Duration(seconds: 2), () => loginHandler == const LoginHandler.fooBar())
        .then((isLoggedIn) => isLoggedIn ? Note.notes : null);

    return notes;
  }
}
