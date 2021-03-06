part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitState extends UserState {}

class UserLoadingState extends UserState {}

class UserErrorState extends UserState {
  final String message;

  const UserErrorState(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => "UserErrorState {message: $message}";
}

class UserLikedState extends UserState {
  final User user;
  const UserLikedState(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => "UserLikedState {user: ${user.toJson()}";
}

class UserLoadedFavoriteListState extends UserState {
  final List<User> users;

  const UserLoadedFavoriteListState(this.users);

  @override
  List<Object> get props => [users];

  @override
  String toString() => "UserLoadedFavoriteListState {users: $users}";
}
