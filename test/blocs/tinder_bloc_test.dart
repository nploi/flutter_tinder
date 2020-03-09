import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tinder/models/user.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_tinder/blocs/tinder/tinder_bloc.dart';
import 'package:flutter_tinder/repositories/tinder_repository.dart';

class MockTinderRepository extends Mock implements TinderRepository {}

void main() {
  TinderBloc tinderBloc;
  MockTinderRepository tinderRepository;

  setUp(() {
    tinderRepository = MockTinderRepository();
    tinderBloc = TinderBloc(tinderRepository: tinderRepository);
  });

  tearDown(() {
    tinderBloc?.close();
  });

  group("TinderBloc", () {
    List<User> users = [User(), User()];
    blocTest<TinderBloc, TinderEvent, TinderState>(
      'emits [TinderLoadingState(), TinderLoadedNextPageState()]'
      'when successful',
      build: () async {
        when(tinderRepository.getUsers(page: 0)).thenAnswer((_) async => users);
        return tinderBloc;
      },
      act: (bloc) async => tinderBloc.add(const TinderLoadNextPageEvent()),
      expect: [
        TinderLoadingState(),
        TinderLoadedNextPageState(users),
      ],
    );
  });
}
