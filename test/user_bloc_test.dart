import 'package:bloc_pattern/bloc-simple_app/bloc/bloc.dart';
import 'package:bloc_pattern/bloc-simple_app/bloc/events.dart';
import 'package:bloc_pattern/bloc-simple_app/bloc/state.dart';
import 'package:bloc_pattern/bloc-simple_app/repositories/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('Testing users', () {
    late UserBloc userBloc;
    setUp(() { //This function will be called before each test is run. 
      userBloc = UserBloc();
    });
    blocTest<UserBloc, UserState?>('Test initial state',
        build: () {
          return userBloc;
        },
        verify: (b) => b.state == null // to verification before test
        );
    blocTest<UserBloc, UserState?>(
      'user',
      build: (() => userBloc),
      act: (userBLoc) {
        //userBLoc.add(LoadUserAction());
        userBloc.add(TestUserAction());
      },
      expect: () {
        return [
          UserState(users: [User(name: "Eshan")])
        ];
      },
    );
  });
}
