import 'package:MyShoppingList/common/route/route.dart';
import 'package:MyShoppingList/feature/authentication/bloc/index.dart';
import 'package:MyShoppingList/feature/home/model1/list_profile_section.dart';
import 'package:MyShoppingList/feature/home/ui/widget/about.us.dart';
import 'package:MyShoppingList/feature/order/order_page.dart';
import 'package:MyShoppingList/feature/profile/bloc/index.dart';
import 'package:MyShoppingList/feature/profile/ui/screen/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileHomePageWidget extends StatefulWidget {
  @override
  _ProfilePage1State createState() => _ProfilePage1State();
}

class _ProfilePage1State extends State<ProfileHomePageWidget> {
  List<ListProfileSection> listSection = new List();

  @override
  void initState() {
    super.initState();
    createListItem();
  }

  showAlertDialog(BuildContext context, String title, String message) {
        return  AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            FlatButton(
                child: Text("OK"),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                  Navigator.pushReplacementNamed(context, Routes.landing);
                }
            ),
            FlatButton(
                child: Text("CANCEL"),
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
          ],
        );
  }

  void createListItem() {
    listSection.add(createSection("My Orders", Icons.shopping_cart,
        Colors.blue.shade800, OrderPage()));
    listSection.add(createSection("About Us", Icons.supervised_user_circle,
        Colors.black.withOpacity(0.8), AboutPage()));
    listSection.add(createSection(
        "Logout", Icons.clear, Colors.red.withOpacity(0.7), showAlertDialog(context, 'Logout?','Do you want to logout?')
    ));
  }

  createSection(String title, IconData icon, Color color, Widget widget) {
    return ListProfileSection(title, icon, color, widget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomPadding: true,
      body: BlocListener<ProfileBloc, ProfileState>(listener: (context, state){

      },
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state){
        return Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                      ),
                      top: -40,
                      left: -40,
                    ),
                    Positioned(
                      child: Container(
                        width: 300,
                        height: 260,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle),
                      ),
                      top: -40,
                      left: -40,
                    ),
                    Positioned(
                      child: Align(
                        child: Container(
                          width: 400,
                          height: 260,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              shape: BoxShape.circle),
                        ),
                      ),
                      top: -40,
                      left: -40,
                    ),
                  ],
                ),
              ),
              Container(
                child: Text(
                  "Profile",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                margin: EdgeInsets.only(top: 72, left: 24),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                    flex: 20,
                  ),
                  Expanded(
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: Card(
                              margin:
                              EdgeInsets.only(top: 50, left: 16, right: 16),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 8, top: 8, right: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.settings),
                                          iconSize: 24,
                                          color: Colors.black,
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          color: Colors.black,
                                          iconSize: 24,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (context) =>
                                                       ProfilePage()));
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  state is ProfileLoaded?
                                  Text(
                                    state is ProfileLoaded ? ((state.profile.firstname == null ?"":state.profile.firstname) + ' '+(state.profile.lastname == null ?"":state.profile.lastname)):"",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900),
                                  ): SizedBox(width:16,height: 16,child:CircularProgressIndicator(strokeWidth: 2)),
                                  Text(
                                    state is ProfileLoaded ? state.profile.email: "",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    height: 2,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  buildListView()
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade400, width: 2),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/user.png"),
                                      fit: BoxFit.contain)),
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                    flex: 75,
                  ),
                  Expanded(
                    child: Container(),
                    flex: 05,
                  )
                ],
              )
            ],
          ),
        );
      })
    ));
  }

  ListView buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return createListViewItem(listSection[index]);
      },
      itemCount: listSection.length,
    );
  }

  createListViewItem(ListProfileSection listSection) {
    return Builder(builder: (context) {
      return InkWell(
        splashColor: Colors.teal.shade200,
        onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => listSection.widget));
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 12),
          padding: EdgeInsets.only(top: 12, bottom: 12),
          child: Row(
            children: <Widget>[
              SizedBox(
                child: Icon(listSection.icon, color: Colors.grey.shade500,),
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                listSection.title,
                style: TextStyle(color: Colors.grey.shade500),
              ),
              Spacer(
                flex: 1,
              ),
              Icon(
                Icons.navigate_next,
                color: Colors.grey.shade500,
              )
            ],
          ),
        ),
      );
    });
  }
}