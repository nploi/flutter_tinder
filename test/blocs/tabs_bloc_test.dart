import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tinder/blocs/tabs/tabs_bloc.dart';
import 'package:flutter_tinder/models/models.dart';

void main() {
  TabsBloc tabsBloc;

  setUp(() {
    tabsBloc = TabsBloc();
  });

  tearDown(() {
    tabsBloc?.close();
  });

  group("TabsBloc", () {
    blocTest<TabsBloc, TabsEvent, TabsState>(
      'emits [TabsLoadingState(), TabsSelectedState()]'
      'when successful',
      build: () async {
        return tabsBloc;
      },
      act: (bloc) async =>
          tabsBloc.add(const TabsSelectEvent(Tabs.favoriteList)),
      expect: [
        const TabsSelectedState(Tabs.favoriteList),
      ],
    );
  });
}
