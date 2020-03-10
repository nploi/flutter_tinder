import 'package:flutter/material.dart';
import 'package:flutter_tinder/models/models.dart';
import 'package:flutter_tinder/ui/widgets/widgets.dart';

class UserDetailScreen extends StatefulWidget {
  static const routeName = "/detail";
  final User user;

  const UserDetailScreen({Key key, this.user}) : super(key: key);
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: UserSwipeCard(
        user: widget.user,
      ),
    );
  }
}
