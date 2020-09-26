import 'package:MyShoppingList/feature/signin_signup/bloc/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _globalKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNoController = TextEditingController();

  void _onSignUpButtonPressed() {
    BlocProvider.of<SignupBloc>(context).add(SignUpButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
        email: _emailController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phone: _phoneNoController.text
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Theme.of(context).errorColor,
          ));
        }

        if (state is SignUpSuccess) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("SignUp Success"),
              backgroundColor: Theme.of(context).accentColor,
            ),
          );

          Navigator.pop(context);
        }
      },
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          return Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child:       ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16.0),
                  children: [Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 16),
                    Form(
                      key: _globalKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: "Email"),
                            controller: _emailController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Email required!";
                                }
                                return null;
                              }
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Username"),
                            controller: _usernameController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Username required!";
                                }
                                return null;
                              }
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Password"),
                            controller: _passwordController,
                            obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Password required!";
                                }
                                return null;
                              }
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "ReType Password"),
                            obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Password required!";
                                }
                                if(value != _passwordController.text.toString()){
                                  return "Password Mismatch";
                                }
                                return null;
                              }
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "First Name"),
                            controller: _firstNameController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "First Name required!";
                                }
                                return null;
                              }
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Last Name"),
                            controller: _lastNameController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Last Name required!";
                                }
                                return null;
                              }
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Phone"),
                            controller: _phoneNoController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Phone required!";
                                }
                                return null;
                              }
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                const SizedBox(height: 30),
                                _signUpButton(state),
                                const SizedBox(height: 30),
                                Text("Already User",
                                    textAlign: TextAlign.center),
                                _signInButton(),
                              ]),
                          Container(
                            child: state is SignUpLoading
                                ? const CircularProgressIndicator()
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ])]),);
        },
      ),
    );
  }

  Widget _signInButton() {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.white,
        onPressed: () {
            Navigator.pop(context);
          },
        child: Text("Sign In"),
      ),
    );
  }

  Widget _signUpButton(SignupState state) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.white,
        onPressed: (){
          if (_globalKey.currentState.validate() && state is! SignUpLoading) {
            _onSignUpButtonPressed();
          }
        },
        child: Text("SignUp"),
      ));
  }
}
