import 'dart:async';

import 'package:MyShoppingList/common/http/response.dart';
import 'package:MyShoppingList/feature/cart/model/cart.dart';
import 'package:MyShoppingList/feature/home/resource/home_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final HomeRepository homeRepository;

  CartBloc({@required this.homeRepository})
      : assert(homeRepository != null),
        super(CartEmpty());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    final CartState currentState = state;
      if (event is FetchCart){
        try {
          if (currentState is CartEmpty) {
            yield CartLoading();
            final response  = await homeRepository.fetchCartItem();
            print(response);
            if (response.status == Status.Success) {
              yield CartLoaded(items: response.data);
            }
            return;
          }
          if (currentState is CartLoaded) {
            yield CartLoading();
            final response = await homeRepository.fetchCartItem();
            yield CartLoaded(items:response.data);
          }
        } catch (e) {
          print(e);
          yield CartError();
        }
      }

      if (event is DeleteItem){
        // yield CartLoading();
        final response = await homeRepository.deleteCartItem(event.item);
        print(response.data);
        yield ItemRemoved(response.data);
      }
  }
}
