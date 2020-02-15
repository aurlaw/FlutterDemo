import 'dart:async';
import 'package:FlutterDemo/models/user.dart';
import 'package:FlutterDemo/data/user-repository.dart';

class UserBloc {
  final UserRepository repository;

  UserBloc(this.repository);

  final _userStreamController = StreamController<UserState>();

  Stream<UserState> get user => _userStreamController.stream;

  void loadUserData() {
    _userStreamController.sink.add(UserState._userLoading());
    repository.getUser().then((user) {
      _userStreamController.sink.add(UserState._userData(user));
    });
  }

  void dispose() {
    _userStreamController.close();
  }
}

class UserState {
  UserState();
  factory UserState._userData(User user) = UserDataState;
  factory UserState._userLoading() = UserLoadingState;
}

class UserInitState extends UserState {}

class UserLoadingState extends UserState {}

class UserDataState extends UserState {
  final User user;
  UserDataState(this.user);
}
