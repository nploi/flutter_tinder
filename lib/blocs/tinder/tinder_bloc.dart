import "dart:async";
import "package:bloc/bloc.dart";
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tinder/models/models.dart';
import 'package:flutter_tinder/repositories/tinder_repository.dart';

part 'tinder_event.dart';

part 'tinder_state.dart';

class TinderBloc extends Bloc<TinderEvent, TinderState> {
  final TinderRepository tinderRepository;
  int _page = 0;
  final List<User> _users = [];

  TinderBloc({this.tinderRepository = const TinderRepository()});

  List<User> get users => _users;

  @override
  TinderState get initialState => TinderInitState();

  @override
  Stream<TinderState> mapEventToState(
    TinderEvent event,
  ) async* {
    if (event is TinderLoadNextPageEvent) {
      yield* _handleTinderDoSomeThingEvent(event);
      return;
    }
  }

  Stream<TinderState> _handleTinderDoSomeThingEvent(
      TinderLoadNextPageEvent event) async* {
    yield TinderLoadingState();
    try {
      var newUsers = await tinderRepository.getUsers(page: _page);
      users.clear();
      users.addAll(newUsers);
      _page++;
      yield TinderLoadedNextPageState(_users);
    } catch (exception) {
      yield TinderErrorState(exception.message);
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
