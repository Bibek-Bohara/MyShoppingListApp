import 'package:MyShoppingList/common/route/route.dart';
import 'package:MyShoppingList/feature/signin_signup/bloc/index.dart';
import 'package:MyShoppingList/feature/signin_signup/resource/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _globalKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLoginButtonPressed() {
    print("pushed to login bloc");
    BlocProvider.of<SigninBloc>(context).add(SignInButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SigninBloc, SigninState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
      },
      child: BlocBuilder<SigninBloc, SigninState>(
        builder: (context, state) {
          var data = 'Sign In';
          return Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child:
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(16.0),
              children: [
                Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 150),
                Text(data,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 40)),
                Form(
                    key: _globalKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            decoration: InputDecoration(labelText: "username"),
                            controller: _usernameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Username required!";
                              }
                              return null;
                            }),
                        TextFormField(
                          decoration: InputDecoration(labelText: "password"),
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Password required!";
                            }
                            return null;
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const SizedBox(height: 30),
                            _signInButton(state),
                            const SizedBox(height: 30),
                            Text(
                              "if you are new user register",
                              textAlign: TextAlign.center,
                            ),
                            _signUpButton(),
                          ],
                        ),
                        Container(
                          child: state is SignInLoading
                              ? const CircularProgressIndicator()
                              : null,
                        )
                      ],
                    ))
              ],
            ),
              ],
            )
          );
        },
      ),
    );
  }

  Widget _signInButton(SigninState state) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.white,
        onPressed: () {
          print(_globalKey.currentState.validate());
          if (_globalKey.currentState.validate() && state is! SignInLoading) {
            print(state);
            _onLoginButtonPressed();
          }
        },
        child: Text("Sign In"),
      ),
    );
  }

  Widget _signUpButton() {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, Routes.signUp,
              arguments: RepositoryProvider.of<AuthRepository>(context));
        },
        child: Text("SignUp"),
      ),
    );
  }
}
