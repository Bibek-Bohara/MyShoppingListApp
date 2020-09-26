import 'dart:async';

import 'package:MyShoppingList/common/http/response.dart';
import 'package:MyShoppingList/feature/home/resource/home_repository.dart';
import 'package:MyShoppingList/feature/order/model/order.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final HomeRepository homeRepository;

  OrderBloc({@required this.homeRepository})
      : assert(homeRepository != null),
        super(OrderEmpty());

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    final OrderState currentState = state;
    if (event is FetchOrders){
      try {
        if (currentState is OrderEmpty) {
          yield OrderLoading();
          final response  = await homeRepository.fetchOrders();
          print(response);
          if (response.status == Status.Success) {
            yield OrderLoaded(items: response.data);
          }
          return;
        }
        if (currentState is OrderLoaded) {
          yield OrderLoading();
          final response = await homeRepository.fetchOrders();
          yield currentState.items.isEmpty ? OrderLoaded(items: response.data)
          :OrderLoaded().copyWith(items: response.data);
        }
      } catch (e) {
        print(e);
        yield OrderError();
      }
    }
  }
}
