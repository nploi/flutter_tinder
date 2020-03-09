
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tinder/models/models.dart';
import 'package:flutter_tinder/blocs/tab_info/tab_info_bloc.dart';

void main() {
  TabInfoBloc tabInfoBloc;

  setUp(() {
    tabInfoBloc = TabInfoBloc();
  });

  tearDown(() {
    tabInfoBloc?.close();
  });

  group("TabInfoBloc", () {
    blocTest<TabInfoBloc, TabInfoEvent, TabInfoState>(
      'emits [TabInfoLoadingState(), TabInfoPressedState()]'
      'when successful',
      build: () async {
        return tabInfoBloc;
      },
      act: (bloc) async =>
          tabInfoBloc.add(const TabInfoPressEvent(TabInfo.email)),
      expect: [
         const TabInfoPressedState(TabInfo.email),
      ],
    );
  });
}
