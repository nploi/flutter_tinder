
part of 'tinder_bloc.dart';

@immutable
abstract class TinderState extends Equatable {
  const TinderState();

  @override
  List<Object> get props => [];
}

class TinderInitState extends TinderState {}

class TinderLoadingState extends TinderState {}

class TinderErrorState extends TinderState {
  final String message;

  const TinderErrorState(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => "TinderErrorState {files: $message}";
}

class TinderDidSomeThingState extends TinderState {

  const TinderDidSomeThingState();

  @override
  List<Object> get props => [];

  @override
  String toString() => "TinderDidSomeThingState {}";
}
