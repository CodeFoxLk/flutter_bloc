import 'package:bloc_pattern/bloc-note_app/bloc/actions.dart';
import 'package:bloc_pattern/bloc-note_app/bloc/app_bloc.dart';
import 'package:bloc_pattern/bloc-note_app/bloc/app_state.dart';
import 'package:bloc_pattern/bloc-note_app/models/auth.dart';
import 'package:bloc_pattern/bloc-note_app/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'apis/login_api.dart';
import 'apis/note_api.dart';
import 'dialogs/generic_dialog.dart';
import 'dialogs/loading_screen.dart';
import 'views/iterable_list_view.dart';

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NoteAppHomePage(),
    );
  }
}

class NoteAppHomePage extends StatelessWidget {
  const NoteAppHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppBloc(
        acceptedLoginHandle: const LoginHandler.fooBar(),
          loginApiProtocol: LoginHandlerApi(), noteApiProtocol: const NoteApi()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          builder: (context, state) {
            final notes = state.fetchedNotes;
            if(notes == null){
              return const LoingView();
            }
            return state.fetchedNotes!.toListView();
          },


          listener: (context, state) {
             

            if (state.isLoading) {
              LoadingScreen.instance().show(context: context, text: 'Please wait....');
            } else {
              LoadingScreen.instance().hide();
            }
            final loginError = state.loginErrors;
            if (loginError != null) {
              showGenericDialog(
                  content: 'login error',
                  context: context,
                  optionsBuilder: () => {'ok': true},
                  title: 'Error');
            }


            //login successfull and empty notes
            if (!state.isLoading && state.loginErrors == null &&
                state.loginHandler == const LoginHandler.fooBar() &&
                state.fetchedNotes == null) {context.read<AppBloc>().add(const LoadNoteAction());
                LoadingScreen.instance().show(context: context, text: 'Loading notes....');
            }
          },
        ),
      ),
    );
  }
}
