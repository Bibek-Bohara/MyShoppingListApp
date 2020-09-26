import 'dart:core';

import 'package:MyShoppingList/feature/authentication/bloc/index.dart';
import 'package:MyShoppingList/feature/signin_signup/bloc/index.dart';
import 'package:MyShoppingList/feature/signin_signup/resource/index.dart';
import 'package:MyShoppingList/feature/signin_signup/ui/signin_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  final AuthRepository authRepository;

  const SignInPage({Key key, @required this.authRepository})
      : assert(authRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: RepositoryProvider(
        create: (context) => authRepository,
        child: BlocProvider(create: (context) {
          return SigninBloc(
            authRepository: authRepository,
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          );
        },
        child: SignInForm(),
        ),
      ),
    );
  }
}
