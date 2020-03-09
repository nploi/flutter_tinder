
part of 'settings_bloc.dart';

@immutable
abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitState extends SettingsState {}

class SettingsLoadingState extends SettingsState {}

class SettingsErrorState extends SettingsState {
  final String message;

  const SettingsErrorState(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => "SettingsErrorState {files: $message}";
}

class SettingsUpdatedSettingsState extends SettingsState {
  final Settings settings;
  const SettingsUpdatedSettingsState(this.settings);

  @override
  List<Object> get props => [settings.toJson()];

  @override
  String toString() =>
      "SettingsUpdatedSettingsState {settings: ${settings.toJson()}";
}