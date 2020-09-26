import 'dart:io';

import 'package:MyShoppingList/common/constant/env.dart';
import 'package:MyShoppingList/feature/cart/bloc/cart_bloc.dart';
import 'package:MyShoppingList/feature/cart/model/cart.dart';
import 'package:MyShoppingList/feature/cart/stripe_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartWidget extends StatefulWidget {
  @override
  _CartWidgetState createState() => _CartWidgetState();
}


class _CartWidgetState extends State<CartWidget> {
  List<Cart> cartItem;

  void _deleteItem(Cart item) {
    BlocProvider.of<CartBloc>(context).add(DeleteItem(item));
  }

  void _reload(){
    BlocProvider.of<CartBloc>(context).add(FetchCart());
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
    listener: (context, state){
       if (state is ItemRemoved){
          cartItem.removeWhere((element) => element.id == state.item.id);
       }
    },
    child:BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      if (state is CartEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is CartError) {
        return const Center(
          child: Text('failed to fetch Items'),
        );
      }


      if ((state is CartLoaded) || state is ItemRemoved) {
        if (state is CartLoaded){
          cartItem = state.items;
        }
        if (cartItem.isEmpty){
          return const Center(
            child: Text('no Product'),
          );
        }

      return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        body: Builder(
          builder: (context) {
            return ListView(
              children: <Widget>[
                createHeader(),
                createSubTitle(),
                createCartList(),
                footer(context)
              ],
            );
          },
        ),
      );}
      return const Center(
        child: CircularProgressIndicator(),
      );
    }));
  }

  footer(BuildContext context) {
    double counter = 0;
    cartItem.forEach((element) {counter+=element.count*element.product.price;});
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "Total",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: Text(
                  "\$$counter",
                  style: TextStyle(
                      color: Colors.greenAccent.shade700, fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => StripePayment())).then((val)=> _reload());
            },
            color: Colors.green,
            padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Text(
              "Checkout",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
      margin: EdgeInsets.only(top: 16),
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "SHOPPING CART",
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      margin: EdgeInsets.only(left: 12, top: 12),
    );
  }

  createSubTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Total(${cartItem.length}) Items",
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      margin: EdgeInsets.only(left: 12, top: 4),
    );
  }

  createCartList() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, position) {
        return createCartListItem(cartItem[position]);
      },
      itemCount: cartItem.length,
    );
  }

  createCartListItem(Cart item) {
    String baseUrl = RepositoryProvider.of<Env>(context).baseUrl;
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              item.product.picture == null
                  ? Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius:
                      BorderRadius.all(Radius.circular(2.0)),
                      shape: BoxShape.rectangle),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text("No Image",textAlign: TextAlign.center, style: TextStyle(color: Colors.white),))
              ):
              Container(
                margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    color: Colors.blue.shade200,
                    image: DecorationImage(
                        image: NetworkImage(baseUrl + item.product?.picture?.formats?.thumbnail?.url??item.product.picture.url))),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          item.product.name,
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "\$${item.product.price * item.count}",
                              style: TextStyle(color: Colors.green),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.remove,
                                    size: 24,
                                    color: Colors.grey.shade700,
                                  ),
                                  Container(
                                    color: Colors.grey.shade200,
                                    padding: const EdgeInsets.only(
                                        bottom: 2, right: 12, left: 12),
                                    child: Text(
                                      "1",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 24,
                                    color: Colors.grey.shade700,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: (){
              _deleteItem(item);
            },
          child:Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 10, top: 8),
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: 20,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.green),
          ),)
        )
      ],
    );
  }
  // void setError(dynamic error) {
  //   _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error.toString())));
  //   setState(() {
  //     _error = error.toString();
  //   });
  // }


}
