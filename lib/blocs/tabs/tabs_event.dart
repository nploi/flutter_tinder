
part of 'tabs_bloc.dart';

@immutable
abstract class TabsEvent extends Equatable {
  const TabsEvent();
  @override
  List<Object> get props => [];
}

class TabsSelectEvent extends TabsEvent {
  final Tabs tab;
  const TabsSelectEvent(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => "TabsSelectEvent {tab: $tab}";
}
