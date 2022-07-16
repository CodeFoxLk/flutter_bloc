import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'models/user_model.dart';

class UserRepository {
  Future<List<User>> getAllUsers() async {
    try {
      final String userJsonString = await rootBundle.loadString('assets/json_resources/users.json');
      final users = List<User>.from(json.decode(userJsonString).map((x) => User.fromJson(x)));
      return users;
    } catch (e) {
      throw Exception('Exception of loading users');
    }
  }
}
