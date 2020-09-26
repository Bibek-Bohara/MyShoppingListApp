import 'package:MyShoppingList/common/route/route.dart';
import 'package:MyShoppingList/feature/authentication/resource/user_repository.dart';
import 'package:MyShoppingList/feature/home/ui/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MyShoppingList/common/constant/env.dart';
import 'package:MyShoppingList/common/http/api_provider.dart';
import 'package:MyShoppingList/common/util/internet_check.dart';
import 'package:MyShoppingList/feature/home/bloc/index.dart';
import 'package:MyShoppingList/feature/home/resource/home_repository.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => ProductBloc(
                homeRepository: HomeRepository(
                    userRepository: RepositoryProvider.of<UserRepository>(context),
                    env: RepositoryProvider.of<Env>(context),
                    apiProvider: RepositoryProvider.of<ApiProvider>(context),
                    internetCheck:
                    RepositoryProvider.of<InternetCheck>(context)))
              ..add(Search(query: '')),
            child: Container(child: SearchWidget())));
  }
}
