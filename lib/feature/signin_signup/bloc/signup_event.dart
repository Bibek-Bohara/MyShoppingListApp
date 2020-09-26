part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignUpButtonPressed extends SignupEvent {
  final String username;
  final String password;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;

  const SignUpButtonPressed(
      {@required this.username, @required this.password, @required this.email, @required this.firstName, @required this.lastName, @required this.phone});

  @override
  List<Object> get props => [username, password, email, firstName, lastName, phone];

  @override
  String toString() =>
      'LoginButtonPressed { username : $username, password: $password, email: $email}';
}
