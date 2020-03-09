part of 'tinder_bloc.dart';

@immutable
abstract class TinderState extends Equatable {
  const TinderState();

  @override
  List<Object> get props => [];
}

class TinderInitState extends TinderState {}

class TinderLoadingState extends TinderState {}

class TinderErrorState extends TinderState {
  final String message;

  const TinderErrorState(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => "TinderErrorState {files: $message}";
}

class TinderLoadedNextPageState extends TinderState {
  final List<User> users;

  const TinderLoadedNextPageState(this.users);

  @override
  List<Object> get props => [users];

  @override
  String toString() => "TinderLoadedNextPageState {users: $users}";
}
