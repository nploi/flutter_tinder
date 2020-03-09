import "dart:async";
import "package:bloc/bloc.dart";
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tinder/models/models.dart';
import 'package:flutter_tinder/repositories/settings_repository.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;

  Settings get settings => settingsRepository.getSetting();

  SettingsBloc({this.settingsRepository = const SettingsRepository()});

  @override
  SettingsState get initialState => SettingsInitState();

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is SettingsUpdateSettingsEvent) {
      yield* _handleUpdateSettingsSettingsEvent(event);
      return;
    }
  }

  Stream<SettingsState> _handleUpdateSettingsSettingsEvent(
      SettingsUpdateSettingsEvent event) async* {
    yield SettingsLoadingState();
    try {
      await settingsRepository.updateSetting(event.settings);
      yield SettingsUpdatedSettingsState(event.settings);
    } catch (exception) {
      yield SettingsErrorState(exception.message);
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
