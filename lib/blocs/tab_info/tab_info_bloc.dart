
import "dart:async";
import "package:bloc/bloc.dart";
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tinder/repositories/tab_info_repository.dart';

part 'tab_info_event.dart';

part 'tab_info_state.dart';

class TabInfoBloc extends Bloc<TabInfoEvent, TabInfoState> {
  
  final TabInfoRepository tabInfoRepository;
  
  TabInfoBloc({this.tabInfoRepository = const TabInfoRepository()});

  @override
  TabInfoState get initialState => TabInfoInitState();

  @override
  Stream<TabInfoState> mapEventToState(
    TabInfoEvent event,
  ) async* {
    if (event is TabInfoDoSomeThingEvent) {
      yield* _handleTabInfoDoSomeThingEvent(event);
      return;
    }
  }

  Stream<TabInfoState> _handleTabInfoDoSomeThingEvent(
      TabInfoDoSomeThingEvent event) async* {
    yield TabInfoLoadingState();
    try {
      yield const TabInfoDidSomeThingState();
    } catch (exception) {
      yield TabInfoErrorState(exception.toString());
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
