part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class SignInButtonPressed extends SigninEvent {
  final String username;
  final String password;

  const SignInButtonPressed({
    @required this.username, 
    @required this.password
    });

  @override
  List<Object> get props => [username, password];

  @override
  String toString() => 'LoginButtonPressed {username: $username}, password: $password';
}
