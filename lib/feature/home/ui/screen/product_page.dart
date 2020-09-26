import 'package:MyShoppingList/common/route/route.dart';
import 'package:MyShoppingList/feature/authentication/resource/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MyShoppingList/common/constant/env.dart';
import 'package:MyShoppingList/common/http/api_provider.dart';
import 'package:MyShoppingList/common/util/internet_check.dart';
import 'package:MyShoppingList/feature/authentication/bloc/index.dart';
import 'package:MyShoppingList/feature/home/bloc/index.dart';
import 'package:MyShoppingList/feature/home/resource/home_repository.dart';
import 'package:MyShoppingList/feature/home/ui/widget/home_widget.dart';

class ProductPage extends StatelessWidget {
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
              ..add(Fetch()),
            child: Container(child: const HomeWidget())));
  }
}
