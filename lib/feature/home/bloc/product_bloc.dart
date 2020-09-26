import 'dart:async';

import 'package:MyShoppingList/common/http/response.dart';
import 'package:MyShoppingList/feature/home/bloc/index.dart';
import 'package:MyShoppingList/feature/home/model1/category.dart';
import 'package:MyShoppingList/feature/home/model1/product.dart';
import 'package:MyShoppingList/feature/home/resource/home_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final HomeRepository homeRepository;

  ProductBloc({@required this.homeRepository})
      : assert(homeRepository != null),
        super(ProductEmpty());

  @override
  Stream<Transition<ProductEvent, ProductState>> transformEvents(
      Stream<ProductEvent> events, transitionFn) {
    return super.transformEvents(
        events.debounceTime(
          const Duration(milliseconds: 500),
        ),
        transitionFn);
  }

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    final ProductState currentState = state;

    if (event is Fetch) {
      try {
        if (currentState is ProductEmpty) {
          yield ProductLoading();
          final response  = await homeRepository.fetchProducts('');
          print(response);
          if (response.status == Status.Success) {
            yield ProductLoaded(products: groupBy(response.data,(v) => (v.category.name)));
          }
          return;
        }
        if (currentState is ProductLoaded) {
          final products = await homeRepository.fetchProducts('');
          yield ProductLoaded(products: groupBy(products.data,(v) => (v.category.name)));
        }
      } catch (e) {
        print(e);
        yield ProductError();
      }
    }

    if (event is  AddToCart){
      try {
        yield ProductLoading();
        var response = await homeRepository.addToCart(event.product);
        print('My respones' + response.toString());
        if (response.data != null ){
          yield AddedToCart();
        }else {
          yield AlreadyInCart();
        }
      }catch(e){
        print('My respones' + e.toString());
        yield AlreadyInCart();
      }
    }

    if (event is Search) {
      try {
        if (currentState is ProductEmpty) {
          yield ProductLoading();
          final response  = await homeRepository.fetchProducts(event.query);
          print(response);
          if (response.status == Status.Success) {
            yield ProductSearched(products:response.data);
          }
          return;
        }
        if (currentState is ProductLoaded) {
          final products = await homeRepository.fetchProducts('');
          yield ProductSearched(products: products.data);
        }
      } catch (e) {
        print(e);
        yield ProductError();
      }
    }

    if (event is BackPress){
      yield BackPressed();
    }

  }


  //
  // Future<List<Product>> _fetchProducts() async {
  //   final response = await homeRepository.fetchProducts();
  //   if (response.status == Status.ConnectivityError) {
  //     //Internet problem
  //   }
  //   if (response.status == Status.Success) {
  //     return response.data;
  //   }
  //
  //   return [];
  // }

  Map<T, List<S>> groupBy<S, T>(Iterable<S> values, T Function(S) key) {
    var map = <T, List<S>>{};
    for (var element in values) {
      (map[key(element)] ??= []).add(element);
    }
    return map;
  }
}
