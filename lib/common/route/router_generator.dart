import 'package:MyShoppingList/common/route/route.dart';
import 'package:MyShoppingList/feature/home/model1/product.dart';
import 'package:MyShoppingList/feature/home/ui/screen/home_page.dart';
import 'package:MyShoppingList/feature/home/ui/widget/product_detail.dart';
import 'package:MyShoppingList/feature/landing/landing_page.dart';
import 'package:MyShoppingList/feature/profile/ui/screen/profile_page.dart';
import 'package:MyShoppingList/feature/signin_signup/resource/index.dart';
import 'package:MyShoppingList/feature/signin_signup/ui/sign_in_page.dart';
import 'package:MyShoppingList/feature/signin_signup/ui/sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings;

    switch (args.name) {
      case Routes.landing:
        return MaterialPageRoute(builder: (_) => LandingPage());

      case Routes.signIn:
        if (args.arguments is AuthRepository) {
          return MaterialPageRoute<dynamic>(
              builder: (_) => SignInPage(authRepository: args.arguments));
        }
        return _errorRoute();

      case Routes.signUp:
      if (args.arguments is AuthRepository) {
        return MaterialPageRoute<dynamic>(
            builder: (_) => SignUpPage(authRepository: args.arguments));
      }
      return _errorRoute();
      case Routes.home:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.blueGrey,
                  title: const Text('Home', style: TextStyle(
                      color: Colors.white
                  )),
                  iconTheme: new IconThemeData(color: Colors.white),
                ),
                body: HomePage()));
      case Routes.profile:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.blueGrey,
                  title: const Text('Profile', style: TextStyle(
                      color: Colors.white
                  )),
                  iconTheme: new IconThemeData(color: Colors.white),
                ),
                body: ProfilePage()));
      case Routes.profileDetail:
        if (args.arguments is Product) {
        return MaterialPageRoute<dynamic>(
            builder: (_) => Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.blueGrey,
                  title: const Text('Detail',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                  iconTheme: new IconThemeData(color: Colors.white),
                ),
                body: ProductDetail(product: args.arguments,)));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
