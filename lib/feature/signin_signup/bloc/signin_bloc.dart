import 'dart:async';

import 'package:MyShoppingList/common/http/response.dart';
import 'package:MyShoppingList/feature/authentication/bloc/index.dart';
import 'package:MyShoppingList/feature/signin_signup/resource/index.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;

  SigninBloc({@required this.authRepository, @required this.authenticationBloc})
      : assert(authRepository != null),
        assert(authenticationBloc != null), super(SignInInitial());

  // @override
  // SigninState get initialState => SignInInitial();

  @override
  Stream<SigninState> mapEventToState(
    SigninEvent event,
  ) async* {
    if (event is SignInButtonPressed) {
      yield SignInLoading();

      try {
        final response =
            await authRepository.signIn(event.username, event.password);
        if (response.status == Status.ConnectivityError) {
          yield const SignInFailure(error: "");
        }

        if (response.status == Status.Success) {
          authenticationBloc.add(LoggedIn(token: response.data));
          yield SignInSuccess();
        } else {
          yield SignInFailure(error: response.message);
        }
      } catch (error) {
        yield SignInFailure(error: "username or password invalid");
      }
    }
  }
}
