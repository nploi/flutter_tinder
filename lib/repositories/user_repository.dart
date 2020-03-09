import 'package:flutter_tinder/data/user.dart';
import 'package:flutter_tinder/models/models.dart';

class UserRepository {
  const UserRepository({this.userDao = const UserDao()});
  final UserDao userDao;

  Future<User> getById({int id}) async {
    return userDao.getUserById(id: id);
  }

  Future<User> createTodo({User user}) async {
    var id = await userDao.createUser(user: user);
    return getById(id: id);
  }
}
