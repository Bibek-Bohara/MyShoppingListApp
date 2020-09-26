part of 'cart_bloc.dart';

@immutable
abstract class CartState extends Equatable{
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<Cart> items;

  const CartLoaded({this.items});

  CartLoaded copyWith({List<Cart> items}) {
    return CartLoaded(items: items);
  }

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'ItemLoaded : ${items.length}';
}

class CartEmpty extends CartState {}

class CartLoading extends CartState {}

class CartError extends CartState {}

class ItemRemoved extends CartState{
  final Cart item;

  ItemRemoved(this.item);

  @override
  List<Object> get props => [item];
}


