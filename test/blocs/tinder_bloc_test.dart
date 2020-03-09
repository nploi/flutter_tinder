
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_tinder/blocs/tinder/tinder_bloc.dart';
import 'package:flutter_tinder/repositories/tinder_repository.dart';

class MockTinderRepository extends Mock implements TinderRepository {}

void main() {
  TinderBloc tinderBloc;
  MockTinderRepository tinderRepository;

  setUp(() {
    tinderBloc = TinderBloc(tinderRepository: tinderRepository);
  });

  tearDown(() {
    tinderBloc?.close();
  });

  group("TinderBloc", () {
    blocTest<TinderBloc, TinderEvent, TinderState>(
      'emits [TinderLoadingState(), TinderDidSomeThingState()]'
      'when successful',
      build: () async {
        return tinderBloc;
      },
      act: (bloc) async =>
          tinderBloc.add(const TinderDoSomeThingEvent()),
      expect: [
         TinderLoadingState(),
         const TinderDidSomeThingState(),
      ],
    );
  });
}
