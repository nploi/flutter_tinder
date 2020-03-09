import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tinder/models/models.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_tinder/blocs/settings/settings_bloc.dart';
import 'package:flutter_tinder/repositories/settings_repository.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  SettingsBloc settingsBloc;
  MockSettingsRepository settingsRepository;

  setUp(() {
    settingsRepository = MockSettingsRepository();
    settingsBloc = SettingsBloc(settingsRepository: settingsRepository);
  });

  tearDown(() {
    settingsBloc?.close();
  });

  group("SettingsBloc", () {
    test('initial state is correct', () {
      expect(settingsBloc.initialState, SettingsInitState());
    });

    test('Get settings', () {
      when(settingsRepository.getSetting())
          .thenAnswer((_) => Settings(languageCode: 'vi'));

      var settings = settingsBloc.settings;

      expect('vi', equals(settings.languageCode));
    });

    blocTest<SettingsBloc, SettingsEvent, SettingsState>(
      'emits [SettingsLoadingState, SettingsUpdatedSettingsState]'
      ' when successful',
      build: () async {
        var settings = Settings(languageCode: "en");
        when(settingsRepository.updateSetting(settings))
            .thenAnswer((_) async => true);
        return settingsBloc;
      },
      act: (bloc) async => settingsBloc
          .add(SettingsUpdateSettingsEvent(Settings(languageCode: "en"))),
      expect: [
        SettingsLoadingState(),
        SettingsUpdatedSettingsState(Settings(languageCode: "en"))
      ],
    );
  });
}
