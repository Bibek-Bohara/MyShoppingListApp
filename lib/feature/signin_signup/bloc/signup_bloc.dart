import 'dart:async';

import 'package:MyShoppingList/feature/authentication/bloc/authentication_bloc.dart';
import 'package:MyShoppingList/feature/signin_signup/resource/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;

  SignupBloc({@required this.authRepository, @required this.authenticationBloc})
      : assert(authRepository != null),
        assert(authenticationBloc != null), super(SignUpInitial());

  // @override
  // SignupState get initialState => SignUpInitial();

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignUpButtonPressed) {
      yield SignUpLoading();

      try {
        final response = await authRepository.signUp(
            event.email, event.password, event.username, event.firstName, event.lastName, event.phone);

        if (!response.containsKey('error')){
          yield SignUpSuccess();
        } else {
          yield SignUpInitial();
        }
      } catch (error) {
        yield SignUpFailure(error: error.toString());
      }
    }
  }
}
