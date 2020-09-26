import 'package:MyShoppingList/common/constant/env.dart';
import 'package:MyShoppingList/common/http/api_provider.dart';
import 'package:MyShoppingList/common/util/internet_check.dart';
import 'package:MyShoppingList/common/widget/loading_widget.dart';
import 'package:MyShoppingList/feature/authentication/bloc/index.dart';
import 'package:MyShoppingList/feature/home/ui/screen/home_page.dart';
import 'package:MyShoppingList/feature/landing/splash_page.dart';
import 'package:MyShoppingList/feature/signin_signup/resource/index.dart';
import 'package:MyShoppingList/feature/signin_signup/ui/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return const CircularProgressIndicator();
          }

          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }

          if (state is AuthenticationUnauthenticated) {
            return SignInPage(
                authRepository: AuthRepository(
                    apiProvider: RepositoryProvider.of<ApiProvider>(context),
                    internetCheck:
                        RepositoryProvider.of<InternetCheck>(context),
                    env: RepositoryProvider.of<Env>(context)));
          }
          return SplashPage();
        });
  }
}
