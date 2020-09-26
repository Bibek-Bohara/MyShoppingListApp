import 'package:MyShoppingList/app/theme.dart';
import 'package:MyShoppingList/common/bloc/connectivity/index.dart';
import 'package:MyShoppingList/common/constant/env.dart';
import 'package:MyShoppingList/common/http/api_provider.dart';
import 'package:MyShoppingList/common/route/route.dart';
import 'package:MyShoppingList/common/route/router_generator.dart';
import 'package:MyShoppingList/common/util/internet_check.dart';
import 'package:MyShoppingList/feature/authentication/bloc/index.dart';
import 'package:MyShoppingList/feature/authentication/resource/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final Env env;

  const App({Key key, @required this.env}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<Env>(
            create: (context) => env,
            lazy: true,
          ),
          RepositoryProvider<InternetCheck>(
            create: (context) => InternetCheck(),
            lazy: true,
          ),
          RepositoryProvider<UserRepository>(
            create: (context) => UserRepository(),
            lazy: true,
          ),
          RepositoryProvider<ApiProvider>(
            create: (context) => ApiProvider(),
            lazy: true,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ConnectivityBloc>(create: (context) {
              return ConnectivityBloc();
            }),
            BlocProvider<AuthenticationBloc>(
              create: (context) {
                return AuthenticationBloc(
                    userRepository:
                        RepositoryProvider.of<UserRepository>(context))
                  ..add(AuthStarted());
              },
            )
          ],
          child: MaterialApp(
            title: 'My Shopping List',
            theme: basicTheme,
            onGenerateRoute: RouterGenerator.generateRoute,
            initialRoute: Routes.landing,
          ),
        ));
  }
}
