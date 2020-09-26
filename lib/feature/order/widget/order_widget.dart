import 'package:MyShoppingList/feature/cart/model/cart.dart';
import 'package:MyShoppingList/feature/order/bloc/order_bloc.dart';
import 'package:MyShoppingList/feature/order/model/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderWidget extends StatefulWidget {
  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {},
        child: BlocBuilder<OrderBloc, OrderState>(
            builder: (BuildContext context, OrderState state) {
          if (state is OrderEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is OrderError) {
            return const Center(
              child: Text('Failed to fetch Items'),
            );
          }

          if (state is OrderLoaded) {
            if (state.items.isEmpty) {
              return const Center(
                child: Text('No Product'),
              );
            }

            return Scaffold(
              resizeToAvoidBottomPadding: false,
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey.shade100,
              body: Builder(
                builder: (context) {
                  state.items.sort((a,b) => b.id.compareTo(a.id));
                  return ListView(
                    children: <Widget>[createOrderList(state.items)],
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }

  Widget createOrderList(List<Order> items) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, position) {
        return GestureDetector(
          onLongPress: (){

          },
        child: createOrderListItem(items[position])
        );
      },
      itemCount: items.length,
    );
  }

  Widget createOrderListItem(Order item) {
    return Card(
      color: item.delivered ? Colors.grey[400] : Colors.grey[200],
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                children: [
                  Text('OrderId : '+item.id.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 64,),
                  Text('Total Amount : \$' + item.amount.toString(), style: TextStyle(fontWeight: FontWeight.bold),)
              ],),
            SizedBox(height: 12,),
            Text('Delivery Address:', style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 4,),
            SizedBox(height: 1, width: MediaQuery.of(context).size.width,child: Container(color: Colors.black26,),),
            SizedBox(height: 4,),
            Text('City : '+ item.city),
            Text('Address : '+ item.address),
            SizedBox(height: 12,),
            Text('Ordered Product:', style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 4,),
            SizedBox(height: 1, width: MediaQuery.of(context).size.width,child: Container(color: Colors.black26,),),
            SizedBox(height: 4,),
            createProductList(item.cart),
            item.delivered ? SizedBox(height: 4,) : Container(),
            item.delivered ? Text('Delivered', style: TextStyle(
              fontWeight: FontWeight.bold,
            ),): Container()
          ],
        ),
      ),
    );
  }

  Widget createProductList(List<Cart> cart){
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, position) {
        return createProductListItem(cart[position], position+1);
      },
      itemCount: cart.length,
    );
  }

  Widget createProductListItem(Cart item, int index ) {
    return  Container(
        padding: EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Item : '+ index.toString()),
            Text('Product : ' + item.product.name.toString()),
            Row(
              children: [
                Text('Price : \$' + item.product.price.toString() + '/pc'),
                SizedBox(width: 64,),
                Text('No Of Item : ' + item.count.toString()),
              ],),
          ],
        ),
      );
  }

}




