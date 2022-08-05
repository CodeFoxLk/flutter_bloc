import 'package:bloc_pattern/bloc-note_app/apis/login_api.dart';
import 'package:bloc_pattern/bloc-note_app/apis/note_api.dart';
import 'package:bloc_pattern/bloc-note_app/bloc/actions.dart';
import 'package:bloc_pattern/bloc-note_app/bloc/app_bloc.dart';
import 'package:bloc_pattern/bloc-note_app/bloc/app_state.dart';
import 'package:bloc_pattern/bloc-note_app/models/auth.dart';
import 'package:bloc_pattern/bloc-note_app/models/notes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  blocTest<AppBloc, AppState>(
    'Initialing bloc',
    build: () => AppBloc(
        acceptedLoginHandle: const LoginHandler.fooBar(),
        loginApiProtocol: const DummyLoginApi.empty(),
        noteApiProtocol: const DummyNoteApi.empty()),
    verify: (bloc) => expect(bloc.state, const AppState.empty()),
  );

  blocTest<AppBloc, AppState>(
    'Can we login with correct credentias',
    build: () => AppBloc(
        acceptedLoginHandle: const LoginHandler.fooBar(),
        loginApiProtocol: const DummyLoginApi(
            acceptedEmail: 'foo@bar.com',
            accepredPassword: 'foobar',
            handleToReturn: acceptableLoginHandler),
        noteApiProtocol: const DummyNoteApi.empty()),
    act: (bloc) =>
        bloc.add(const LoginAction(email: 'foo@bar.com', password: 'foobar')),
    expect: () => [
      const AppState(
          isLoading: true,
          loginErrors: null,
          loginHandler: null,
          fetchedNotes: null),
      const AppState(
          isLoading: false,
          loginErrors: null,
          loginHandler: acceptableLoginHandler,
          fetchedNotes: null)
    ],
  );

  blocTest<AppBloc, AppState>(
    'Can we login with INVALID credentias',
    build: () => AppBloc(
        acceptedLoginHandle: acceptableLoginHandler,
        loginApiProtocol: const DummyLoginApi(
            acceptedEmail: 'foo@bar.com',
            accepredPassword: 'barfoo',
            handleToReturn: acceptableLoginHandler),
        noteApiProtocol: const DummyNoteApi.empty()),
    act: (bloc) =>
        bloc.add(const LoginAction(email: 'foo@bar.com', password: 'foobar')),
    expect: () => [
      const AppState(
          isLoading: true,
          loginErrors: null,
          loginHandler: null,
          fetchedNotes: null),
      const AppState(
          isLoading: false,
          loginErrors: LoginErrors.authError,
          loginHandler: null,
          fetchedNotes: null)
    ],
  );

  blocTest<AppBloc, AppState>(
    'load notes with correct credentias',
    build: () {
      return AppBloc(
          acceptedLoginHandle: acceptableLoginHandler,
          loginApiProtocol: const DummyLoginApi(
              acceptedEmail: 'foo@bar.com',
              accepredPassword: 'foobar',
              handleToReturn: acceptableLoginHandler),
          noteApiProtocol: const DummyNoteApi(
              acceptedLoginHandle: acceptableLoginHandler,
              notesToReturnForAcceptedLoginHandle: notes));
    },
    act: (bloc) {
      bloc.add(const LoginAction(email: 'foo@bar.com', password: 'foobar'));
      bloc.add(const LoadNoteAction());
    },
    expect: () => [
      const AppState(
        isLoading: true,
        fetchedNotes: null,
        loginErrors: null,
        loginHandler: null,
      ),
      const AppState(
          isLoading: false,
          loginErrors: null,
          loginHandler: acceptableLoginHandler,
          fetchedNotes: null),
      const AppState(
          isLoading: true,
          loginErrors: null,
          loginHandler: acceptableLoginHandler,
          fetchedNotes: null),
      const AppState(
          isLoading: false,
          loginErrors: null,
          loginHandler: acceptableLoginHandler,
          fetchedNotes: notes)
    ],
  );
}

const acceptableLoginHandler = LoginHandler(token: 'ABC');

const Iterable<Note> notes = [
  Note(title: 'A'),
  Note(title: 'B'),
  Note(title: 'C'),
  Note(title: 'D')
];

class DummyNoteApi implements NoteApiProtocol {
  final LoginHandler acceptedLoginHandle;
  final Iterable<Note>? notesToReturnForAcceptedLoginHandle;

  const DummyNoteApi(
      {required this.acceptedLoginHandle,
      required this.notesToReturnForAcceptedLoginHandle});

  const DummyNoteApi.empty()
      : acceptedLoginHandle = const LoginHandler.fooBar(),
        notesToReturnForAcceptedLoginHandle = null;

  @override
  Future<Iterable<Note>?> getNotes({required LoginHandler loginHandler}) async {
    if (loginHandler == acceptedLoginHandle) {
      return notes;
    }
    return null;
  }
}

class DummyLoginApi extends LoginApiProtocol {
  final String acceptedEmail;
  final String accepredPassword;
  final LoginHandler handleToReturn;

  const DummyLoginApi(
      {required this.acceptedEmail,
      required this.accepredPassword,
      required this.handleToReturn});

  const DummyLoginApi.empty()
      : accepredPassword = '',
        acceptedEmail = '',
        handleToReturn = const LoginHandler(token: 'ABC');

  @override
  Future<LoginHandler?> login(
      {required String email, required String password}) async {
    if (email == acceptedEmail && password == accepredPassword) {
      return handleToReturn;
    }
    return null;
  }
}
