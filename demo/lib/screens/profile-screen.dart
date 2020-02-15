import 'package:FlutterDemo/provider/remote-config.dart';
import 'package:flutter/material.dart';
import 'package:FlutterDemo/models/user.dart';
import 'package:FlutterDemo/data/user-repository.dart';
import 'package:FlutterDemo/bloc/user-bloc.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

class _ProfileStateScreen extends State<ProfileScreen> {
  final _textStyle = const TextStyle(fontSize: 36.0);
  UserBloc _userBloc;
  String _title;
  @override
  void initState() {
    _userBloc = UserBloc(widget.repository);
    _title = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile User')),
      body: SafeArea(
          child: StreamBuilder<UserState>(
              stream: _userBloc.user,
              initialData: UserInitState(),
              builder: (context, snapshot) {
                if (snapshot.data is UserDataState) {
                  UserDataState state = snapshot.data;
                  return _buildContent(state.user);
                }
                if (snapshot.data is UserLoadingState) {
                  return _buildLoading();
                }
                return _buildInit(context);
              })),
    );
  }

  Widget _buildInit(BuildContext context) {

    return Center(
        child: RaisedButton(
      child: _getButtonTitle(context),
      onPressed: () {
        _userBloc.loadUserData();
      },
    ));
  }

  Widget _getButtonTitle(BuildContext context) {
    return new Consumer<RemoteConfiguration>(
      builder: (context, config, child) {
        var title = config.getProfileMessage();
        return Text(title != null ? title : _title);
      },
    );
  }

  Widget _buildContent(User user) {
    return Center(
        child: Text('Welcome ${user.name} ${user.surname}', style: _textStyle));
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }
}

class ProfileScreen extends StatefulWidget {
  final UserRepository repository = UserRepository();
  final String title;
  ProfileScreen({@required this.title});

  @override
  State<StatefulWidget> createState() => _ProfileStateScreen();
}

/*
References for sliver:
https://www.woolha.com/tutorials/flutter-sliverappbar-examples
https://api.flutter.dev/flutter/material/SliverAppBar-class.html
https://stackoverflow.com/questions/54973948/is-it-possible-to-use-listview-builder-inside-of-customscrollview
https://api.flutter.dev/flutter/material/FlexibleSpaceBar-class.html

 */
