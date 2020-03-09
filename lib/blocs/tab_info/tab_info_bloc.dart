import "dart:async";
import "package:bloc/bloc.dart";
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tinder/models/models.dart';

part 'tab_info_event.dart';

part 'tab_info_state.dart';

class TabInfoBloc extends Bloc<TabInfoEvent, TabInfoState> {
  TabInfo _tabInfo = TabInfo.name;

  TabInfoBloc();
  TabInfo get tab => _tabInfo;

  @override
  TabInfoState get initialState => TabInfoInitState();

  @override
  Stream<TabInfoState> mapEventToState(
    TabInfoEvent event,
  ) async* {
    if (event is TabInfoPressEvent) {
      yield* _handleTabInfoPressEvent(event);
      return;
    }
  }

  Stream<TabInfoState> _handleTabInfoPressEvent(
      TabInfoPressEvent event) async* {
    try {
      _tabInfo = event.tabInfo;
      yield TabInfoPressedState(_tabInfo);
    } catch (exception) {
      yield TabInfoErrorState(exception.message);
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
