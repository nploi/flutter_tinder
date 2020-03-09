
part of 'tab_info_bloc.dart';

@immutable
abstract class TabInfoEvent extends Equatable {
  const TabInfoEvent();
  @override
  List<Object> get props => [];
}

class TabInfoDoSomeThingEvent extends TabInfoEvent {

  const TabInfoDoSomeThingEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => "TabInfoDoSomeThingEvent {}";
}

