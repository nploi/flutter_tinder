part of 'tab_info_bloc.dart';

@immutable
abstract class TabInfoEvent extends Equatable {
  const TabInfoEvent();
  @override
  List<Object> get props => [];
}

class TabInfoPressEvent extends TabInfoEvent {
  final TabInfo tabInfo;
  const TabInfoPressEvent(this.tabInfo);

  @override
  List<Object> get props => [];

  @override
  String toString() => "TabInfoPressEvent {tabInfo: $tabInfo}";
}
