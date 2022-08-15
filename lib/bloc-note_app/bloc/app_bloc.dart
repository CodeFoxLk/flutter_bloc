import 'package:bloc/bloc.dart';
import 'package:bloc_pattern/bloc-note_app/apis/login_api.dart';
import 'package:bloc_pattern/bloc-note_app/apis/note_api.dart';
import 'package:bloc_pattern/bloc-note_app/bloc/actions.dart';
import 'package:bloc_pattern/bloc-note_app/bloc/app_state.dart';
import 'package:bloc_pattern/bloc-note_app/models/auth.dart';


class AppBloc extends Bloc<AppActions, AppState> {
  final LoginApiProtocol loginApiProtocol;
  final NoteApiProtocol noteApiProtocol;
  final LoginHandler acceptedLoginHandle;

  AppBloc({required this.loginApiProtocol, required this.noteApiProtocol, required this.acceptedLoginHandle, })
      : super(const AppState.empty()) {
    on<LoginAction>((event, emit) => loginAction(event, emit));
    on<LoadNoteAction>(loadNotesAction);
  }

  Future<bool> loginAction(LoginAction event, Emitter<AppState> emit) async {
    //loading state
    emit(const AppState(
        isLoading: true,
        loginErrors: null,
        loginHandler: null,
        fetchedNotes: null));

    final loginHandler = await loginApiProtocol.login(email: event.email, password: event.password);

    emit(AppState(
        isLoading: false,
        loginErrors: (loginHandler == null) ? LoginErrors.authError : null,
        loginHandler: loginHandler,
        fetchedNotes: null)); 


    return true;
    // if(loginHandler != null){
    //   add(const LoadNoteAction());  
    // }
  }

  void loadNotesAction(LoadNoteAction event, Emitter<AppState> emit) async {
    
    //loading state
    emit(AppState(
        isLoading: true,
        loginErrors: null,
        loginHandler: state.loginHandler, // login handler of AppState. at this point current active state is, the state emmited in login action
        fetchedNotes: null));

    final loginHandle = state.loginHandler;

   

   
    // invalid login data, Cannot fetch
    if (loginHandle != acceptedLoginHandle) {
      emit(AppState(
          isLoading: false,
          loginErrors: LoginErrors.authError,
          loginHandler: state.loginHandler,
          fetchedNotes: null));
      return;
    }

    //fetch notes
    final notes = await noteApiProtocol.getNotes(loginHandler: state.loginHandler!);
    emit(AppState(
          isLoading: false,
          loginErrors: null,
          loginHandler: state.loginHandler,
          fetchedNotes: notes));

  }
}
