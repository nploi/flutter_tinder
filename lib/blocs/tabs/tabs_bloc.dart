import "dart:async";
import "package:bloc/bloc.dart";
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tinder/models/models.dart';

part 'tabs_event.dart';

part 'tabs_state.dart';

class TabsBloc extends Bloc<TabsEvent, TabsState> {
  Tabs _tab = Tabs.home;

  Tabs get tab => _tab;

  TabsBloc();

  @override
  TabsState get initialState => TabsInitState();

  @override
  Stream<TabsState> mapEventToState(
    TabsEvent event,
  ) async* {
    if (event is TabsSelectEvent) {
      yield* _handleTabsDoSomeThingEvent(event);
      return;
    }
  }

  Stream<TabsState> _handleTabsDoSomeThingEvent(TabsSelectEvent event) async* {
    try {
      _tab = event.tab;
      yield TabsSelectedState(_tab);
    } catch (exception) {
      yield TabsErrorState(exception.message);
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
