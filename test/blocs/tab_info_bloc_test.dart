
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_tinder/blocs/tab_info/tab_info_bloc.dart';
import 'package:flutter_tinder/repositories/tab_info_repository.dart';

class MockTabInfoRepository extends Mock implements TabInfoRepository {}

void main() {
  TabInfoBloc tabInfoBloc;
  MockTabInfoRepository tabInfoRepository;

  setUp(() {
    tabInfoBloc = TabInfoBloc(tabInfoRepository: tabInfoRepository);
  });

  tearDown(() {
    tabInfoBloc?.close();
  });

  group("TabInfoBloc", () {
    blocTest<TabInfoBloc, TabInfoEvent, TabInfoState>(
      'emits [TabInfoLoadingState(), TabInfoDidSomeThingState()]'
      'when successful',
      build: () async {
        return tabInfoBloc;
      },
      act: (bloc) async =>
          tabInfoBloc.add(const TabInfoDoSomeThingEvent()),
      expect: [
         TabInfoLoadingState(),
         const TabInfoDidSomeThingState(),
      ],
    );
  });
}
