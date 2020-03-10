import "dart:async";
import "package:bloc/bloc.dart";
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tinder/blocs/blocs.dart';
import 'package:flutter_tinder/models/models.dart';
import 'package:flutter_tinder/repositories/repositories.dart';

part 'tinder_event.dart';

part 'tinder_state.dart';

class TinderBloc extends Bloc<TinderEvent, TinderState> {
  final TinderRepository tinderRepository;
  int _page = 0;
  final List<User> _users = [];

  final SettingsBloc settingsBloc;
  StreamSubscription settingsSubscription;

  TinderBloc(
      {this.tinderRepository = const TinderRepository(), this.settingsBloc}) {
    if (settingsBloc != null) {
      settingsSubscription = settingsBloc.listen((state) {
        if (state is SettingsUpdatedSettingsState) {
          add(const TinderLoadNextPageEvent());
        }
      });
    }
  }

  List<User> get users => _users;

  @override
  TinderState get initialState => TinderInitState();

  @override
  Stream<TinderState> mapEventToState(
    TinderEvent event,
  ) async* {
    if (event is TinderLoadNextPageEvent) {
      yield* _handleTinderLoadNextPageEvent(event);
      return;
    }
  }

  Stream<TinderState> _handleTinderLoadNextPageEvent(
      TinderLoadNextPageEvent event) async* {
    yield TinderLoadingState();
    try {
      var newUsers = await tinderRepository.getUsers(page: _page);
      _users.clear();
      _users.addAll(newUsers);
      _page++;
      yield TinderLoadedNextPageState(_users);
    } catch (exception) {
      yield TinderErrorState(exception.message);
    }
  }

  @override
  Future<void> close() {
    settingsSubscription.cancel();
    return super.close();
  }
}
