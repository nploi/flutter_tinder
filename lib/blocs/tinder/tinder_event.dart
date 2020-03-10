part of 'tinder_bloc.dart';

@immutable
abstract class TinderEvent extends Equatable {
  const TinderEvent();
  @override
  List<Object> get props => [];
}

class TinderLoadNextPageEvent extends TinderEvent {
  const TinderLoadNextPageEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => "TinderLoadNextPageEvent {}";
}