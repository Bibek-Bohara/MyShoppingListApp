import 'package:MyShoppingList/feature/cart/cart_page.dart';
import 'package:MyShoppingList/feature/home/navigation/index.dart';
import 'package:MyShoppingList/feature/home/ui/screen/product_page.dart';
import 'package:MyShoppingList/feature/home/ui/screen/profile_home_page_main.dart';
import 'package:MyShoppingList/feature/home/ui/screen/search_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = BottomNavigationBloc();
    return BlocProvider(
        create: (context) =>  bloc..add(AppStarted()),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:  Theme.of(context).primaryColor,
            title: const Text('MyShoppingList'),
          ),
          body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
            builder: (context, state) {
              if (state is PageLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CurrentIndexChanged) {

                switch (state.currentIndex) {
                  case 0:
                    return ProductPage();
                  case 1:
                    return SearchPage();
                    break;
                  case 2:
                    return CartPage();
                    break;
                  case 3:
                    return ProfileHomePageMain();
                }
                return Container();
              }

              return Container();
            },
          ),
          bottomNavigationBar:
          BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
              builder: (BuildContext context, BottomNavigationState state) {
                return CurvedNavigationBar(
                  height: 64.0 ,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  color: Theme.of(context).primaryColor,
                  buttonBackgroundColor: Theme.of(context).primaryColor,
                  animationCurve: Curves.linearToEaseOut,
                  animationDuration: Duration(milliseconds: 300),
                  index:
                  BlocProvider.of<BottomNavigationBloc>(context).currentIndex,
                  items: const <Widget>[
                    Icon(Icons.home, color: Colors.white),
                    Icon(Icons.search, color:Colors.white),
                    Icon(Icons.shopping_cart, color:Colors.white),
                    Icon(Icons.person, color: Colors.white)
                  ],
                  onTap: (index) => BlocProvider.of<BottomNavigationBloc>(context)
                      .add(PageTapped(index: index)),
                );
              }),
        ));
  }
}
