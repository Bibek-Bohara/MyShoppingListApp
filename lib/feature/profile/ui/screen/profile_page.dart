import 'package:MyShoppingList/common/constant/env.dart';
import 'package:MyShoppingList/common/http/api_provider.dart';
import 'package:MyShoppingList/common/util/internet_check.dart';
import 'package:MyShoppingList/feature/authentication/resource/user_repository.dart';
import 'package:MyShoppingList/feature/profile/bloc/profile_bloc.dart';
import 'package:MyShoppingList/feature/profile/resource/profile_repository.dart';
import 'package:MyShoppingList/feature/profile/ui/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          iconTheme: new IconThemeData(color: Colors.white),
          title: Text(
            "Profile",
            style: TextStyle(
                fontSize: 18
            ),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: BlocProvider(
            create: (context) => ProfileBloc(
                profileRepository: ProfileRepository(
                    env: RepositoryProvider.of<Env>(context),
                    apiProvider: RepositoryProvider.of<ApiProvider>(context),
                    internetCheck:
                        RepositoryProvider.of<InternetCheck>(context),
                    userRepository:
                        RepositoryProvider.of<UserRepository>(context)))
              ..add(FetchProfile()),
            child: ProfileWidget()));
  }
}
