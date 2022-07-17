import 'dart:async';

import 'package:bloc_pattern/bloc-simple_app/bloc/events.dart';
import 'package:bloc_pattern/bloc-simple_app/bloc/state.dart';
import 'package:bloc_pattern/bloc-simple_app/repositories/models/user_model.dart';
import 'package:bloc_pattern/bloc-simple_app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<LoadAction, UserState?> {
  UserRepository? userRepository;
  List<User>? users;

  UserBloc({this.userRepository}) : super(null) {
    on<LoadUserAction>(_loadUsers);
    on<TestUserAction>(_testUsers);
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

  FutureOr<void> _testUsers(TestUserAction event, Emitter<UserState?> emit) {
    emit(UserState(users: [User(name: "Eshan")]));
  }
}