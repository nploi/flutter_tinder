
import "dart:async";
import "package:bloc/bloc.dart";
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tinder/repositories/tinder_repository.dart';

part 'tinder_event.dart';

part 'tinder_state.dart';

class TinderBloc extends Bloc<TinderEvent, TinderState> {
  
  final TinderRepository tinderRepository;
  
  TinderBloc({this.tinderRepository = const TinderRepository()});

  @override
  TinderState get initialState => TinderInitState();

  @override
  Stream<TinderState> mapEventToState(
    TinderEvent event,
  ) async* {
    if (event is TinderDoSomeThingEvent) {
      yield* _handleTinderDoSomeThingEvent(event);
      return;
    }
  }

  Stream<TinderState> _handleTinderDoSomeThingEvent(
      TinderDoSomeThingEvent event) async* {
    yield TinderLoadingState();
    try {
      yield const TinderDidSomeThingState();
    } catch (exception) {
      yield TinderErrorState(exception.toString());
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
