import 'package:MyShoppingList/feature/home/model1/category.dart';
import 'package:MyShoppingList/feature/home/model1/product.dart';
import 'package:MyShoppingList/feature/home/ui/widget/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MyShoppingList/feature/home/bloc/index.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductError) {
          return const Center(
            child: Text('failed to fetch posts'),
          );
        }
        if (state is ProductLoaded) {
          if (state.products.isEmpty) {
            return const Center(
              child: Text('no Product'),
            );
          }

          return Container(
            child: DefaultTabController(
              length: state.products.length,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                    child: AppBar(
                      backgroundColor: Colors.blueGrey,
                      bottom: TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.red,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 3.0,
                          unselectedLabelColor: Colors.white,
                          labelColor: Colors.white,
                          isScrollable:
                              state.products.keys.length <= 5 ? false : true,
                          tabs: state.products.keys.map((String category) {
                            return Container(
                              padding: EdgeInsets.only(bottom: 15.0, top: 15.0),
                              child: Text(
                                category.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList()),
                    ),
                    preferredSize: Size.fromHeight(50.0)),
                body: TabBarView(
                  controller: _tabController,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: state.products.values.map((List<Product> product) {
                    return StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: product.length,
                        itemBuilder: (BuildContext context, int index) =>
                            ProductWidget(product: product[index]),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.fit(2));
                  }).toList(),
                ),
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
