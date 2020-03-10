part of 'tabs_bloc.dart';

@immutable
abstract class TabsState extends Equatable {
  const TabsState();

  @override
  List<Object> get props => [];
}

class TabsInitState extends TabsState {}

class TabsLoadingState extends TabsState {}

class TabsErrorState extends TabsState {
  final String message;

  const TabsErrorState(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => "TabsErrorState {message: $message}";
}

class TabsSelectedState extends TabsState {
  final Tabs tab;

  const TabsSelectedState(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => "TabsSelectedState {tab: $tab}";
}
