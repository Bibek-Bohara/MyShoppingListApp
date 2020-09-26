part of 'order_bloc.dart';

@immutable
abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> items;

  const OrderLoaded({this.items});

  OrderLoaded copyWith({List<Order> items}) {
    return OrderLoaded(items: items);
  }

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'ItemLoaded : ${items.length}';
}

class OrderEmpty extends OrderState {}

class OrderLoading extends OrderState {}

class OrderError extends OrderState {}
