import 'package:bloc/bloc.dart';
import 'package:MyShoppingList/feature/authentication/resource/user_repository.dart';
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null), super(AuthenticationUninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthStarted) {
        final bool hasToken = await userRepository.hasToken();

        if (hasToken) {
          yield AuthenticationAuthenticated();
        } else {
          yield AuthenticationUnauthenticated();
        }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
