import 'package:MyShoppingList/common/constant/env.dart';
import 'package:MyShoppingList/common/route/route.dart';
import 'package:MyShoppingList/feature/home/bloc/index.dart';
import 'package:MyShoppingList/feature/home/model1/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => new _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController controller = new TextEditingController();
  List<Product> _searchResult = [];
  List<Product> _productDetails = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (BuildContext context, ProductState state) {
          if (state is ProductSearched){
            _productDetails.addAll(state.products);
          }
      },
      child: BlocBuilder<ProductBloc, ProductState>(
          builder: (BuildContext context, ProductState state) {
            return Scaffold(
              body: new Column(
                children: <Widget>[
                  new Container(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    child: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Card(
                        child: new ListTile(
                          leading: new Icon(Icons.search),
                          title: new TextField(
                            autofocus: true,
                            controller: controller,
                            decoration: new InputDecoration(
                                hintText: 'Search', border: InputBorder.none),
                            onChanged: onSearchTextChanged,
                          ),
                          trailing: new IconButton(
                            icon: new Icon(Icons.cancel),
                            onPressed: () {
                              controller.clear();
                              onSearchTextChanged('');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  _productDetails.length > 0 ? new Expanded(
                    child: _searchResult.length != 0 ||
                        controller.text.isNotEmpty
                        ? new ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, i) {
                        return new GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, Routes.profileDetail,
                                arguments: _searchResult[i]);
                          },
                            child: Card(
                          child: new ListTile(
                            leading: _searchResult[i].picture != null ? CircleAvatar(
                              backgroundImage: new NetworkImage(
                                RepositoryProvider
                                    .of<Env>(context)
                                    .baseUrl +
                                    _searchResult[i].picture?.formats?.thumbnail
                                        ?.url??_searchResult[i].picture.name,
                              ),
                            ): CircleAvatar(backgroundColor: Theme.of(context).primaryColor,),
                            title: new Text(_searchResult[i].name),
                          ),
                          margin: const EdgeInsets.all(0.0),
                        ),);
                      },
                    )
                        : new ListView.builder(
                      itemCount: _productDetails.length,
                      itemBuilder: (context, index) {
                        return new GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, Routes.profileDetail,
                                arguments: _productDetails[index]);
                          },
                            child: Card(
                          child: new ListTile(
                            leading: _productDetails[index].picture != null ?  CircleAvatar(
                              backgroundImage: new NetworkImage(
                                RepositoryProvider
                                    .of<Env>(context)
                                    .baseUrl +
                                    _productDetails[index].picture?.formats
                                        ?.thumbnail?.url??_productDetails[index].picture.name,
                              ),
                            ): CircleAvatar(backgroundColor: Theme.of(context).primaryColor,),
                            title: new Text(_productDetails[index].name),
                          ),
                          margin: const EdgeInsets.all(0.0),
                        ),);
                      },
                    ),
                  ): Text('No Product'),
                ],
              ),
            );
          }),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _productDetails.forEach((productDetail) {
      if (productDetail.name.contains(text)) _searchResult.add(productDetail);
    });

    setState(() {});
  }
}


