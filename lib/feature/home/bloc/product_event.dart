part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends ProductEvent {}

class Search extends ProductEvent {
  final String query;

  Search({this.query});

}

class AddToCart extends ProductEvent {
  final Product product;

  const AddToCart({
    @required this.product
  });

  @override
  List<Object> get props => [product];
}

class BackPress extends ProductEvent{}