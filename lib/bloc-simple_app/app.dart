import 'package:bloc_pattern/bloc-simple_app/repositories/models/user_model.dart';
import 'package:bloc_pattern/bloc-simple_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocApp extends StatelessWidget {
  const SimpleBlocApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
          create: (context) => UserBloc(), child: const HomePage()),
    );
  }
}

@immutable
abstract class LoadAction {
  const LoadAction();
}

class LoadUserAction extends LoadAction {}

class UserState {
  final List<User> users;

  const UserState({required this.users});

  @override
  String toString() {
    return 'Fetch result - (users = $users)';
  }
}

class UserBloc extends Bloc<LoadAction, UserState?> {
  UserRepository? userRepository;
  List<User>? users;

  UserBloc({this.userRepository}) : super(null) {
    on<LoadAction>(_loadUsers);
  }

  void _loadUsers(LoadAction event, Emitter<UserState?> emit) async {
    try {
      userRepository ??= UserRepository();
      users ??= await userRepository!.getAllUsers();
      print(users);
      emit(UserState(users: users!));
    } catch (e) {
      emit(const UserState(users: []));
    }
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.read<UserBloc>().add(LoadUserAction());
                },
                child: const Text("Load users")),
            Expanded(child:
                BlocBuilder<UserBloc, UserState?>(builder: (contxt, state) {
              return ListView.builder(
                  itemCount: state?.users.length ?? 0,
                  itemBuilder: (context, index) {
                    final user = state?.users[index];
                    if (user == null) return const SizedBox();
                    return ListTile(title: Text(user.name ?? ''));
                  });
            }))
          ],
        ),
      ),
    );
  }
}
