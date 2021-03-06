part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();
  
  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignupState {}

class SignUpLoading extends SignupState {}

class SignUpSuccess extends SignupState {}

class SignUpFailure extends SignupState {
  final String error;

  const SignUpFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SignUp Failure {error : $error}';
}
