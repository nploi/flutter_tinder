part of 'tab_info_bloc.dart';

@immutable
abstract class TabInfoState extends Equatable {
  const TabInfoState();

  @override
  List<Object> get props => [];
}

class TabInfoInitState extends TabInfoState {}

class TabInfoLoadingState extends TabInfoState {}

class TabInfoErrorState extends TabInfoState {
  final String message;

  const TabInfoErrorState(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => "TabInfoErrorState {message: $message}";
}

class TabInfoPressedState extends TabInfoState {
  final TabInfo tabInfo;
  const TabInfoPressedState(this.tabInfo);

  @override
  List<Object> get props => [tabInfo];

  @override
  String toString() => "TabInfoPressedState {tabInfo: $tabInfo}";
}
