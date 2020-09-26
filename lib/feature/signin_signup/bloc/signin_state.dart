part of 'signin_bloc.dart';

abstract class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SigninState {}

class SignInLoading extends SigninState {}

class SignInSuccess extends SigninState {}

class SignInFailure extends SigninState {
  final String error;

  const SignInFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Login Failure {error : $error}';
}
