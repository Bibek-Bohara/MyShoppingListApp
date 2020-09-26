part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

class ProductEmpty extends ProductState {}

class ProductLoading extends ProductState {}

class ProductError extends ProductState {}

class ProductLoaded extends ProductState {
  final Map<String,List<Product>> products;

  const ProductLoaded({this.products});

  ProductLoaded copyWith({Map<String,List<Product>> products}) {
    return ProductLoaded(products: products);
  }

  @override
  List<Object> get props => [products];

  @override
  String toString() => 'ProductLoaded { keys: ${products.keys} values: ${products.values} }';
}
class AddedToCart extends ProductState{}
class AlreadyInCart extends ProductState{}

class ProductSearched extends ProductState {
  final List<Product> products;

  const ProductSearched({this.products});

  @override
  List<Object> get props => [products];

  @override
  String toString() => 'ProductSearched { len: ${products.length} }';
}

class BackPressed extends ProductState{}