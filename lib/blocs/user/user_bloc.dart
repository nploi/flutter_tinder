import "dart:async";
import "package:bloc/bloc.dart";
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tinder/models/models.dart';
import 'package:flutter_tinder/repositories/user_repository.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({this.userRepository = const UserRepository()});

  @override
  UserState get initialState => UserInitState();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserLikeEvent) {
      yield* _handleUserLikeEvent(event);
      return;
    }
  }

  Stream<UserState> _handleUserLikeEvent(UserLikeEvent event) async* {
    yield UserLoadingState();
    try {
      var user = await userRepository.createTodo(user: event.user);
      yield UserLikedState(user);
    } catch (exception) {
      yield UserErrorState(exception.message);
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
