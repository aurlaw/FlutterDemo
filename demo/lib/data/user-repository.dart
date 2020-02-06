import 'dart:async';
import 'package:FlutterDemo/models/user.dart';


class UserRepository {
  Future<User> getUser() async {
    await Future.delayed(Duration(seconds: 2));
    return User(name: 'John', surname:'Doe');
  }  
}