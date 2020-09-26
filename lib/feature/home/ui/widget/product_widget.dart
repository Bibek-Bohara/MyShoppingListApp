import 'package:MyShoppingList/common/constant/env.dart';
import 'package:MyShoppingList/common/route/route.dart';
import 'package:MyShoppingList/feature/home/model1/product.dart';
import 'package:MyShoppingList/feature/home/ui/widget/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String baseUrl = RepositoryProvider.of<Env>(context).baseUrl;
    return Padding(
        padding:
            EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
        child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.profileDetail,
                  arguments: product);
            },
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  product.picture == null
                      ? Container(
                          height: 140.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              shape: BoxShape.rectangle),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("No Image")))
                      : Container(
                          height: 140.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              shape: BoxShape.rectangle,
                              color: Colors.grey,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(baseUrl +
                                          product?.picture?.formats?.thumbnail
                                              ?.url ??
                                      product.picture.url))),
                        ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      product.name,
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      "Price: " + product.price.toString(),
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                    ),
                  )
                ],
              ),
            )));
  }
}
