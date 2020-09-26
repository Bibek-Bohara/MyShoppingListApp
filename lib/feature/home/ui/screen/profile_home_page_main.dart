import 'package:MyShoppingList/common/constant/env.dart';
import 'package:MyShoppingList/common/http/api_provider.dart';
import 'package:MyShoppingList/common/util/internet_check.dart';
import 'package:MyShoppingList/feature/authentication/resource/user_repository.dart';
import 'package:MyShoppingList/feature/home/ui/widget/profile_home_page_widget.dart';
import 'package:MyShoppingList/feature/profile/bloc/profile_bloc.dart';
import 'package:MyShoppingList/feature/profile/resource/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileHomePageMain extends StatelessWidget {
  const ProfileHomePageMain({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: ProfileHomePageWidget()));
  }
}
