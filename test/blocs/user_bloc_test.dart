import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tinder/models/models.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_tinder/blocs/user/user_bloc.dart';
import 'package:flutter_tinder/repositories/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  UserBloc userBloc;
  MockUserRepository userRepository;

  setUp(() {
    userRepository = MockUserRepository();
    userBloc = UserBloc(userRepository: userRepository);
  });

  tearDown(() {
    userBloc?.close();
  });

  group("UserBloc", () {
    User user = User();
    blocTest<UserBloc, UserEvent, UserState>(
      'emits [UserLoadingState(), UserDidSomeThingState()]'
      'when successful',
      build: () async {
        when(userRepository.createTodo(user: user))
            .thenAnswer((_) async => user..id = 1);
        return userBloc;
      },
      act: (bloc) async => userBloc.add(UserLikeEvent(user)),
      expect: [
        UserLoadingState(),
        UserLikedState(user),
      ],
    );
  });
}
