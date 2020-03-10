part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class UserLikeEvent extends UserEvent {
  final User user;
  const UserLikeEvent(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => "UserLikeEvent {user: ${user.toJson()}";
}


class UserLoadFavoriteListEvent extends UserEvent {
  const UserLoadFavoriteListEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => "UserLoadFavoriteListEvent {}";
}
