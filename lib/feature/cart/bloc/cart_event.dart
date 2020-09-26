part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class FetchCart extends CartEvent{}

class DeleteItem extends CartEvent{
  final Cart item;

  DeleteItem(this.item);

}