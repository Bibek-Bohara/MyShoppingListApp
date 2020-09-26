import 'package:MyShoppingList/feature/profile/bloc/index.dart';
import 'package:MyShoppingList/feature/profile/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  int id;

  _editButtonPressed() {
    BlocProvider.of<ProfileBloc>(context).add(EditProfile());
  }

  _saveButtonPressed() {
    BlocProvider.of<ProfileBloc>(context).add(SaveButtonPressed(
        profile: Profile(
            id: id,
            firstname: firstNameController.text.toString(),
            lastname: lastNameController.text.toString(),
            email: emailController.text.toString(),
            username: usernameController.text.toString(),
            phone: phoneController.text.toString())));
  }

  _cancelButtonPressed() {
    BlocProvider.of<ProfileBloc>(context).add(CancelButtonPressed());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          firstNameController.text = state.profile.firstname;
          lastNameController.text = state.profile.lastname;
          emailController.text = state.profile.email;
          phoneController.text = state.profile.phone;
          usernameController.text = state.profile.username;
          id = state.profile.id;
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileError) {
          return  Center(child: Text(state.error));
        }
        return new ListView(
          children: <Widget>[
            new Container(
                height: 200.0,
                color: Colors.white,
                child: new Column(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image:
                                        new ExactAssetImage('assets/user.png'),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 90.0, right: 100.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 25.0,
                                  child: new Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )),
                      ])),
                ])),
            new Container(
              color: Color(0xffFFFFFF),
              child: Padding(
                padding: EdgeInsets.only(bottom: 25.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 25.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text(
                                  'Parsonal Information',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                state is! ProfileEdit
                                    ? _getEditIcon(state)
                                    : new Container(),
                              ],
                            )
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text(
                                  'First Name',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Flexible(
                              child: new TextField(
                                controller: firstNameController,
                                decoration: const InputDecoration(
                                  hintText: "Enter Your First Name",
                                ),
                                enabled: state is ProfileEdit ? true : false,
                                autofocus: state is ProfileEdit ? true : false,
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text(
                                  'Last Name',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Flexible(
                              child: new TextField(
                                controller: lastNameController,
                                decoration: const InputDecoration(
                                  hintText: "Enter Your Last Name",
                                ),
                                enabled: state is ProfileEdit ? true : false,
                                autofocus: state is ProfileEdit ? true : false,
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text(
                                  'Username',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Flexible(
                              child: new TextField(
                                controller: usernameController,
                                decoration: const InputDecoration(
                                  hintText: "Enter Your Username",
                                ),
                                enabled: state is ProfileEdit ? true : false,
                                autofocus: state is ProfileEdit ? true : false,
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text(
                                  'Email ID',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Flexible(
                              child: new TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                    hintText: "Enter Email ID"),
                                enabled: state is ProfileEdit ? true : false,
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text(
                                  'Mobile',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Flexible(
                              child: new TextField(
                                controller: phoneController,
                                decoration: const InputDecoration(
                                    hintText: "Enter Mobile Number"),
                                enabled: state is ProfileEdit ? true : false,
                              ),
                            ),
                          ],
                        )),
                    // Padding(
                    //     padding:
                    //         EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    //     child: new Row(
                    //       mainAxisSize: MainAxisSize.max,
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: <Widget>[
                    //         Expanded(
                    //           child: Container(
                    //             child: new Text(
                    //               'Pin Code',
                    //               style: TextStyle(
                    //                   fontSize: 16.0,
                    //                   fontWeight: FontWeight.bold),
                    //             ),
                    //           ),
                    //           flex: 2,
                    //         ),
                    //         Expanded(
                    //           child: Container(
                    //             child: new Text(
                    //               'State',
                    //               style: TextStyle(
                    //                   fontSize: 16.0,
                    //                   fontWeight: FontWeight.bold),
                    //             ),
                    //           ),
                    //           flex: 2,
                    //         ),
                    //       ],
                    //     )),
                    // Padding(
                    //     padding:
                    //         EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                    //     child: new Row(
                    //       mainAxisSize: MainAxisSize.max,
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: <Widget>[
                    //         Flexible(
                    //           child: Padding(
                    //             padding: EdgeInsets.only(right: 10.0),
                    //             child: new TextField(
                    //               decoration: const InputDecoration(
                    //                   hintText: "Enter Pin Code"),
                    //               enabled: state is ProfileEdit ? true : false,
                    //             ),
                    //           ),
                    //           flex: 2,
                    //         ),
                    //         Flexible(
                    //           child: new TextField(
                    //             decoration: const InputDecoration(
                    //                 hintText: "Enter State"),
                    //             enabled: state is ProfileEdit ? true : false,
                    //           ),
                    //           flex: 2,
                    //         ),
                    //       ],
                    //     )),
                    state is ProfileEdit
                        ? _getActionButtons(state)
                        : new Container(),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _getActionButtons(ProfileState state) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  if (state is ProfileEdit) {
                    _saveButtonPressed();
                  }
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  if (state is ProfileEdit) {
                    _cancelButtonPressed();
                  }
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon(ProfileState state) {
    return GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        if (state is! ProfileEdit) {
          _editButtonPressed();
        }
      },
    );
  }
}
