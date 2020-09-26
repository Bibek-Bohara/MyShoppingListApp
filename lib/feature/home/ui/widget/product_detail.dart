import 'package:MyShoppingList/common/constant/env.dart';
import 'package:MyShoppingList/common/http/api_provider.dart';
import 'package:MyShoppingList/common/util/internet_check.dart';
import 'package:MyShoppingList/feature/authentication/resource/user_repository.dart';
import 'package:MyShoppingList/feature/home/bloc/index.dart';
import 'package:MyShoppingList/feature/home/model1/product.dart';
import 'package:MyShoppingList/feature/home/resource/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  Product product;

  ProductDetail({this.product});

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

class _ProductDetailState extends State<ProductDetail> {
  Product product;

  _ProductDetailState(this.product);

  _addToCart(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(AddToCart(product: product));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(
                homeRepository: HomeRepository(
                    env: RepositoryProvider.of<Env>(context),
                    apiProvider: RepositoryProvider.of<ApiProvider>(context),
                    internetCheck:
                        RepositoryProvider.of<InternetCheck>(context),
                    userRepository:
                        RepositoryProvider.of<UserRepository>(context))),
            child: detail()));
  }

  Widget detail() {
    return BlocListener<ProductBloc, ProductState>(listener: (BuildContext context, ProductState state){
      if (state is BackPressed){
        Navigator.of(context).pop();
      }

      if (state is AlreadyInCart){
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Already Added to the Cart'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  },
                ),
              ],
            );
          },
        );
        }

        if (state is AddedToCart){
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            // false = user must tap button, true = tap outside dialog
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text('Added to the Cart'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      BlocProvider.of<ProductBloc>(context).add(BackPress());
                      Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                    },
                  ),
                ],
              );
            },
          );
        }
    },
    child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      return ListView(
        children: <Widget>[
            bannerImage(context, state),
            property(),
            Container(
              child: Markdown(
                data: product.description,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            )
        ]
      );
    }));
  }

  Widget bannerImage(BuildContext context, ProductState state,) {
    String baseUrl = RepositoryProvider.of<Env>(context).baseUrl;
    return Container(
      child: Stack(
        children: <Widget>[
          product.picture == null
              ? Container(
            height: MediaQuery.of(context).size.height / 2.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius:
                BorderRadius.all(Radius.circular(2.0)),
                shape: BoxShape.rectangle),
            child: Align(
              alignment: Alignment.center,
                child: Text("No Image")
            )
          ):
          Container(
            height: MediaQuery.of(context).size.height / 2.2,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.grey,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(baseUrl + product.picture.url))),
          ),
          Positioned(
              bottom: 10,
              right: 10,
              child: state is! ProductLoading ? RaisedButton(
                onPressed: () {
                  if (state is! ProductLoading){
                    _addToCart(context);
                  }else {
                    null;
                  }
                },
                color: Colors.blue,
                child: Text('Add to Cart',
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ): CircularProgressIndicator())
        ],
      ),
    );
  }

  Widget property() {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              product.name,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(r"$" + product.price.toString(),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold))
          ]),
        ],
      ),
    );
  }
}
