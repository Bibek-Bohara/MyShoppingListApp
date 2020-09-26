import 'package:MyShoppingList/feature/authentication/resource/user_repository.dart';
import 'package:MyShoppingList/feature/order/bloc/order_bloc.dart';
import 'package:MyShoppingList/feature/order/widget/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MyShoppingList/common/constant/env.dart';
import 'package:MyShoppingList/common/http/api_provider.dart';
import 'package:MyShoppingList/common/util/internet_check.dart';
import 'package:MyShoppingList/feature/home/resource/home_repository.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          iconTheme: new IconThemeData(color: Colors.white),
          title: Text(
            "My Orders",
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
            create: (context) => OrderBloc(
                homeRepository: HomeRepository(
                    userRepository: RepositoryProvider.of<UserRepository>(context),
                    env: RepositoryProvider.of<Env>(context),
                    apiProvider: RepositoryProvider.of<ApiProvider>(context),
                    internetCheck:
                    RepositoryProvider.of<InternetCheck>(context)))
              ..add(FetchOrders()),
            child: Container(child: OrderWidget())));
  }
}
