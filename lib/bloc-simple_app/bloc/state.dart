import 'package:bloc_pattern/bloc-simple_app/repositories/models/user_model.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable{
  final List<User> users;

  const UserState({required this.users});

  @override
  String toString() {
    return 'Fetch result - (users = $users)';
  }
  
  @override
  List<Object?> get props => users;
}