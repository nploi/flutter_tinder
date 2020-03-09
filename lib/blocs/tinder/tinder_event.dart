
part of 'tinder_bloc.dart';

@immutable
abstract class TinderEvent extends Equatable {
  const TinderEvent();
  @override
  List<Object> get props => [];
}

class TinderDoSomeThingEvent extends TinderEvent {

  const TinderDoSomeThingEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => "TinderDoSomeThingEvent {}";
}

